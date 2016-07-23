import model.AccountTypeEnum.AccountType;
import model.User;
import model.AccountTypeEnum;
import database.UserDAO;


public class TestDriver {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UserDAO udao = new UserDAO();
		
		AccountTypeEnum customer = new AccountTypeEnum(AccountType.CUSTOMER);
		/*User u = new User("user1", "user1", "u", "user_1", "user1@securde.com", customer.accountTypeDetails(), 1);
		u.setPassword("password");
		dc.addUser(u);*/
		
		User u = udao.getUser("user_1", "password");
		if(u != null)
			System.out.println(u.getEmail());
		else
			System.out.println("No such user");
	}

}
