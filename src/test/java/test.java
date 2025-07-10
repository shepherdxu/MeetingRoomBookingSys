import org.mindrot.jbcrypt.BCrypt;

public class test {
    // 哈希密码
    public static String hashPassword(String plainTextPassword){
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

    // 检查密码
    public static boolean checkPassword(String plainPassword, String hashedPassword) {
        return BCrypt.checkpw(plainPassword, hashedPassword);
    }
    public static void main(String[] args) {
        String plainTextPassword = "password123";
        String hashedPassword = "$2a$10$GqF8hS7n5vAb2iF.j9s.yOAFj4A.gG2j5cWzJGp2g7WJgE8T8r.aK";

    }
}
