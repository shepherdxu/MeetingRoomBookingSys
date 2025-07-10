package com.yourcompany.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {
    // 哈希密码
    public static String hashPassword(String plainTextPassword){
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

    // 检查密码
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
}