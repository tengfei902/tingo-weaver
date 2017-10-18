package com.tingo.weaver.api;

import com.tingo.weaver.model.gson.TableGson;
import com.tingo.weaver.model.gson.ZcListRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;

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

    @RequestMapping(value = "/getPageInfo",method = RequestMethod.GET)
    public @ResponseBody String getPageInfo(String pageName) {
        TableGson tableGson = new TableGson();
        tableGson.setTitle("action test");
        tableGson.setTitle(pageName);
        tableGson.setBody("body test");
        tableGson.setHeader("header test");

        return new Gson().toJson(tableGson);
    }

    @RequestMapping(value = "/zc/getZcList",method = RequestMethod.GET)
    public @ResponseBody String getZcList(ZcListRequest zcRequest) {

    }
}
