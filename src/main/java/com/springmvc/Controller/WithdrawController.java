package com.springmvc.Controller;

import java.util.Date;
import java.util.Locale;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.MessageSource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.springmvc.model.Transaction;
import com.springmvc.model.TutorManager;
import com.springmvc.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class WithdrawController {

    @Autowired
    private MessageSource messageSource;

    @RequestMapping(value = "/goWithdraw", method = RequestMethod.GET)
    public ModelAndView loadWithdrawPage(HttpSession session) {
        User user = (User) session.getAttribute("User");

        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            String errorMessage = messageSource.getMessage("general.error.login_first_withdraw", null,
                    Locale.getDefault());
            mav.addObject("err_login", errorMessage);
            return mav;
        }

        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalanceByTutor(user.getEmail());

        ModelAndView mav = new ModelAndView("RequesWithdraw");
        mav.addObject("balance", balance);
        return mav;
    }

    @RequestMapping(value = "/requesWithdraw", method = RequestMethod.POST)
    public ModelAndView handleWithdrawRequest(HttpServletRequest request, HttpSession session) {
        String bankType = request.getParameter("bankType");
        String bankAccount = request.getParameter("bankAccount");

        User user = (User) session.getAttribute("User");
        TutorManager tmg = new TutorManager();

        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            String errorMessage = messageSource.getMessage("general.error.login_first_withdraw", null,
                    Locale.getDefault());
            mav.addObject("err_login", errorMessage);
            return mav;
        }

        double balance = tmg.getBalanceByTutor(user.getEmail());

        ModelAndView mav = new ModelAndView("RequesWithdraw");
        mav.addObject("balance", balance);
        mav.addObject("bankAccount", bankAccount);
        mav.addObject("bankType", bankType);

        double amount = Double.parseDouble(request.getParameter("amount"));
        mav.addObject("amount", amount);

        if (amount <= 0) {
            mav.addObject("err_result", "กรุณากรอกจำนวนเงินที่ถูกต้อง");
        } else if (amount > balance) {
            mav.addObject("err_result", "จำนวนเงินเกินยอดคงเหลือ");
        } else {

            Transaction transaction = new Transaction();
            transaction.setWithdraw(amount);
            transaction.setWithdrawDate(new Date());
            transaction.setUser(user);
            transaction.setAccountNumber(bankAccount);
            transaction.setTranType("คำขอถอนเงิน " + bankType);
            transaction.setWithdrawStatus(1); // 1 = รออนุมัติ

            boolean result = tmg.updateWithdraw(transaction);

            if (result) {
                mav.addObject("msg_result", "ส่งคำขอถอนเงินเรียบร้อยแล้ว ระบบจะดำเนินการตรวจสอบ");
            } else {
                mav.addObject("err_result", "เกิดข้อผิดพลาดในการส่งคำขอถอน กรุณาลองใหม่");
            }
        }
        return mav;
    }

}
