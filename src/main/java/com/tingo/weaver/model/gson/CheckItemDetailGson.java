package com.tingo.weaver.model.gson;

import java.math.BigDecimal;
import java.util.List;

/**
 * Created by user on 17/10/19.
 */
public class CheckItemDetailGson {
    private Long detailId;
    private String pfbz;
    private BigDecimal fs;
    private String tkxz;
    private ZpGson zp;
    private List<PfGson> pfs;

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

    public ZpGson getZp() {
        return zp;
    }

    public void setZp(ZpGson zp) {
        this.zp = zp;
    }

    public List<PfGson> getPfs() {
        return pfs;
    }

    public void setPfs(List<PfGson> pfs) {
        this.pfs = pfs;
    }
}
