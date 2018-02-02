package com.hegx.utils;

import org.apache.commons.lang3.RandomStringUtils;
import org.apache.commons.lang3.StringUtils;

/**
 * 用来生成用户代号的工具
 */
public class CodeUtils {
    // 生成随机的一个8位字符串
    public static String generateCode(String type) {
        String value = RandomStringUtils.randomNumeric(8);
        return StringUtils.leftPad(value, 8, "0"); //在不够8位，在右边用“0”补
    }

    // 根据用户id生成一个16机制字符串、
    public static String authIdToCode(Long id) {
        Long value = Long.valueOf(id.longValue() + 1000L);
        return Long.toHexString(value.longValue()).toUpperCase();
    }

    public static void main(String[] args) {
        System.out.println(CodeUtils.generateCode("a"));
        System.out.println(CodeUtils.authIdToCode(1235L));
    }
}
