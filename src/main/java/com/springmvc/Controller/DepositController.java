package com.springmvc.Controller;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.util.Date;

import javax.imageio.ImageIO;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.common.BitMatrix;
import com.springmvc.model.Transaction;
import com.springmvc.model.TutorManager;
import com.springmvc.model.User;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class DepositController {

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
        return mav;
    }

    // ฟังก์ชันสร้าง QR
    @RequestMapping(value = "/generateQR", method = RequestMethod.POST)
    public ModelAndView generateQR(HttpServletRequest request, HttpSession session)
            throws WriterException, IOException {
        Double amount = Double.parseDouble(request.getParameter("amount"));
        User user = (User) session.getAttribute("User");

        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนทำรายการฝากเงิน");
            return mav;
        }

        String payload = generatePromptPayPayload("66654749437", amount); // PromptPay ID หรือเบอร์จริง
        String fileName = generateQRCode(payload); // คืนเฉพาะชื่อไฟล์
        TutorManager tmg = new TutorManager();
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("Deposit");
        mav.addObject("qrCodeFileName", fileName); // JSP จะใช้ /img_deposit/${qrCodeFileName}
        mav.addObject("amount", amount);
        mav.addObject("msg_gen", "กรุณาสแกน QR Code เพื่อชำระเงิน");
        mav.addObject("balance", balance);
        return mav;
    }

    // ฟังก์ชันยืนยันฝากเงิน
    @RequestMapping(value = "/addDeposit", method = RequestMethod.POST)
    public ModelAndView addDeposit(HttpServletRequest request, HttpSession session) {
        Double amount = Double.parseDouble(request.getParameter("amount"));
        User user = (User) session.getAttribute("User");

        if (user == null) {
            ModelAndView mav = new ModelAndView("Login");
            mav.addObject("error", "กรุณาเข้าสู่ระบบก่อนทำรายการฝากเงิน");
            return mav;
        }

        Transaction transaction = new Transaction();
        transaction.setDeposit(amount);
        transaction.setDepositDate(new Date());
        transaction.setUser(user);

        TutorManager tmg = new TutorManager();
        boolean result = tmg.insertDeposit(transaction);

        // ดึง balance ใหม่หลังฝาก
        double balance = tmg.getBalance(user.getEmail());

        ModelAndView mav = new ModelAndView("Deposit");
        mav.addObject("balance", balance);
        if (result) {
            mav.addObject("msg_result", "ฝากเงินสำเร็จ");
        } else {
            mav.addObject("err_result", "ฝากเงินไม่สำเร็จ กรุณาลองอีกครั้ง");
        }
        return mav;
    }

    // ---------------- Utility -----------------
    private String generatePromptPayPayload(String mobile, double amount) {
        DecimalFormat df = new DecimalFormat("0.00");
        String amtStr = df.format(amount);

        // ID Type 01 = Mobile number
        String payload = "00020101021129370016A000000677010111" +
                "0113" + mobile +
                "5303764540" + amtStr + "5802TH";

        // คำนวณ CRC16 แล้วต่อท้าย
        String crc = CRC16CCITT(payload + "6304");
        return payload + "6304" + crc;
    }

    // ตัวอย่างฟังก์ชัน CRC16 (CCITT-FALSE)
    public static String CRC16CCITT(String s) {
        int crc = 0xFFFF;
        for (char c : s.toCharArray()) {
            crc ^= ((int) c) << 8;
            for (int i = 0; i < 8; i++) {
                if ((crc & 0x8000) != 0) {
                    crc = (crc << 1) ^ 0x1021;
                } else {
                    crc <<= 1;
                }
            }
        }
        crc &= 0xFFFF;
        return String.format("%04X", crc);
    }

    private String generateQRCode(String text) throws WriterException, IOException {
        int size = 250;
        QRCodeWriter qrCodeWriter = new QRCodeWriter();
        BitMatrix bitMatrix = qrCodeWriter.encode(text, BarcodeFormat.QR_CODE, size, size);

        BufferedImage image = new BufferedImage(size, size, BufferedImage.TYPE_INT_RGB);
        for (int x = 0; x < size; x++) {
            for (int y = 0; y < size; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) ? 0xFF000000 : 0xFFFFFFFF);
            }
        }

        String uploadDir = "C:/img_deposit/"; // โฟลเดอร์จริงบนเครื่อง
        File dir = new File(uploadDir);
        if (!dir.exists())
            dir.mkdirs();

        String fileName = "qr_" + new Date().getTime() + ".png";
        File qrFile = new File(dir, fileName);
        ImageIO.write(image, "PNG", qrFile);

        return fileName; // คืนเฉพาะชื่อไฟล์
    }
}
