package model;
import java.sql.*;

public class DB {
	public static Connection CON;
	static {
		try {
			Class.forName("com.mysql.jdbc.Driver");
			CON = DriverManager.getConnection("jdbc:mysql://localhost:3306/webdb", "web", "pass");
			System.out.println("���Ӽ���");
		} catch (Exception e) {
			System.out.println("���ӽ���:" + e.toString());
		}
	}
}
