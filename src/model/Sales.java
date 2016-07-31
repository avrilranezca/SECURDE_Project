package model;

public class Sales {
	
	private String product_name;
	private double total_sales;
	
	public Sales(String product_name, double total_sales) {
		super();
		this.product_name = product_name;
		this.total_sales = total_sales;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public double getTotal_sales() {
		return total_sales;
	}

	public void setTotal_sales(double total_sales) {
		this.total_sales = total_sales;
	}
	
	

}
