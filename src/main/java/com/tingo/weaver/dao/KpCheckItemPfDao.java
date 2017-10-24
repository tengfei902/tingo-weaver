package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemPf;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface KpCheckItemPfDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemPf record);

    int insertSelective(KpCheckItemPf record);

    KpCheckItemPf selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemPf record);

    int updateByPrimaryKey(KpCheckItemPf record);

    KpCheckItemPf selectByUnq(@Param("itemId") BigDecimal itemId,@Param("orgId")BigDecimal orgId,@Param("toOrgId")BigDecimal toOrgId);

    List<KpCheckItemPf> selectForList(Map<String,Object> params);

}