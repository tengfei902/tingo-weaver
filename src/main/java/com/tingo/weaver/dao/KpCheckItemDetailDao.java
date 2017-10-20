package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetail;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface KpCheckItemDetailDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetail record);

    int insertSelective(KpCheckItemDetail record);

    KpCheckItemDetail selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetail record);

    int updateByPrimaryKey(KpCheckItemDetail record);

    List<KpCheckItemDetail> selectByItemId(@Param("itemId") Long itemId);
}