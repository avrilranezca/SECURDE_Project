import java.util.ArrayList;
import java.util.Date;

import model.AccountTypeEnum.AccountType;
import model.Address;
import model.Category;
import model.Product;
import model.Review;
import model.Transaction;
import model.TransactionEntry;
import model.User;
import model.AccountTypeEnum;
import database.CategoryDAO;
import database.ProductDAO;
import database.ReviewDAO;
import database.TransactionDAO;
import database.UserDAO;


public class TestDriver {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UserDAO udao = new UserDAO();
		ProductDAO pdao = new ProductDAO();
		CategoryDAO cdao = new CategoryDAO(); 
		ReviewDAO rdao = new ReviewDAO();
		TransactionDAO tdao = new TransactionDAO();
		AccountTypeEnum customer = new AccountTypeEnum(AccountType.CUSTOMER);
		AccountTypeEnum accountManager = new AccountTypeEnum(AccountType.ACCOUNTING_MANAGER);
		/*User u = new User("user5", "user5", "u", "user_5", "user5@securde.com", accountManager.accountTypeDetails(), 1);
		u.setPassword("password");
		udao.addUser(u);*/
		
		User u = udao.getUser("user_1", "password");
		//udao.incrementLogInAttempts(u.getId());
		udao.resetLogInAttempts(u.getId());
		
		//udao.lock(u.getId());
		//System.out.println(udao.isLocked(u.getId()));
		//udao.unlock(u.getId());
		
		//udao.updatePassword(u, "password");
		
		//System.out.println(udao.getUser("user_1", "password").getEmail());
		
		/*udao.setUserSessionID(u, "newSessionID");
		System.out.println(udao.getUserSessionID(u));*/
		
		//System.out.println(u.getId());
		
		//System.out.println(udao.getUserSessionID(u));
		/*System.out.println(u.getAccount_type());*/
		/*if(u != null) {
			System.out.println(u.getEmail());
			
			udao.updatePassword(u, "newpassword");
			
			User u2 = udao.getUser(u.getUser_name(), "newpassword");
			
			System.out.println(u2.getEmail());
			
		}
		else
			System.out.println("No such user");*/
		
		//Address a = new Address("Uhouse1", "street1", "subdivision1", "city1", "postalcode1", "country1");
		
		//udao.updateBillingAddress(u, a);
		
		
		/*Product p = new Product("boot2", "boot2des", 2.34, 1, 1);
		pdao.addProduct(p);*/
		
		
		/*Category c = cdao.getCategory("boots");
		System.out.println(c.getId() + " " + c.getName());
		
		ArrayList<Product> productList = pdao.getAllProducts();
		Product p = productList.get(0);
		
		p.setName("yo");
		
		pdao.updateProduct(p);
		pdao.deleteProduct(p);
		
		System.out.println(productList);*/
		
/*		java.util.Date dt = new java.util.Date();

		java.text.SimpleDateFormat sdf = 
		     new java.text.SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

		String currentTime = sdf.format(dt);*/
		
		/*Review r = new Review(1, 1, "review of 1 of 1", new Date(), 4);
		rdao.addReview(r);*/
		
		
		/*System.out.println(rdao.getReviewByProduct(pdao.getProductOnID(1)));*/
		
		/*Transaction t = new Transaction(1, new Date());
		ArrayList<TransactionEntry> teList = new ArrayList<TransactionEntry>();
		
		teList.add(new TransactionEntry(1, 2, 1));
		teList.add(new TransactionEntry(2, 3, 1.23));
		teList.add(new TransactionEntry(3, 1, 2.34));
		
		tdao.addTransaction(t, teList);*/
		
		/*System.out.println(tdao.getSalesPerProduct());
		System.out.println(tdao.getSalesPerCategory());
*/
		//System.out.println(rdao.getReviewByProduct(pdao.getProductOnID(1)));
		
		/*System.out.println(tdao.getTotalSales("yearly"));
		System.out.println(tdao.getTotalSales("monthly"));
		System.out.println(tdao.getTotalSales("daily"));*/
		
		/*Product p = pdao.getProductOnID(4);
		
		System.out.println(rdao.getAverageRating(p));*/
		
		// Pagination stuff
		/*int page = 1;
		int productsPerPage = 2;
		int noOfProducts = pdao.getNoOfProducts();
		Category c = cdao.getCategory(1);
		
		System.out.println(pdao.searchProductsPagination("boot", (page-1)*productsPerPage,
                productsPerPage));
		
		page++;
		
		System.out.println(pdao.searchProductsPagination("boot", (page-1)*productsPerPage,
                productsPerPage));*/
		
		//int noOfPages = (int) Math.ceil(noOfProducts * 1.0 / productsPerPage);
		
		/*User u = udao.getUser("user_1", "password");
		Product p = pdao.getProductOnID(4);
		
		System.out.println(rdao.hasBought(u, p));*/
		
		/*Review r = new Review("user_2", 2, "my review 2-2", new Date(), 3);
		rdao.addReview(r);*/
		
		/*Address a = new Address("1", "shippingstreet1", "shippingsubdivision1", "shippingcity1", "shipping1", "shippingcountry1");
		User u = udao.getUser("user_1", "password");
		//udao.updateShippingAddress(u, a);
		System.out.println(udao.getShippingAddress(u.getId()));*/
	}

}
