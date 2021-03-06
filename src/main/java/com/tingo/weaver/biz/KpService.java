package com.tingo.weaver.biz;

import com.tingo.weaver.model.gson.*;

import java.util.List;
import java.util.Map;

/**
 * Created by user on 17/10/18.
 */
public interface KpService {
    QingdanGson selectQdById(Integer id);
    List<QingdanGson> selectQdList(Integer jd);
    List<QingdanGson> selectQdList(String yearStr,Integer jd);
    List<QingdanDetailGson> selectQdDetail(Integer jd);
    List<ZcListGson> getKpZcGson(ZcListRequest zcListRequest);
    List<CheckItemGson> getCheckItem(Long qdId);
    CheckItemGson getCheckItemByItemId(Long itemId);
    void saveCheckItem(CheckItemGson itemGson);
    String doPublish(Long userId,List<String> qdIds,Integer kpMonth,List<String> companyIds);
    void saveZp(List<Map<String,String>> zps,List<Map<String,String>> details);
    void submitZp(List<Map<String,String>> zps,List<Map<String,String>> details);
    List<PfListGson> getKpList(ZcListRequest zcListRequest);
    void savePf(List<Map<String,String>> pfs,List<Map<String,String>> details);
    void submitPf(List<Map<String,String>> pfs,List<Map<String,String>> details);
    List<CheckItemGson> getCheckResult(String userId,String yearStr,String jd,String qdId);
}
