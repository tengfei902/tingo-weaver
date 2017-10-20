package com.tingo.weaver.biz;

import com.tingo.weaver.model.gson.*;

import java.util.List;

/**
 * Created by user on 17/10/18.
 */
public interface KpService {
    QingdanGson selectQdById(Integer id);
    List<QingdanGson> selectQdList(Integer jd);
    List<QingdanDetailGson> selectQdDetail(Integer jd);
    List<KpZcGson> getKpZcGson(ZcListRequest zcListRequest);
    List<CheckItemGson> getCheckItem(Long qdId);
    CheckItemGson getCheckItemByItemId(Long itemId);
    void saveCheckItem(CheckItemGson itemGson);
    void doPublish(Long userId,List<String> qdIds,Integer kpMonth,List<String> companyIds);
}
