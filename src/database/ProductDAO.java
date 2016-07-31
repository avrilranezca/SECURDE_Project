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
			PreparedStatement ps = conn.prepareStatement("INSERT INTO product (name, description, price, category_id, isActive) VALUES (?,?,?,(SELECT id FROM category WHERE name = ?),?);");
			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setString(4, p.getCategory());
			ps.setInt(5, 1);
			
			ps.execute();
		}catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void deleteProduct(Product p) {
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE product SET isActive = ? WHERE id = ?");
			ps.setInt(1, 0);
			ps.setInt(2, p.getId());
			
			ps.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void reactivateProduct(Product p) {
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE product SET isActive = ? WHERE id = ?");
			ps.setInt(1, 1);
			ps.setInt(2, p.getId());
			
			ps.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public void updateProduct(Product p) {
		
		CategoryDAO cdao = new CategoryDAO();
		Category category = cdao.getCategory(p.getCategory());
		
		try {
			PreparedStatement ps = conn.prepareStatement("UPDATE product SET name = ?, description = ?, price = ?, category_id = ?, isActive = ? WHERE id = ?");
			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setInt(4, category.getId());
			ps.setInt(5, 1);
			ps.setInt(6, p.getId());
			
			ps.executeUpdate();
		} catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	public ArrayList<Product> getAllProducts() {
		PreparedStatement ps;

		ArrayList<Product> productList = new ArrayList<Product>();
		
		CategoryDAO cdao = new CategoryDAO();
		
		try {
			ps = conn.prepareStatement("SELECT * FROM product;");

			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Category c = cdao.getCategory(rs.getInt("category_id"));
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), c.getName(), rs.getInt("isActive"));
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
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), c.getName(), rs.getInt("isActive"));
				productList.add(p);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return productList;
	}
	
	public Product getProductOnID(int id) {
		PreparedStatement ps;
		
		CategoryDAO cdao = new CategoryDAO();

		try {
			ps = conn.prepareStatement("SELECT * FROM product WHERE id = ?;");

			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Category c = cdao.getCategory(rs.getInt("category_id"));
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), c.getName(), rs.getInt("isActive"));
				return p;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	//get product based on filtering criteria

}
