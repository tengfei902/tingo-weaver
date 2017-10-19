package com.tingo.weaver.biz;

import com.tingo.weaver.model.gson.KpZcGson;
import com.tingo.weaver.model.gson.QingdanDetailGson;
import com.tingo.weaver.model.gson.QingdanGson;
import com.tingo.weaver.model.gson.ZcListRequest;
import java.util.List;

/**
 * Created by user on 17/10/18.
 */
public interface KpService {
    List<QingdanGson> selectQdList(Integer jd);
    List<QingdanDetailGson> selectQdDetail(Integer jd);
    List<KpZcGson> getKpZcGson(ZcListRequest zcListRequest);
}
