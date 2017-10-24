package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.DeptUserLink;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface DeptUserLinkDao {
    int insert(DeptUserLink record);

    int insertSelective(DeptUserLink record);

    List<DeptUserLink> selectByUserId(@Param("userId")BigDecimal userId);
}