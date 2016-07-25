package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import model.Category;
import model.Product;

public class ProductDAO {
	
	private Connection conn;
	
	public ProductDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public void addProduct(Product p) {
		try{
			PreparedStatement ps = conn.prepareStatement("INSERT INTO product (name, description, price, category_id, isActive) VALUES (?,?,?,?,?);");
			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setInt(4, p.getCategory_id());
			ps.setInt(5, 1);
			
			ps.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Product> getAllProducts() {
		PreparedStatement ps;

		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			ps = conn.prepareStatement("SELECT * FROM product;");

			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), rs.getInt("category_id"), rs.getInt("isActive"));
				productList.add(p);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return productList;
	}
	
	public ArrayList<Product> getProductOnCategory(Category c) {
		PreparedStatement ps;

		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			ps = conn.prepareStatement("SELECT * FROM product WHERE category_id = (SELECT id FROM category WHERE name = ?);");

			ps.setString(1, c.getName());
			
			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), rs.getInt("category_id"), rs.getInt("isActive"));
				productList.add(p);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return productList;
	}
	
	//get product based on filtering criteria

}
