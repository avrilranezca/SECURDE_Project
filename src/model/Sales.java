package model;

public class Sales {
	
	private String name;
	private double total_sales;
	
	public Sales(String name, double total_sales) {
		super();
		this.name = name;
		this.total_sales = total_sales;
	}
	
	public String toString() {
		return "\nName:" + name + " TotalSales: " + total_sales;
	}

	public String getname() {
		return name;
	}

	public void setname(String name) {
		this.name = name;
	}

	public double getTotal_sales() {
		return total_sales;
	}

	public void setTotal_sales(double total_sales) {
		this.total_sales = total_sales;
	}
	
	

}
