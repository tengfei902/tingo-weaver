package com.tingo.weaver.biz.impl;

import com.tingo.weaver.biz.CacheService;
import com.tingo.weaver.biz.ReportService;
import com.tingo.weaver.dao.KpCheckItemDetailPfDao;
import com.tingo.weaver.dao.KpCheckItemPfDao;
import com.tingo.weaver.dao.QingdanDao;
import com.tingo.weaver.model.po.*;
import com.tingo.weaver.utils.Utils;
import com.tingo.weaver.utils.enums.Kpfs;
import org.apache.commons.collections.MapUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.*;
import java.util.concurrent.ConcurrentHashMap;
import java.util.function.Function;
import java.util.stream.Collectors;

/**
 * Created by tengfei on 2018/1/6.
 */
@Service
public class ReportServiceImpl implements ReportService {
    @Autowired
    private QingdanDao qingdanDao;
    @Autowired
    private KpCheckItemPfDao kpCheckItemPfDao;
    @Autowired
    private KpCheckItemDetailPfDao kpCheckItemDetailPfDao;
    @Autowired
    private CacheService cacheService;

    @Override
    public Map<String, Object> getSeasonReport(String jd) {
        List<Qingdan> qds = qingdanDao.selectAvailableList(Integer.parseInt(jd));
        Map<String,BigDecimal> scoreMap = new ConcurrentHashMap<>();

        for(Qingdan qingdan:qds) {
            List<KpCheckItemPf> pfs = kpCheckItemPfDao.selectMarkedByQdId(qingdan.getId());
            for(KpCheckItemPf pf:pfs) {
                caculateItemScore(pf,scoreMap);
            }
        }

        Map<Long,Qingdan> qdMap = qds.parallelStream().collect(Collectors.toMap(Qingdan::getId,Function.identity()));
        //序号，被考评单位，重点工作清单，常规工作清单，本月总分，累计总分）
        Map<String,List<Map<String,Object>>> orgScoreMap = new HashMap<>();
        for(String key:scoreMap.keySet()) {
            String org = key.split("_")[0];
            String qdId = key.split("_")[1];
            if(orgScoreMap.get(org) == null) {
                orgScoreMap.put(org,new ArrayList<>());
            }
            Map<String,Object> map = new HashMap<>();
            map.put("qdId",qdId);
            Qingdan qingdan = qdMap.get(Long.parseLong(qdId));
            map.put("qd",qingdan.getQingdanmc());
            map.put("weight",qingdan.getQz());
            map.put("score",scoreMap.get(key));
            map.put("weightedScore",scoreMap.get(key).multiply(qingdan.getQz()));

            orgScoreMap.get(org).add(map);
        }

        Map<String,Object> result = new HashMap<>();
        for(String org:orgScoreMap.keySet()) {
            HrmSubCompany company = cacheService.getCompany(new BigDecimal(org));
            result.put("org",org);
            result.put("orgname",company.getSubcompanyname());
            result.put("qds",orgScoreMap.get(org));

            BigDecimal score = new BigDecimal("0");

            List<Map<String,Object>> list = orgScoreMap.get(org);
            for(Map<String,Object> map:list) {
                score = score.add(new BigDecimal(map.get("weightedScore").toString()));
            }
            result.put("score",score);
        }
        return result;
    }

    private void caculateItemScore(KpCheckItemPf pf,Map<String,BigDecimal> scoreMap) {
        List<KpCheckItemDetailPf> detailPfs = kpCheckItemDetailPfDao.selectByPfId(pf.getId());

        KpCheckItem kpCheckItem = cacheService.getItem(pf.getItemId());

        for(KpCheckItemDetailPf detailPf:detailPfs) {
            String key = String.format("%s_%s",detailPf.getToOrgId(),pf.getQdId());
            if(Objects.isNull(scoreMap.get(key))) {
                scoreMap.put(key,new BigDecimal("0"));
            }

            Kpfs kpfs = Kpfs.parse(kpCheckItem.getKpfs());
            BigDecimal newScore = new BigDecimal("0");
            switch (kpfs) {
                case ADD:
                    newScore = scoreMap.get(key).add(detailPf.getPf());
                    scoreMap.put(key,newScore);
                    break;
                case MINUS:
                    newScore = scoreMap.get(key).subtract(detailPf.getPf());
                    newScore = Utils.max(newScore,new BigDecimal("0"));
                    scoreMap.put(key,newScore);
                    break;
                case NO:
                    newScore = new BigDecimal("0");
                    scoreMap.put(key,newScore);
                    return;
                default:
                    newScore = scoreMap.get(key).add(detailPf.getPf());
                    scoreMap.put(key,newScore);
                    break;
            }
        }
    }

    @Override
    public Map<String, Object> getAnnualReport(String year) {
        return null;
    }
}
