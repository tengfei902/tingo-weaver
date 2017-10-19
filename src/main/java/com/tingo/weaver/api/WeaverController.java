package com.tingo.weaver.api;

import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.model.gson.QingdanGson;
import com.tingo.weaver.model.gson.TableGson;
import com.tingo.weaver.model.gson.ZcListRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;

import java.util.List;

/**
 * Created by user on 17/9/27.
 */
@Controller
@RequestMapping("/weaver")
public class WeaverController {
    @Autowired
    private KpService kpService;

//    @RequestMapping(value = "/getQingdanList",method = RequestMethod.GET)
//    public @ResponseBody String getQdDetail(Integer jd) {
//        List<QingdanGson> list = kpService.selectQdList(jd);
//        return new Gson().toJson(list);
//    }

    @RequestMapping(value = "/getQingdanList",method = RequestMethod.GET,produces = "text/json;charset=UTF-8")
    public @ResponseBody String getQingdanList(Integer jd) {
        List<QingdanGson> list = kpService.selectQdList(jd);
        return new Gson().toJson(list);
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
        return null;
    }
}
