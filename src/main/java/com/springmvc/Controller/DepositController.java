package com.springmvc.Controller;

import java.io.IOException;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.Map;

import co.omise.Client;
import co.omise.models.Charge;
import co.omise.models.Source;
import co.omise.models.SourceType;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springmvc.model.Transaction;
import com.springmvc.model.TutorManager;
import com.springmvc.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class DepositController {

    @Autowired
    private MessageSource messageSource;

    private static String getOmiseSecretKey() {
        String secretKey = System.getenv("OMISE_SECRET_KEY");
        return secretKey != null ? secretKey : "skey_test_xxxxxxxxxxxxxxxxxxx";
    }

    private static String getOmisePublicKey() {
        String publicKey = System.getenv("OMISE_PUBLIC_KEY");
        return publicKey != null ? publicKey : "pkey_test_xxxxxxxxxxxxxxxxxxx";
    }

    @RequestMapping(value = "/goDeposit", method = RequestMethod.GET)
    public ModelAndView loadDepositPage(HttpSession session) {
        User user = (User) session.getAttribute("User");
        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนเข้าหน้าฝากเงิน");
            return mav;
        }

        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("Deposit");
        mav.addObject("balance", balance);
        mav.addObject("publicKey", getOmisePublicKey());
        return mav;
    }

    @RequestMapping(value = "/getQrCode", method = RequestMethod.POST)
    public ModelAndView getQrCodePage(HttpServletRequest request, HttpSession session) throws IOException {
        Double amount = Double.parseDouble(request.getParameter("amount"));
        User user = (User) session.getAttribute("User");

        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนทำรายการฝากเงิน");
            return mav;
        }

        String qrUrl = null;
        try {
            Client client = new Client.Builder()
                    .publicKey(getOmisePublicKey())
                    .secretKey(getOmiseSecretKey())
                    .build();

            Source source = client.sendRequest(
                    new Source.CreateRequestBuilder()
                            .type(SourceType.PromptPay)
                            .amount(amount.longValue() * 100L)
                            .currency("thb")
                            .build());

            Charge charge = client.sendRequest(
                    new Charge.CreateRequestBuilder()
                            .amount(amount.longValue() * 100L)
                            .currency("thb")
                            .description(user.getEmail())
                            .source(source.getId())
                            .build());

            if (charge.getSource() != null && charge.getSource().getScannableCode() != null) {
                qrUrl = charge.getSource().getScannableCode().getImage().getDownloadUri();
            } else {
                ModelAndView mav = new ModelAndView("Deposit");
                mav.addObject("error_qr1",
                        messageSource.getMessage("result_login", null, Locale.forLanguageTag("th-TH")));
                return mav;
            }

        } catch (Exception e) {
            ModelAndView mav = new ModelAndView("Deposit");
            mav.addObject("error_qr2",
                    messageSource.getMessage("error_qr2", null, Locale.forLanguageTag("th-TH")) + e.getMessage());
            return mav;
        }

        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("Deposit");
        mav.addObject("amount", amount);
        mav.addObject("balance", balance);
        mav.addObject("qrUrl", qrUrl);
        mav.addObject("msg_deposit", messageSource.getMessage("msg_deposit", null, Locale.forLanguageTag("th-TH")));
        return mav;
    }

    @ResponseBody
    @RequestMapping(value = "/addDeposit", method = RequestMethod.POST)
    public Map<String, Object> addDeposit(@RequestBody String payloadStr) {
        Map<String, Object> resp = new HashMap<>();
        try {
            ObjectMapper mapper = new ObjectMapper();
            Map<String, Object> payload = mapper.readValue(payloadStr, Map.class);
            Map<String, Object> data = (Map<String, Object>) payload.get("data");

            String description = data.get("description") != null ? data.get("description").toString() : "";
            String status = payload.get("key") != null ? payload.get("key").toString() : "";
            Long amountLong = data.get("amount") != null ? ((Number) data.get("amount")).longValue() : 0L;
            Double amountBaht = amountLong / 100.0;

            System.out.println("Status = " + status + ", Amount = " + amountBaht + ", Description = " + description);

            if ("charge.complete".equalsIgnoreCase(status)) {
                User user = new User();
                user.setEmail(description);

                Transaction tran = new Transaction();
                tran.setUser(user);
                tran.setDeposit(amountBaht);
                tran.setDepositDate(new Date());

                TutorManager tmg = new TutorManager();
                boolean inserted = tmg.insertTransaction(tran);

                if (inserted) {
                    resp.put("success", true);
                    resp.put("message", "Deposit recorded successfully.");
                } else {
                    resp.put("success", false);
                    resp.put("message", "Failed to insert transaction.");
                }
            } else {
                resp.put("success", false);
                resp.put("message", "Payment not completed: " + status);
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.put("success", false);
            resp.put("message", "Error: " + e.getMessage());
        }

        return resp;
    }

    @ResponseBody
    @RequestMapping("/checkDeposit")
    public Map<String, Object> checkDeposit(HttpSession session) {
        Map<String, Object> resp = new HashMap<>();
        User user = (User) session.getAttribute("User");
        if (user != null) {
            TutorManager tmg = new TutorManager();
            double balance = tmg.getBalance(user.getEmail());
            resp.put("balance", balance);

            Transaction lastTran = tmg.getLastDeposit(user.getEmail());
            if (lastTran != null &&
                    !Boolean.TRUE.equals(session.getAttribute("notified_" + lastTran.getTranId()))) {
                resp.put("newDeposit", true);
                resp.put("amount", lastTran.getDeposit());
                session.setAttribute("notified_" + lastTran.getTranId(), true); // บันทึกว่าแจ้งแล้ว
            } else {
                resp.put("newDeposit", false);
            }
        } else {
            resp.put("newDeposit", false);
        }
        return resp;
    }

}
