package model;

public class Sales {
	
	private String name;
	private int quantity;
	private double total_sales;
	
	public Sales(String name, int quantity, double total_sales) {
		super();
		this.name = name;
		this.quantity = quantity;
		this.total_sales = total_sales;
	}
	
	public String toString() {
		return "\nName:" + name + " Quantity: " + quantity + " TotalSales: " + total_sales;
	}

	public String getname() {
		return name;
	}

	public void setname(String name) {
		this.name = name;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getTotal_sales() {
		return total_sales;
	}

	public void setTotal_sales(double total_sales) {
		this.total_sales = total_sales;
	}
	
	

}
