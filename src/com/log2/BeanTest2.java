package com.log2;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: Karina
 * Date: 20.01.13
 * Time: 12:31
 * To change this template use File | Settings | File Templates.
 */
public class BeanTest2 implements Serializable {
    private String xxx;
    public BeanTest2(){};

    public String getXxx() {
        return xxx;
    }


    public void setXxx(String xxx) {
        this.xxx = xxx;
    }
}
