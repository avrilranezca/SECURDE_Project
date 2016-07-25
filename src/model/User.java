package model;

public class User {
	
	public static final String customer = "CUSTOMER";
	public static final String admin = "ADMIN";

	
	private int id;
	private String first_name;
	private String last_name;
	private String middle_initial;
	private String user_name;
	private String password;
	private String email;
	private int billing_address_id;
	private int shipping_address_id;
	private String account_type;
	private int isActive;
	
	public User(int id, String first_name, String last_name,
			String middle_initial, String user_name, String email,
			String account_type, int isActive) {
		super();
		this.id = id;
		this.first_name = first_name;
		this.last_name = last_name;
		this.middle_initial = middle_initial;
		this.user_name = user_name;
		this.email = email;
		this.account_type = account_type;
		this.isActive = isActive;
	}
	
	public User(String first_name, String last_name,
			String middle_initial, String user_name, String email,
			String account_type, int isActive) {
		super();
		this.first_name = first_name;
		this.last_name = last_name;
		this.middle_initial = middle_initial;
		this.user_name = user_name;
		this.email = email;
		this.account_type = account_type;
		this.isActive = isActive;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getFirst_name() {
		return first_name;
	}

	public void setFirst_name(String first_name) {
		this.first_name = first_name;
	}

	public String getLast_name() {
		return last_name;
	}

	public void setLast_name(String last_name) {
		this.last_name = last_name;
	}

	public String getMiddle_initial() {
		return middle_initial;
	}

	public void setMiddle_initial(String middle_initial) {
		this.middle_initial = middle_initial;
	}

	public String getUser_name() {
		return user_name;
	}

	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getBilling_address_id() {
		return billing_address_id;
	}

	public void setBilling_address_id(int billing_address_id) {
		this.billing_address_id = billing_address_id;
	}

	public int getShipping_address_id() {
		return shipping_address_id;
	}

	public void setShipping_address_id(int shipping_address_id) {
		this.shipping_address_id = shipping_address_id;
	}

	public String getAccount_type() {
		return account_type;
	}

	public void setAccount_type(String account_type) {
		this.account_type = account_type;
	}

	public int getIsActive() {
		return isActive;
	}

	public void setIsActive(int isActive) {
		this.isActive = isActive;
	}
	
}
