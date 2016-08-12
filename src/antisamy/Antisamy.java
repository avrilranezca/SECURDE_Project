package antisamy;

import org.owasp.validator.html.AntiSamy;
import org.owasp.validator.html.Policy;
import org.owasp.validator.html.PolicyException;
import org.owasp.validator.html.ScanException;

public class Antisamy {
	
	private static String POLICY_FILE_LOCATION = "antisamy-ebay-1.4.4.xml";

	public static String sanitize(String input) {
		try {
			Policy policy = Policy.getInstance(POLICY_FILE_LOCATION);
			AntiSamy as = new AntiSamy();
			return as.scan(input, policy).getCleanHTML();
		} catch (ScanException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (PolicyException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "";
	}
	
	public static void main(String[] args)  {
		System.out.println(Antisamy.sanitize("<html>shit"));
	}
}
