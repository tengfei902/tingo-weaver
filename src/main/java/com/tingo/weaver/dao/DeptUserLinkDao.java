package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.DeptUserLink;

public interface DeptUserLinkDao {
    int insert(DeptUserLink record);

    int insertSelective(DeptUserLink record);
}