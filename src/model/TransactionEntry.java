package model;

public class TransactionEntry {
	
	private int id;
	private int product_id;
	private int quantity;
	private double price;
	private int transaction_id;
	
	public TransactionEntry(int id, int product_id, int quantity, double price,
			int transaction_id) {
		super();
		this.id = id;
		this.product_id = product_id;
		this.quantity = quantity;
		this.price = price;
		this.transaction_id = transaction_id;
	}

	public TransactionEntry(int product_id, int quantity, double price) {
		super();
		this.product_id = product_id;
		this.quantity = quantity;
		this.price = price;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getProduct_id() {
		return product_id;
	}

	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getTransaction_id() {
		return transaction_id;
	}

	public void setTransaction_id(int transaction_id) {
		this.transaction_id = transaction_id;
	}
	
	

}
