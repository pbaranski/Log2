package db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnect {
	static Connection c = null;
	//to na final static albo wczytuj z configu
	static String login = null;
	static String password = null;
	static String location = null;
	
	//nie rob setterow i geterow z powyższego powodu
	public static String getLogin() {
		return login;
	}

	public static void setLogin(String login) {
		DBConnect.login = login;
	}

	public static String getPassword() {
		return password;
	}

	public static void setPassword(String password) {
		DBConnect.password = password;
	}

	public static String getLocation() {
		return location;
	}

	public static void setLocation(String location) {
		DBConnect.location = location;
	}
	//czyli wszystko powyzej az do pol wywalasz
	// w dole jest ok.
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
