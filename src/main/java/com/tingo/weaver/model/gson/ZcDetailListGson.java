package com.tingo.weaver.model.gson;

import java.math.BigDecimal;

/**
 * Created by Administrator on 2017/10/21.
 */
public class ZcDetailListGson {
    private Long zpDetailId;
    private Long itemDetailId;
    private String tkxz;
    private BigDecimal fz;
    private String pfbz;
    private BigDecimal zpf;

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

    public String getTkxz() {
        return tkxz;
    }

    public void setTkxz(String tkxz) {
        this.tkxz = tkxz;
    }

    public BigDecimal getFz() {
        return fz;
    }

    public void setFz(BigDecimal fz) {
        this.fz = fz;
    }

    public String getPfbz() {
        return pfbz;
    }

    public void setPfbz(String pfbz) {
        this.pfbz = pfbz;
    }

    public BigDecimal getZpf() {
        return zpf;
    }

    public void setZpf(BigDecimal zpf) {
        this.zpf = zpf;
    }
}
