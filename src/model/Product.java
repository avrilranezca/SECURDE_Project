package model;

public class Product {
	
	private int id;
	private String description;
	private double price;
	private int category_id;
	private int isArchived;
	
	public Product(int id, String description, double price, int category_id,
			int isArchived) {
		super();
		this.id = id;
		this.description = description;
		this.price = price;
		this.category_id = category_id;
		this.isArchived = isArchived;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getCategory_id() {
		return category_id;
	}

	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public int getIsArchived() {
		return isArchived;
	}

	public void setIsArchived(int isArchived) {
		this.isArchived = isArchived;
	}
	
	
	
	

}
