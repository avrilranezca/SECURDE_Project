package model;

public class Product {
	
	private int id;
	private String name;
	private String description;
	private double price;
	private String category;
	private int isActive;
	
	public Product(int id, String name, String description, double price, String category,
			int isActive) {
		super();
		this.id = id;
		this.name = name;
		this.description = description;
		this.price = price;
		this.category = category;
		this.isActive = isActive;
	}
	
	public Product(String name, String description, double price, String category,
			int isActive) {
		super();
		this.name = name;
		this.description = description;
		this.price = price;
		this.category = category;
		this.isActive = isActive;
	}
	
	public String toString() {
		return "\nID:" + id + " Name:" + name + " Description:" + description + " Price:" + price + " Category:" + category + " isActive:" + isActive;
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

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	
	
	
	

}
