package com.log2;

import java.io.Serializable;

/**
 * Created with IntelliJ IDEA.
 * User: A
 * Date: 06.01.13
 * Time: 11:30
 * To change this template use File | Settings | File Templates.
 */
public class BeanTest implements Serializable {
    private String name;
    private boolean deceased;

    public BeanTest(){}

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isDeceased() {
        return deceased;
    }

    public void setDeceased(boolean deceased) {
        this.deceased = deceased;
    }
}
