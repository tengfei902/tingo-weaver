package com.tingo.weaver.model.gson;

import java.math.BigDecimal;

/**
 * Created by Administrator on 2017/10/22.
 */
public class PfDetailListGson {
    private Long kpDetailId;
    private Long zpDetailId;
    private Long itemDetailId;
    private Long kpId;
    private Long zpId;
    private Long itemId;
    private String tkxz;
    private String pfbz;
    private BigDecimal fz;
    private BigDecimal zpf;
    private BigDecimal pf;

    public Long getKpDetailId() {
        return kpDetailId;
    }

    public void setKpDetailId(Long kpDetailId) {
        this.kpDetailId = kpDetailId;
    }

    public Long getZpDetailId() {
        return zpDetailId;
    }

    public void setZpDetailId(Long zpDetailId) {
        this.zpDetailId = zpDetailId;
    }

    public Long getItemDetailId() {
        return itemDetailId;
    }

    public void setItemDetailId(Long itemDetailId) {
        this.itemDetailId = itemDetailId;
    }

    public Long getKpId() {
        return kpId;
    }

    public void setKpId(Long kpId) {
        this.kpId = kpId;
    }

    public Long getZpId() {
        return zpId;
    }

    public void setZpId(Long zpId) {
        this.zpId = zpId;
    }

    public Long getItemId() {
        return itemId;
    }

    public void setItemId(Long itemId) {
        this.itemId = itemId;
    }

    public String getTkxz() {
        return tkxz;
    }

    public void setTkxz(String tkxz) {
        this.tkxz = tkxz;
    }

    public String getPfbz() {
        return pfbz;
    }

    public void setPfbz(String pfbz) {
        this.pfbz = pfbz;
    }

    public BigDecimal getFz() {
        return fz;
    }

    public void setFz(BigDecimal fz) {
        this.fz = fz;
    }

    public BigDecimal getZpf() {
        return zpf;
    }

    public void setZpf(BigDecimal zpf) {
        this.zpf = zpf;
    }

    public BigDecimal getPf() {
        return pf;
    }

    public void setPf(BigDecimal pf) {
        this.pf = pf;
    }
}
