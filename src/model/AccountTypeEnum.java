package model;

public class AccountTypeEnum {
	
	public enum AccountType {
		CUSTOMER, ADMIN, PRODUCT_MANAGER, ACCOUNTING_MANAGER
	}
	
	AccountType type;
	
	public AccountTypeEnum(AccountType type) {
		this.type = type;
	}
	
	public String accountTypeDetails() {
		System.out.println("TYPE: "+type);
		switch(type) {
		
			case CUSTOMER: return "CUSTOMER"; 
			case ADMIN: return "ADMIN";
			case PRODUCT_MANAGER: return "PRODUCT_MANAGER";
			case ACCOUNTING_MANAGER: return "ACCOUNTING_MANAGER";
			default: return "";
		}
	}

}
