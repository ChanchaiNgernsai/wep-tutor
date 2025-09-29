package com.springmvc.Controller;

import java.util.Date;

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

    @RequestMapping(value = "/goWithdraw", method = RequestMethod.GET)
    public ModelAndView loadWithdrawPage(HttpSession session) {
        User user = (User) session.getAttribute("User");

        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนเข้าหน้าถอนเงิน");
            return mav;
        }

        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("RequesWithdraw");
        mav.addObject("balance", balance);
        return mav;
    }

    @RequestMapping(value = "/requesWithdraw", method = RequestMethod.POST)
    public ModelAndView handleWithdrawRequest(HttpServletRequest request, HttpSession session) {
        String bankType = request.getParameter("bankType");
        String bankAccount = request.getParameter("bankAccount");

        User user = (User) session.getAttribute("User");
        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนเข้าหน้าถอนเงิน");
            return mav;
        }

        double amount = Double.parseDouble(request.getParameter("amount"));
        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("RequesWithdraw");
        mav.addObject("balance", balance);
        mav.addObject("amount", amount);

        if (amount <= 0) {
            mav.addObject("err_result", "กรุณากรอกจำนวนเงินที่ถูกต้อง");
        } else if (amount > balance) {
            mav.addObject("err_result", "ยอดเงินไม่เพียงพอ");
        } else {

            Transaction transaction = new Transaction();
            transaction.setWithdraw(amount);
            transaction.setWithdrawDate(new Date());
            transaction.setUser(user);
            transaction.setAccountNumber(bankAccount);
            transaction.setTranType("ถอนเงินผ่านธนาคาร " + bankType);

            boolean result = tmg.updateWithdraw(transaction);

            if (result) {

                balance = tmg.getBalance(user.getEmail());
                mav.addObject("balance", balance);
                mav.addObject("msg_result", "ถอนเงินสำเร็จ");
            } else {
                mav.addObject("err_result", "ถอนเงินไม่สำเร็จ กรุณาลองอีกครั้ง");
            }
        }

        return mav;

    }

}
