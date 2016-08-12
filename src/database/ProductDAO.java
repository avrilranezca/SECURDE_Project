package database;

import model.Category;
import model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductDAO {
	
	private Connection conn;
	
	public ProductDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public void addProduct(Product p) {
		
		PreparedStatement ps = null;
		
		try{
			ps = conn.prepareStatement("INSERT INTO product (name, description, price, category_id, isActive) VALUES (?,?,?,(SELECT id FROM category WHERE name = ?),?);");
			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setString(4, p.getCategory());
			ps.setInt(5, 1);
			
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
	
	public void deleteProduct(Product p) {
		
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE product SET isActive = ? WHERE id = ?");
			ps.setInt(1, 0);
			ps.setInt(2, p.getId());
			
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
	
	public void reactivateProduct(Product p) {
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE product SET isActive = ? WHERE id = ?");
			ps.setInt(1, 1);
			ps.setInt(2, p.getId());
			
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
	
	public void updateProduct(Product p) {
		
		CategoryDAO cdao = new CategoryDAO();
		Category category = cdao.getCategory(p.getCategory());
		PreparedStatement ps = null;
		
		try {
			ps = conn.prepareStatement("UPDATE product SET name = ?, description = ?, price = ?, category_id = ?, isActive = ? WHERE id = ?");
			ps.setString(1, p.getName());
			ps.setString(2, p.getDescription());
			ps.setDouble(3, p.getPrice());
			ps.setInt(4, category.getId());
			ps.setInt(5, 1);
			ps.setInt(6, p.getId());
			
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
	
	public ArrayList<Product> getAllProducts() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		ArrayList<Product> productList = new ArrayList<Product>();
		
		try {

			ps = conn.prepareStatement("SELECT product.id, product.price, product.name, description, category_id, category.name as c_name FROM product INNER JOIN category ON product.category_id = category.id WHERE isActive = 1;");

			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), 1);
				productList.add(p);
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
		
		return productList;
	}
	
	public ArrayList<Product> getAllProductsPagination(int offset, int noOfProducts) {
		PreparedStatement ps = null;
		ResultSet rs = null;

		ArrayList<Product> productList = new ArrayList<Product>();
		
		try {
			
			ps = conn.prepareStatement("SELECT product.id, product.price, product.name, description, category_id, category.name as c_name FROM product INNER JOIN category ON product.category_id = category.id WHERE isActive = 1 LIMIT ?, ?;");
			ps.setInt(1, offset);
			ps.setInt(2, noOfProducts);

			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), 1);
				productList.add(p);
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
		
		return productList;
	}
	
	public ArrayList<Product> getProductOnCategory(Category c) {
		PreparedStatement ps = null;
		ResultSet rs = null;

		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			ps = conn.prepareStatement("SELECT * FROM product WHERE category_id = (SELECT id FROM category WHERE name = ?) AND isActive = 1;");

			ps.setString(1, c.getName());
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), c.getName(), rs.getInt("isActive"));
				productList.add(p);
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
		
		return productList;
	}
	
	public ArrayList<Product> getProductOnCategoryPagination(Category c, int offset, int noOfProducts) {
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		ArrayList<Product> productList = new ArrayList<Product>();
		try {
			ps = conn.prepareStatement("SELECT * FROM product WHERE category_id = (SELECT id FROM category WHERE name = ?) LIMIT ? , ? ;");

			ps.setString(1, c.getName());
			ps.setInt(2, offset);
			ps.setInt(3, noOfProducts);
			
			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), c.getName(), rs.getInt("isActive"));
				productList.add(p);
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
		
		return productList;
	}
	
	public Product getProductOnID(int id) {
		PreparedStatement ps = null;
		ResultSet rs = null; 
		
		try {
			ps = conn.prepareStatement("SELECT product.id, product.price, product.name, description, category_id, category.name AS c_name, isActive FROM product INNER JOIN category ON product.category_id = category.id WHERE product.id = ?;");

			ps.setInt(1, id);
			
			rs = ps.executeQuery();
			
			
			while(rs.next()) {
				Product p = new Product(rs.getInt("id"), rs.getString("name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), rs.getInt("isActive"));
				return p;
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
		
		return null;
	}
	
	//get product based on filtering criteria

	public ArrayList<Product> searchProducts(String searchCriteria) {
		ArrayList<Product> productList = new ArrayList<Product>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		try {
			ps = conn.prepareStatement("SELECT P.id, P.name AS p_name, P.description, P.price, C.name AS c_name, P.isActive FROM product P INNER JOIN category C ON P.category_id = C.id WHERE (P.name LIKE CONCAT('%', ?, '%') OR C.name LIKE CONCAT('%', ?, '%') OR P.description LIKE CONCAT('%', ?, '%')) AND isActive = 1;");
			ps.setString(1, searchCriteria);
			ps.setString(2, searchCriteria);
			ps.setString(3, searchCriteria);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				productList.add(new Product(rs.getInt("id"), rs.getString("p_name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), rs.getInt("isActive")));
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
		
		return productList;
	}
	
	public ArrayList<Product> searchProductsPagination(String searchCriteria, int offset, int noOfProducts) {
		ArrayList<Product> productList = new ArrayList<Product>();
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT P.id, P.name AS p_name, P.description, P.price, C.name AS c_name, P.isActive FROM product P INNER JOIN category C ON P.category_id = C.id WHERE (P.name LIKE CONCAT('%', ?, '%') OR C.name LIKE CONCAT('%', ?, '%') OR P.description LIKE CONCAT('%', ?, '%')) AND isActive = 1 LIMIT ?, ?;");
			ps.setString(1, searchCriteria);
			ps.setString(2, searchCriteria);
			ps.setString(3, searchCriteria);
			ps.setInt(4, offset);
			ps.setInt(5, noOfProducts);
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				productList.add(new Product(rs.getInt("id"), rs.getString("p_name"), rs.getString("description"), rs.getDouble("price"), rs.getString("c_name"), rs.getInt("isActive")));
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
		
		return productList;
	}
	
	public int getNoOfProducts() {
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			ps = conn.prepareStatement("SELECT COUNT(*) AS count FROM product;");
			
			rs = ps.executeQuery();
			
			while(rs.next()) {
				return rs.getInt("count");
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
		
		return 0;
	}




	public int getNoOfProductsWithCategory(Category c) {
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) AS 'count' FROM product WHERE category_id = ?;");
			ps.setInt(1, c.getId());

			ResultSet rs = ps.executeQuery();

			while(rs.next()) {
				return rs.getInt("count");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return 0;
	}
}
