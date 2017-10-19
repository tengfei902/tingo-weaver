package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.HrmService;
import com.tingo.weaver.dao.HrmDepartmentDao;
import com.tingo.weaver.model.po.HrmDepartment;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Created by Administrator on 2017/10/18.
 */
@Service
public class HrmServiceImpl implements HrmService {
    @Autowired
    private HrmDepartmentDao hrmDepartmentDao;

    @Override
    public List<String> getDebtName(List<BigDecimal> ids) {
        List<HrmDepartment> hrmDepartments = hrmDepartmentDao.selectByIds(ids);
        return hrmDepartments.stream().map(HrmDepartment::getDepartmentname).collect(Collectors.toList());
    }
}
