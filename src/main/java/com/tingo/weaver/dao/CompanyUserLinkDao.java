package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.CompanyUserLink;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface CompanyUserLinkDao {
    int insert(CompanyUserLink record);

    int insertSelective(CompanyUserLink record);

    List<CompanyUserLink> selectByUserId(@Param("userId")BigDecimal userId);
}