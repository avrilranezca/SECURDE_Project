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
		
		try {

			ps = conn.prepareStatement("SELECT product.id, product.name, description, category_id, category.name FROM product INNER JOIN category ON product.category_id = category.id WHERE isActive = 1;");
			//ps = conn.prepareStatement("SELECT * FROM product WHERE isActive = 1;");

			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), rs.getInt("isActive"));
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
		
		try {
			ps = conn.prepareStatement("SELECT product.id, product.name, description, category_id, category.name AS c_name FROM product INNER JOIN category ON product.category_id = category.id WHERE product.id = ?;");

			ps.setInt(1, id);
			
			ResultSet rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), rs.getInt("isActive"));
				return p;
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	//get product based on filtering criteria

	public ArrayList<Product> searchProducts(String searchCriteria) {
		ArrayList<Product> productList = new ArrayList<Product>();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT P.id, P.name AS p_name, P.description, P.price, C.name AS c_name, P.isActive FROM product P INNER JOIN category C ON P.category_id = C.id WHERE (P.name LIKE CONCAT('%', ?, '%') OR C.name LIKE CONCAT('%', ?, '%') OR P.description LIKE CONCAT('%', ?, '%')) AND isActive = 1;");
			ps.setString(1, searchCriteria);
			ps.setString(2, searchCriteria);
			ps.setString(3, searchCriteria);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				productList.add(new Product(rs.getInt("id"), rs.getString("p_name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), rs.getInt("isActive")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return productList;
	}
}
