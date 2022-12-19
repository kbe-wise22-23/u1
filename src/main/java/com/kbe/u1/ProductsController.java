package com.kbe.u1;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;


@RestController
public class ProductsController {

    @GetMapping("/products")
    public String products() {
        return "hello";
    }
}
