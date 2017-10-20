package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItem;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;

public interface KpCheckItemDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItem record);

    int insertSelective(KpCheckItem record);

    KpCheckItem selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(KpCheckItem record);

    int updateByPrimaryKey(KpCheckItem record);

    List<KpCheckItem> selectByQdId(@Param("qdId") BigDecimal qdId);
}