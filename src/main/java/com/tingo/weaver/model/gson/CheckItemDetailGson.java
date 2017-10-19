package com.tingo.weaver.model.gson;

import java.math.BigDecimal;

/**
 * Created by user on 17/10/19.
 */
public class CheckItemDetailGson {
    private Long detailId;
    private String pfbz;
    private BigDecimal fs;
    private String tkxz;

    public Long getDetailId() {
        return detailId;
    }

    public void setDetailId(Long detailId) {
        this.detailId = detailId;
    }

    public String getPfbz() {
        return pfbz;
    }

    public void setPfbz(String pfbz) {
        this.pfbz = pfbz;
    }

    public BigDecimal getFs() {
        return fs;
    }

    public void setFs(BigDecimal fs) {
        this.fs = fs;
    }

    public String getTkxz() {
        return tkxz;
    }

    public void setTkxz(String tkxz) {
        this.tkxz = tkxz;
    }
}
