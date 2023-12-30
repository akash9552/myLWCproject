public class CallProcessBuilder {
	@InvocableMethod
    public static void updateAccountField(){
        
        List<Account> accList = [select Id, Industry, Type from Account where Industry ='Agriculture' AND Type ='Prospect'];
        system.debug(accList);
        List<Account> accListupdate = new List<Account>();
         system.debug(accListupdate);
        for(Account acc:accList){
            acc.Type ='Other';
            acc.Phone ='95522298@';
            accListupdate.add(acc);
        }
        
        update accListupdate;
        
    }
}