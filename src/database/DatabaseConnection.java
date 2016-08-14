package database;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseConnection {
	
	private Connection conn;
    public static DatabaseConnection db;
    private DatabaseConnection() {
        String url= "jdbc:mysql://localhost:3306/";
        String dbName = "securde_eshopping";
        String driver = "com.mysql.jdbc.Driver";
        String userName = "root";
        String password = "1234";
        try {
            Class.forName(driver).newInstance();
            this.conn = (Connection)DriverManager.getConnection(url+dbName,userName,password);
        }
        catch (Exception sqle) {
            sqle.printStackTrace();
        }
    }
    /**
     *
     * @return DatabaseConnection Database connection object
     */
    public static synchronized Connection getConnection() {
        if ( db == null ) {
            db = new DatabaseConnection();
        }
        return db.conn;
 
    }
	
	/*private static String username = "root";
	private static String password = "Cs20";
	private static String schema = "securde_eshopping";
	
	public DatabaseConnection(){
	
	}
	
	public static Connection getConnection(){
		Connection conn = null;
		try {
			Class.forName("com.mysql.jdbc.Driver");
			conn = DriverManager.getConnection("jdbc:mysql://127.0.0.1:3306/" + schema, username, password);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return conn;
	}*/
}
