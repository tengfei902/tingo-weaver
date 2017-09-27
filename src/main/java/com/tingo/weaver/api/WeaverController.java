package com.tingo.weaver.api;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * Created by user on 17/9/27.
 */
@Controller
@RequestMapping("/weaver")
public class WeaverController {

    @RequestMapping(value = "/test",method = RequestMethod.GET)
    public @ResponseBody String test() {
        System.out.println("----------------");
        return "213456";
    }

    @RequestMapping(value = "/test2",method = RequestMethod.GET)
    public void test2() {
        System.out.println("----------------");
    }
}
