package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.KpCheckItemDetailZp;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Set;

public interface KpCheckItemDetailZpDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(KpCheckItemDetailZp record);

    int insertSelective(KpCheckItemDetailZp record);

    KpCheckItemDetailZp selectByPrimaryKey(BigDecimal id);

    int updateByPrimaryKeySelective(KpCheckItemDetailZp record);

    int updateByPrimaryKey(KpCheckItemDetailZp record);

    KpCheckItemDetailZp selectByUnq(@Param("detailId")BigDecimal detailId,@Param("orgId")BigDecimal orgId);

    List<KpCheckItemDetailZp> selectByZpId(@Param("zpId") BigDecimal zpId);

    List<KpCheckItemDetailZp> selectByZpIds(@Param("zpIds")Set<BigDecimal> zpIds);
}