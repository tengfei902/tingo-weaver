package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetailPf;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;

public interface KpCheckItemDetailPfDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetailPf record);

    int insertSelective(KpCheckItemDetailPf record);

    KpCheckItemDetailPf selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetailPf record);

    int updateByPrimaryKey(KpCheckItemDetailPf record);

    KpCheckItemDetailPf selectByUnq(@Param("detailId") BigDecimal detailId,@Param("orgId")BigDecimal orgId,@Param("toOrgId")BigDecimal toOrgId);
}