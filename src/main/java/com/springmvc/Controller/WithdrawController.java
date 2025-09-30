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
            String errorMessage = messageSource.getMessage("general.error.login_first_withdraw", null, Locale.getDefault());
            mav.addObject("err_login", errorMessage);
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
            String errorMessage = messageSource.getMessage("general.error.login_first_withdraw", null, Locale.getDefault());
            mav.addObject("err_login", errorMessage);
            return mav;
        }

        double amount = Double.parseDouble(request.getParameter("amount"));
        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("RequesWithdraw");
        mav.addObject("balance", balance);
        mav.addObject("amount", amount);

        if (amount <= 0) {
            mav.addObject("err_result",
                    "\u0E01\u0E23\u0E38\u0E13\u0E32\u0E01\u0E23\u0E2D\u0E01\u0E08\u0E33\u0E19\u0E27\u0E19\u0E40\u0E07\u0E34\u0E19\u0E17\u0E35\u0E48\u0E16\u0E39\u0E01\u0E15\u0E49\u0E2D\u0E07");
        } else if (amount > balance) {
            mav.addObject("err_result",
                    "\u0E22\u0E2D\u0E14\u0E40\u0E07\u0E34\u0E19\u0E44\u0E21\u0E48\u0E1E\u0E25\u0E07\u0E1E\u0E2D");
        } else {

            Transaction transaction = new Transaction();
            transaction.setWithdraw(amount);
            transaction.setWithdrawDate(new Date());
            transaction.setUser(user);
            transaction.setAccountNumber(bankAccount);
            transaction.setTranType(
                    "\u0E16\u0E2D\u0E19\u0E40\u0E07\u0E34\u0E19\u0E1C\u0E48\u0E32\u0E19\u0E18\u0E19\u0E32\u0E04\u0E32\u0E23 "
                            + bankType);

            boolean result = tmg.updateWithdraw(transaction);

            if (result) {

                balance = tmg.getBalance(user.getEmail());
                mav.addObject("balance", balance);
                mav.addObject("msg_result",
                        "\u0E16\u0E2D\u0E19\u0E40\u0E07\u0E34\u0E19\u0E2A\u0E33\u0E40\u0E23\u0E47\u0E08");
            } else {
                mav.addObject("err_result",
                        "\u0E16\u0E2D\u0E19\u0E40\u0E07\u0E34\u0E19\u0E44\u0E21\u0E48\u0E2A\u0E33\u0E40\u0E23\u0E47\u0E08 \u0E01\u0E23\u0E38\u0E13\u0E32\u0E25\u0E2D\u0E07\u0E2D\u0E35\u0E01\u0E04\u0E23\u0E31\u0E49\u0E07");
            }
        }

        return mav;

    }

}
