package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import model.Address;
import model.User;

public class AddressDAO {
	
	private Connection conn;
	
	public AddressDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public void addAddress(Address a) {
		
		PreparedStatement ps = null;
		
		try{
			ps = conn.prepareStatement("INSERT INTO address (house_no, street, subdivision, city, postal_code, country) VALUES(?, ?, ?, ?, ?, ?);");
			ps.setString(1, a.getHouse_no());
			ps.setString(2, a.getStreet());
			ps.setString(3, a.getSubdivision());
			ps.setString(4, a.getCity());
			ps.setString(5, a.getPostal_code());
			ps.setString(6, a.getCountry());
			
			ps.execute();
			
		}catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
	}
	
	public int getAddress(Address a) {
		PreparedStatement ps = null;
		ResultSet rs = null;

		int id = -1;
		try {
			ps = conn.prepareStatement("SELECT id FROM address WHERE house_no = ? AND street = ? AND subdivision = ? AND city = ? AND postal_code = ? AND country = ? LIMIT 1;");

			ps.setString(1, a.getHouse_no());
			ps.setString(2, a.getStreet());
			ps.setString(3, a.getSubdivision());
			ps.setString(4, a.getCity());
			ps.setString(5, a.getPostal_code());
			ps.setString(6, a.getCountry());
			
			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				id = rs.getInt("id");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			try {
				rs.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return id;
	}
	
	public void updateAddress(int id, Address a) {
		
		PreparedStatement ps = null;
		
		try{
			ps = conn.prepareStatement("UPDATE address SET house_no= ?, street=?, subdivision=?, city=?,postal_code=?,country=? WHERE id = ?");
			ps.setString(1, a.getHouse_no());
			ps.setString(2, a.getStreet());
			ps.setString(3, a.getSubdivision());
			ps.setString(4, a.getCity());
			ps.setString(5, a.getPostal_code());
			ps.setString(6, a.getCountry());
			ps.setInt(7, id);
			
			ps.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				ps.close();
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
	}
	
	

}
