package com.tingo.weaver.biz;

import org.springframework.stereotype.Service;

import java.util.Map;

/**
 * Created by tengfei on 2018/1/6.
 */
public interface ReportService {
    Map<String,Object> getSeasonReport(String jd);
    Map<String,Object> getAnnualReport(String year);
}
