package database;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import model.Sales;
import model.Transaction;
import model.TransactionEntry;

public class TransactionDAO {
	
private Connection conn;
	
	public TransactionDAO() {
		conn = DatabaseConnection.getConnection();
	}
	
	public void addTransaction(Transaction t, ArrayList<TransactionEntry> teList) {
		
		int transactionID = 0;
		
		try {
			PreparedStatement ps = conn.prepareStatement("INSERT INTO transaction (user_id, date) VALUES (?,?)", Statement.RETURN_GENERATED_KEYS);
			ps.setInt(1, t.getUser_id());
			ps.setString(2, t.getDateTime());
			
			ps.executeUpdate();
			
			ResultSet rs = ps.getGeneratedKeys();
			rs.next();
			transactionID = rs.getInt(1);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			System.out.println("insert transaction error");
			e.printStackTrace();
		}
		
		try {
			PreparedStatement ps = conn.prepareStatement("INSERT INTO transaction_entry (product_id, quantity, price, transaction_id) VALUES (?,?,?,?)");
			
			for(int i=0; i<teList.size(); i++) {
				ps.setInt(1, teList.get(i).getProduct_id());
				ps.setInt(2, teList.get(i).getQuantity());
				ps.setDouble(3, teList.get(i).getPrice());
				ps.setInt(4, transactionID);
				ps.addBatch();
			}
			
			ps.executeBatch();
			
		} catch (SQLException e) {
			System.out.println("insert transaction entries error");
			e.printStackTrace();
		}
	}
	
	/******
	 * Accounting Manager – can only view financial records (can filter by total sales, 
	 * sales per product type, and sales per product).
	 ******/
	//total sales
	public ArrayList<Sales> getTotalSales(String filter) {
		ArrayList<Sales> salesList = new ArrayList<Sales>();
		
		try {
			String query = "";
			
			if("daily".equals(filter)) {
				query = "SELECT CONCAT(MONTHNAME(date), ' ', DAY(date), ' ', YEAR(date)) AS date, SUM(TE.quantity) AS quantity, SUM(TE.price * TE.quantity) AS total FROM transaction_entry TE INNER JOIN transaction T ON T.id = TE.transaction_id GROUP BY YEAR(date), MONTH(date), DAY(date) ORDER BY YEAR(date), MONTH(date), DAY(date);";
			}
			else if("monthly".equals(filter)) {
				query = "SELECT CONCAT(MONTHNAME(date), ' ', YEAR(date)) AS date, SUM(TE.quantity) AS quantity, SUM(TE.price * TE.quantity) AS total FROM transaction_entry TE INNER JOIN transaction T ON T.id = TE.transaction_id GROUP BY YEAR(date), MONTH(date) ORDER BY YEAR(date), MONTH(date);";
			}
			else if("yearly".equals(filter)) {
				query = "SELECT YEAR(date) AS date, SUM(TE.quantity) AS quantity, SUM(TE.price * TE.quantity) AS total FROM transaction_entry TE INNER JOIN transaction T ON T.id = TE.transaction_id GROUP BY YEAR(date) ORDER BY YEAR(date);";
			}
			
			PreparedStatement ps = conn.prepareStatement(query);
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				salesList.add(new Sales(rs.getString("date"), rs.getInt("quantity"), rs.getDouble("total")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return salesList;
	}
	
	//sales per product type
	public ArrayList<Sales> getSalesPerCategory() {
		ArrayList<Sales> salesList = new ArrayList<Sales>();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT id, c_name, SUM(quantity) AS quantity, SUM(total) AS total FROM (SELECT TE.product_id, P.name, C.id, C.name AS c_name, SUM(TE.quantity) AS quantity, TE.price * SUM(TE.quantity) AS total FROM transaction_entry TE INNER JOIN product P ON TE.product_id = P.id INNER JOIN category C ON C.id = P.category_id GROUP BY product_id) A GROUP BY c_name;");
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				salesList.add(new Sales(rs.getString("c_name"), rs.getInt("quantity"), rs.getDouble("total")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return salesList;
	}
	
	
	//sales per product
	public ArrayList<Sales> getSalesPerProduct() {
		ArrayList<Sales> salesList = new ArrayList<Sales>();
		
		try {
			PreparedStatement ps = conn.prepareStatement("SELECT TE.product_id, P.name, SUM(TE.quantity) AS quantity, TE.price * SUM(TE.quantity) AS total FROM transaction_entry TE INNER JOIN product P ON TE.product_id = P.id GROUP BY product_id;");
			
			ResultSet rs = ps.executeQuery();
			
			while(rs.next()) {
				salesList.add(new Sales(rs.getString("name"), rs.getInt("quantity"), rs.getDouble("total")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return salesList;
	}

}
