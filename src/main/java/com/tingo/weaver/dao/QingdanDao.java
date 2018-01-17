package com.tingo.weaver.dao;

import com.tingo.weaver.model.po.Qingdan;
import org.apache.ibatis.annotations.Param;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

public interface QingdanDao {
    int deleteByPrimaryKey(BigDecimal id);

    int insert(Qingdan record);

    int insertSelective(Qingdan record);

    Qingdan selectByPrimaryKey(Long id);

    int updateByPrimaryKeySelective(Qingdan record);

    int updateByPrimaryKey(Qingdan record);

    List<Qingdan> selectAvailableList(@Param("jd") Integer jd,@Param("yearStr")String yearStr);

    List<Qingdan> select(Map<String,Object> map);
}