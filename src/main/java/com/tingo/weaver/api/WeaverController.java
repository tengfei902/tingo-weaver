package com.tingo.weaver.api;

import com.google.common.reflect.TypeToken;
import com.tingo.weaver.biz.CheckItemService;
import com.tingo.weaver.biz.KpService;
import com.tingo.weaver.biz.ReportService;
import com.tingo.weaver.model.ResponseResult;
import com.tingo.weaver.model.gson.*;
import com.tingo.weaver.model.po.Qingdan;
import com.tingo.weaver.utils.Utils;
import org.apache.commons.lang3.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import com.google.gson.Gson;

import javax.ws.rs.FormParam;
import java.math.BigDecimal;
import java.net.URLDecoder;
import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.logging.Logger;

/**
 * Created by user on 17/9/27.
 */
@Controller
@RequestMapping("/weaver")
public class WeaverController {
    @Autowired
    private KpService kpService;
    @Autowired
    private ReportService reportService;
    @Autowired
    private CheckItemService checkItemService;

    @RequestMapping(value = "/getQingdanList",method = RequestMethod.GET,produces = "text/json;charset=UTF-8")
    public @ResponseBody String getQingdanList(Integer jd) {
        List<QingdanGson> list = kpService.selectQdList(jd);
        return new Gson().toJson(list);
    }

    @RequestMapping(value = "/getQingdanById",method = RequestMethod.GET,produces = "text/json;charset=UTF-8")
    public @ResponseBody String getQingdanById(Integer id) {
        QingdanGson qingdan = kpService.selectQdById(id);
        return new Gson().toJson(qingdan);
    }

    /**
     * 考评项列表 itemList.jsp
     * @param qdId
     * @return
     */
    @RequestMapping(value = "/getCheckItem",method = RequestMethod.GET,produces = "text/json;charset=UTF-8")
    public @ResponseBody String getCheckItem(Long qdId) {
        List<CheckItemGson> list = kpService.getCheckItem(qdId);
        return new Gson().toJson(list);
    }

    @RequestMapping(value = "/getCheckItemByItemId",method = RequestMethod.GET,produces = "text/json;charset=UTF-8")
    public @ResponseBody String getCheckItemByItemId(Long itemId) {
        CheckItemGson checkItemGson = kpService.getCheckItemByItemId(itemId);
        return new Gson().toJson(checkItemGson);
    }

    @RequestMapping(value = "/saveCheckItem",method = RequestMethod.POST,produces = "application/json;charset=UTF-8",consumes = "application/x-www-form-urlencoded")
    public @ResponseBody String saveCheckItem(@RequestBody String itemStr) throws Exception {
        itemStr = URLDecoder.decode(itemStr,"utf-8").replace("=","");
        CheckItemGson checkItemGson = new Gson().fromJson(itemStr,CheckItemGson.class);
        kpService.saveCheckItem(checkItemGson);
        return "SUCCESS";
    }

    @RequestMapping(value = "/getPageInfo",method = RequestMethod.POST)
    public @ResponseBody String getPageInfo(String pageName) {
        TableGson tableGson = new TableGson();
        tableGson.setTitle("action test");
        tableGson.setTitle(pageName);
        tableGson.setBody("body test");
        tableGson.setHeader("header test");

        return new Gson().toJson(tableGson);
    }

    @RequestMapping(value = "/zc/getZcList",method = RequestMethod.GET,produces = "text/json;charset=UTF-8")
    public @ResponseBody String getZcList(ZcListRequest zcRequest) {
        if(!NumberUtils.isNumber(zcRequest.getJd())) {
            zcRequest.setJd(null);
        }
        if(!NumberUtils.isNumber(zcRequest.getQd())) {
            zcRequest.setQd(null);
        }
        if(!NumberUtils.isNumber(zcRequest.getStatus())) {
            zcRequest.setStatus(null);
        }
        List<ZcListGson> list = kpService.getKpZcGson(zcRequest);
        return new Gson().toJson(list);
    }

    @RequestMapping(value = "/doPublish",method = RequestMethod.POST,produces = "application/json;charset=UTF-8",consumes = "application/x-www-form-urlencoded")
    public @ResponseBody ResponseResult<String> doPublish(@RequestBody String str) throws Exception {
        str = URLDecoder.decode(str,"utf-8").replace("=","");
        Map<String,String> request = new Gson().fromJson(str,new TypeToken<Map<String,String>>(){}.getType());
        Long userId = Utils.o2l(request.get("userId"));
        List<String> qdIds = Arrays.asList(request.get("qdIds").split(","));
        Integer jd = Integer.parseInt(request.get("kpMonth"));
        List<String> companyIds = Arrays.asList(request.get("companyIds").split(","));
        String result = kpService.doPublish(userId,qdIds,jd,companyIds);
        return ResponseResult.success("SUCCESS", result);
    }

    @RequestMapping(value = "/saveZp",method = RequestMethod.POST,produces = "application/json;charset=UTF-8",consumes = "application/x-www-form-urlencoded")
    public @ResponseBody String saveZp(@RequestBody String itemStr) throws Exception {
        itemStr = URLDecoder.decode(itemStr,"utf-8").replace("=","");
        Map<String,List<Map<String,String>>> request = new Gson().fromJson(itemStr,new TypeToken<Map<String,List<Map<String,String>>>>(){}.getType());
        kpService.saveZp(request.get("zps"),request.get("details"));
        return "SUCCESS";
    }

    @RequestMapping(value = "/submitZp",method = RequestMethod.POST,produces = "application/json;charset=UTF-8",consumes = "application/x-www-form-urlencoded")
    public @ResponseBody String submitZp(@RequestBody String itemStr) throws Exception {
        itemStr = URLDecoder.decode(itemStr,"utf-8").replace("=","");
        Map<String,List<Map<String,String>>> request = new Gson().fromJson(itemStr,new TypeToken<Map<String,List<Map<String,String>>>>(){}.getType());
        kpService.submitZp(request.get("zps"),request.get("details"));
        return "SUCCESS";
    }

    @RequestMapping(value = "/zc/getKpList",method = RequestMethod.GET,produces = "text/json;charset=UTF-8")
    public @ResponseBody String getKpList(ZcListRequest zcRequest) {
        if(!NumberUtils.isNumber(zcRequest.getJd())) {
            zcRequest.setJd(null);
        }
        if(!NumberUtils.isNumber(zcRequest.getQd())) {
            zcRequest.setQd(null);
        }
        if(!NumberUtils.isNumber(zcRequest.getStatus())) {
            zcRequest.setStatus(null);
        }
        List<PfListGson> list = kpService.getKpList(zcRequest);
        return new Gson().toJson(list);
    }

    @RequestMapping(value = "/savePf",method = RequestMethod.POST,produces = "application/json;charset=UTF-8",consumes = "application/x-www-form-urlencoded")
    public @ResponseBody String savePf(@RequestBody String itemStr) throws Exception {
        itemStr = URLDecoder.decode(itemStr,"utf-8").replace("=","");
        Map<String,List<Map<String,String>>> request = new Gson().fromJson(itemStr,new TypeToken<Map<String,List<Map<String,String>>>>(){}.getType());
        kpService.savePf(request.get("pfs"), request.get("details"));
        return "SUCCESS";
    }

    @RequestMapping(value = "/submitPf",method = RequestMethod.POST,produces = "application/json;charset=UTF-8",consumes = "application/x-www-form-urlencoded")
    public @ResponseBody String submitPf(@RequestBody String itemStr) throws Exception {
        itemStr = URLDecoder.decode(itemStr,"utf-8").replace("=","");
        Map<String,List<Map<String,String>>> request = new Gson().fromJson(itemStr,new TypeToken<Map<String,List<Map<String,String>>>>(){}.getType());
        kpService.submitPf(request.get("pfs"),request.get("details"));
        return "SUCCESS";
    }

    @RequestMapping(value = "/getSeasonData",method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
    public @ResponseBody String getSeasonData(String jd,String year ) {
        List<Map<String,Object>> result = reportService.getSeasonReport(jd, year);
        return new Gson().toJson(result);
    }

    @RequestMapping(value = "/getAnnualData",method = RequestMethod.GET,produces = "application/json;charset=UTF-8")
    public @ResponseBody String getAnnualData(String year ) {
        List<Map<String,Object>> result = reportService.getAnnualReport(year);
        return new Gson().toJson(result);
    }

    @RequestMapping(value = "/saveQingdan",method = RequestMethod.POST,produces = "application/json;charset=UTF-8",consumes = "application/x-www-form-urlencoded")
    public @ResponseBody String saveQingdan(@RequestBody String itemStr) throws Exception {
        itemStr = URLDecoder.decode(itemStr,"utf-8").replace("=","");
        Map<String,String> map = new Gson().fromJson(itemStr,new TypeToken<Map<String,String>>(){}.getType());
        String qdid = map.get("qdid");
        String qingdanmc = map.get("qingdanmc");
        String yearStr = map.get("yearStr");
        String jd = map.get("jd");
        String qz = map.get("qz");

        Qingdan qingdan = new Qingdan();
        qingdan.setJd(Integer.parseInt(jd));
        qingdan.setQingdanmc(qingdanmc);
        qingdan.setQz(new BigDecimal(qz));
        qingdan.setYearStr(yearStr);

        checkItemService.saveQingdan(qdid,qingdan);
        return "SUCCESS";
    }
}
