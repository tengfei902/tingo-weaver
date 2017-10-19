package com.tingo;

import org.junit.Test;

/**
 * Created by user on 17/10/19.
 */
public class UnitTest {

    @Test
    public void testAppend() {
        StringBuilder sb = new StringBuilder("asfdgdfh");
        sb.append("---------------------------");
        System.out.println(sb.toString());
    }
}
