package com.tingo.weaver.model;

import com.tingo.weaver.model.constants.Constants;

/**
 * Created by Administrator on 2017/10/21.
 */
public class ResponseResult<T> {
    private String code;
    private String msg;
    private T data;

    private ResponseResult() {

    }

    public static <T> ResponseResult<T> success(String msg , T data) {
        ResponseResult<T> response = new ResponseResult<>();
        response.setCode(Constants.SUCCESS_CODE);
        response.setMsg(msg);
        response.setData(data);
        return response;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public T getData() {
        return data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public String getMsg() {
        return msg;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }
}
