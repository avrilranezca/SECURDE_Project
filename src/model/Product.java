package model;

public class Product {
	
	private int id;
	private String name;
	private String description;
	private double price;
	private int category_id;
	private int isActive;
	
	public Product(int id, String name, String description, double price, int category_id,
			int isActive) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.category_id = category_id;
		this.isActive = isActive;
	}
	
	public Product(String name, String description, double price, int category_id,
			int isActive) {
		super();
		this.name = name;
		this.description = description;
		this.price = price;
		this.category_id = category_id;
		this.isActive = isActive;
	}
	
	public String toString() {
		return "\nID:" + id + " Name:" + name + " Description:" + description + " Price:" + price + " Category_Id:" + category_id + " isActive:" + isActive;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	
	
	
	

}
