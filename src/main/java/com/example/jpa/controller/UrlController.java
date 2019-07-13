package com.example.jpa.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class UrlController {

    @RequestMapping("/admin/{html}")
    public String toHtml(@PathVariable String html){
        return "admin/"+html;
    }
    @RequestMapping("/admin/views/{html}")
    public String toViewsHtml(@PathVariable String html){
        return "admin/views/"+html;
    }
}
