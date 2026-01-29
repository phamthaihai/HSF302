package com.example.controller;

import com.example.model.Cart;
import com.example.model.User;
import com.example.service.PaymentService;
import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class CheckoutController {

    private final PaymentService paymentService;

    public CheckoutController(PaymentService paymentService) {
        this.paymentService = paymentService;
    }

    @PostMapping("/checkout")
    public String checkout(
            @RequestParam("method") String method,
            HttpSession session
    ) {
        Integer userId = (Integer) session.getAttribute("currentUserId");
        Cart cart = (Cart) session.getAttribute("CART");

        if (userId == null) {
            return "redirect:/login";
        }

        if (cart == null || cart.getItems().isEmpty()) {
            return "redirect:/cart/view";
        }

        paymentService.payFromCart(userId, cart, method);

        cart.clear();
        session.setAttribute("CART", cart);

        return "redirect:/payment/success";
    }


}
