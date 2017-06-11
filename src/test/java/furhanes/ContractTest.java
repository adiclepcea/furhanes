package furhanes;

import java.util.Date;

import org.clepcea.model.Contract;
import org.junit.Before;
import org.junit.Test;
import static org.junit.Assert.*;

public class ContractTest {
	Contract contract = new Contract();
	@Before
	public void init(){
		//set expiration date 10 days before
		contract.setExpirationDate(new Date((new Date()).getTime()-(1000*3600*24*10)));
	}
	
	@Test
	public void testMustRenewWithExtendAndNotUndefinite(){		
		assertEquals(true, contract.mustRenew());
	}
	
	@Test
	public void testMustRenewWithoutExtendAndNotUndefinite(){
		contract.setUndefinite(true);
		assertEquals(false, contract.mustRenew());
		
	}
	
	@Test
	public void testMustRenewWithExtendAndUndefinite(){
		contract.setDoNotRenew(true);
		assertEquals(false, contract.mustRenew());
	}
	
	
	@Test
	public void testMustRenewnDaysWithExtendAndNotUndefinite(){		
		//10 days after now
		contract.setExpirationDate(new Date((new Date()).getTime()+(1000*3600*24*10)));
		assertEquals(true, contract.mustRenewInDays(10));
		assertEquals(false, contract.mustRenewInDays(9));
	}
	
	@Test
	public void testMustRenewInDaysWithoutExtendAndNotUndefinite(){
		//10 days after now
		contract.setExpirationDate(new Date((new Date()).getTime()+(1000*3600*24*10)));
		contract.setUndefinite(true);
		assertEquals(false, contract.mustRenewInDays(11));
	}
	
	@Test
	public void testMustRenewInDaysWithExtendAndUndefinite(){
		//10 days after now
		contract.setExpirationDate(new Date((new Date()).getTime()+(1000*3600*24*10)));
		contract.setDoNotRenew(true);
		assertEquals(false, contract.mustRenewInDays(11));
	}
	
}
