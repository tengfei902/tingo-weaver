package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.RefService;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;

/**
 * Created by user on 17/10/17.
 */
@Service
public class RefServiceImpl implements RefService {

    //todo subcompany cache
    @Override
    public String getSubCompanyname(Long id) {
        return null;
    }

    @Override
    public boolean checkSex(String sex) {
        return false;
    }

    @Override
    public boolean checkDateSeason(String currentSeason) {
        Calendar c = Calendar.getInstance();
        int currentMonth = c.get(Calendar.MONTH) + 1;
        int jd = currentMonth/4+1;
        return Integer.parseInt(currentSeason) == jd;
    }
}
