package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemZp;
import org.apache.ibatis.annotations.Param;
import org.glassfish.jersey.internal.util.PropertyAlias;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface KpCheckItemZpDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemZp record);

    int insertSelective(KpCheckItemZp record);

    KpCheckItemZp selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemZp record);

    int updateByPrimaryKey(KpCheckItemZp record);

    KpCheckItemZp selectByUnq(@Param("itemId")BigDecimal itemId,@Param("orgId")BigDecimal orgId);

    List<KpCheckItemZp> selectForList(Map<String,Object> params);
}