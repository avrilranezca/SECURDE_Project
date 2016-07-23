package model;

public class Address {

	private int id;
	private String house_no;
	private String street;
	private String subdivision;
	private String city;
	private String postal_code;
	private String country;
	
	public Address(int id, String house_no, String street, String subdivision,
			String city, String postal_code) {
		super();
		this.id = id;
		this.house_no = house_no;
		this.street = street;
		this.subdivision = subdivision;
		this.city = city;
		this.postal_code = postal_code;
	}
	
	public Address(String house_no, String street, String subdivision,
			String city, String postal_code) {
		super();
		this.house_no = house_no;
		this.street = street;
		this.subdivision = subdivision;
		this.city = city;
		this.postal_code = postal_code;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getHouse_no() {
		return house_no;
	}

	public void setHouse_no(String house_no) {
		this.house_no = house_no;
	}

	public String getStreet() {
		return street;
	}

	public void setStreet(String street) {
		this.street = street;
	}

	public String getSubdivision() {
		return subdivision;
	}

	public void setSubdivision(String subdivision) {
		this.subdivision = subdivision;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getPostal_code() {
		return postal_code;
	}

	public void setPostal_code(String postal_code) {
		this.postal_code = postal_code;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}
	
	
	
	
}
