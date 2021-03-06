package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Category;
import model.Product;

public class CategoryDAO {

	private Connection conn;
	
	public CategoryDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public void addCategory(Category c) {
		
		PreparedStatement ps = null;
		
		try{
			ps = conn.prepareStatement("INSERT INTO category (name) VALUES (?);");
			ps.setString(1, c.getName());
			
			ps.execute();
			
			
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
	
	public Category getCategory(String categoryName) {
		
		Category c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		
		try{
			ps = conn.prepareStatement("SELECT id, name FROM category WHERE name = ? LIMIT 1;");
			ps.setString(1, categoryName);
			
			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				c = new Category(rs.getInt("id"), rs.getString("name"));
				return c;
			}
			
			
		} catch(SQLException e) {
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
		
		return c;
	}
	
	public List<String> getCategories(){
		
		List<String> categories = new ArrayList<String>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			ps = conn.prepareStatement("SELECT name FROM category;");
			rs = ps.executeQuery();
			
			while(rs.next()) {
				categories.add(rs.getString("name"));
			}
			
		} catch(SQLException e) {
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
		return categories;
	}
	
	public Category getCategory(int categoryID) {
		
		Category c = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try{
			ps = conn.prepareStatement("SELECT id, name FROM category WHERE id = ? LIMIT 1;");
			ps.setInt(1, categoryID);
			
			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				c = new Category(rs.getInt("id"), rs.getString("name"));
				return c;
			}
			
			
		} catch(SQLException e) {
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
		
		return c;
	}
}
