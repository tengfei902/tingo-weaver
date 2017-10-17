package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.AdminService;
import com.tingo.weaver.dao.QingdanDao;
import com.tingo.weaver.model.po.Qingdan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * Created by user on 17/10/16.
 */
@Service
public class AdminServiceImpl implements AdminService {

//    @Autowired
    private QingdanDao qingdanDao;

    @Override
    public Long saveQingdan(Qingdan qingdan) {
        qingdanDao.insertSelective(qingdan);
        return qingdan.getId();
    }

    @Override
    public void updateQingdanValid(Long id) {

    }

    @Override
    public void updateQingdanInvalid(Long id) {

    }
}
