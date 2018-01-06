package com.tingo.weaver.biz;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Created by tengfei on 2018/1/6.
 */
public interface ReportService {
    List<Map<String, Object>> getSeasonReport(String jd,String year);
    List<Map<String, Object>> getAnnualReport(String year);
}
