package com.tingo.weaver.model.gson;

/**
 * Created by user on 17/10/18.
 */
public class KpZcGson {
    private Long itemId;
    //清单id
    private String qdId;
    //项目内容
    private String xmnr;
    //自评说明
    private String zpsm;
    //考评季度
    private String kpjd;

    private KpZcDetailGson detail;

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public String getQdId() {
        return qdId;
    }

    public void setQdId(String qdId) {
        this.qdId = qdId;
    }

    public String getXmnr() {
        return xmnr;
    }

    public void setXmnr(String xmnr) {
        this.xmnr = xmnr;
    }

    public String getZpsm() {
        return zpsm;
    }

    public void setZpsm(String zpsm) {
        this.zpsm = zpsm;
    }

    public String getKpjd() {
        return kpjd;
    }

    public void setKpjd(String kpjd) {
        this.kpjd = kpjd;
    }

    public KpZcDetailGson getDetail() {
        return detail;
    }

    public void setDetail(KpZcDetailGson detail) {
        this.detail = detail;
    }
}
