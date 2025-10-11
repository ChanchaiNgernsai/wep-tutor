package com.springmvc.Controller;

import java.io.IOException;
import java.util.Date;

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

    private static final String OMISE_SECRET_KEY = "skey_test_65bj01bb1dw57i15792";
    private static final String OMISE_PUBLIC_KEY = "pkey_test_65bj01awim1ab9eq267";

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
        mav.addObject("publicKey", OMISE_PUBLIC_KEY);
        return mav;
    }

    @RequestMapping(value = "/addDeposit", method = RequestMethod.POST)
    public ModelAndView addDeposit(HttpServletRequest request, HttpSession session) throws IOException {
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
                    .publicKey(OMISE_PUBLIC_KEY)
                    .secretKey(OMISE_SECRET_KEY)
                    .build();

            Source source = client.sendRequest(
                    new Source.CreateRequestBuilder()
                            // .type("promptpay") // SDK รุ่น 4.x ใช้ String "promptpay"
                            .type(SourceType.valueOf("PROMPTPAY"))
                            .amount(amount.longValue() * 100L) // บาท → สตางค์
                            .currency("thb")
                            .build());

            // สร้าง Charge โดยใช้ source.id
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
                mav.addObject("error", "ไม่สามารถสร้าง QR ได้");
                return mav;
            }

        } catch (Exception e) {
            ModelAndView mav = new ModelAndView("Deposit");
            mav.addObject("error", "เกิดข้อผิดพลาดในการสร้าง QR: " + e.getMessage());
            return mav;
        }

        // บันทึก Transaction
        Transaction tran = new Transaction();
        tran.setDeposit(amount);
        tran.setDepositDate(new Date());
        tran.setTranType("PromptPay");
        tran.setUser(user);

        TutorManager tmg = new TutorManager();
        tmg.insertDeposit(tran);

        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("Deposit");
        mav.addObject("balance", balance);
        mav.addObject("qrUrl", qrUrl);
        mav.addObject("msg_result", "สร้าง QR สำเร็จ กรุณาสแกนจ่ายผ่าน PromptPay");
        return mav;
    }
}
