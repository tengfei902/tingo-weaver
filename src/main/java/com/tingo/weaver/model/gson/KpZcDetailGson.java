package com.tingo.weaver.model.gson;

/**
 * Created by user on 17/10/18.
 */
public class KpZcDetailGson {
    private Long pubId;
    //分值
    private String fz;
    //评分标准
    private String pfbz;
    //状态
    private String zt;
    //自评分
    private String zpf;

    public Long getPubId() {
        return pubId;
    }

    public void setPubId(Long pubId) {
        this.pubId = pubId;
    }

    public String getFz() {
        return fz;
    }

    public void setFz(String fz) {
        this.fz = fz;
    }

    public String getPfbz() {
        return pfbz;
    }

    public void setPfbz(String pfbz) {
        this.pfbz = pfbz;
    }

    public String getZt() {
        return zt;
    }

    public void setZt(String zt) {
        this.zt = zt;
    }

    public String getZpf() {
        return zpf;
    }

    public void setZpf(String zpf) {
        this.zpf = zpf;
    }
}
