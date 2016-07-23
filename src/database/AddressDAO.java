package database;

import java.sql.Connection;

public class AddressDAO {
	
	private Connection conn;
	
	public AddressDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	

}
