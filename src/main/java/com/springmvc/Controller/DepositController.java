package com.springmvc.Controller;

import java.io.IOException;
import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import co.omise.Client;
import co.omise.models.Charge;
import co.omise.models.Source;
import co.omise.models.SourceType;

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
        return secretKey != null ? secretKey : "skey_test_xxxxxxxxxxxxxxxxxxxx";
    }

    private static String getOmisePublicKey() {
        String publicKey = System.getenv("OMISE_PUBLIC_KEY");
        return publicKey != null ? publicKey : "pkey_test_xxxxxxxxxxxxxxxxxxxx";
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
                            .description("Deposit for " + user.getEmail())
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
        mav.addObject("msg_result", messageSource.getMessage("msg_result", null, Locale.forLanguageTag("th-TH")));
        return mav;
    }

    @RequestMapping(value = "/addDeposit", method = RequestMethod.POST)
    public ModelAndView addDeposit(HttpServletRequest request, HttpSession session) {
        Double amount = Double.parseDouble(request.getParameter("amount"));
        User user = (User) session.getAttribute("User");

        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนทำรายการฝากเงิน");
            return mav;
        }

        Transaction tran = new Transaction();
        tran.setDeposit(amount);
        tran.setDepositDate(new Date());
        tran.setUser(user);

        TutorManager tmg = new TutorManager();
        tmg.insertDeposit(tran);
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("Deposit");
        mav.addObject("amount", amount);
        mav.addObject("balance", balance);
        mav.addObject("msg_result", messageSource.getMessage("msg_result", null, Locale.forLanguageTag("th-TH")));
        return mav;
    }

}
