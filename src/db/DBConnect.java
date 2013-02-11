package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
	static Connection c = null;
    //location("jdbc:mysql://127.10.200.129/tasak");
    //login("adminBeLIEKC");
//password("2FB-2AjbnSMT");
    final static String login = "root";
	final static String password = "";
	final static String location = "jdbc:mysql://127.0.0.1/tasak";

	public static Connection getConnection() {
		if(!isConnected()) connect();
		return c;
	}

	public static boolean isConnected() {
		if (c == null) {
			return false;
		}

		try {
			if (c.isClosed()) {
				return false;
			}
		} catch (SQLException e) {
			e.printStackTrace();
			return false;
		}

		return true;
	}

	public static Connection connect() {
		try {
			// zaladowanie sterownika bazy
			Class.forName("com.mysql.jdbc.Driver");
			// uzycie sterownika
			c = DriverManager.getConnection(location, login, password);

		} catch (SQLException ec) {
			ec.printStackTrace();
		} catch (ClassNotFoundException ex) {
			ex.printStackTrace();
		}

		return c;
	}

	public static void discoconect() {
		try {
			c.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

}
