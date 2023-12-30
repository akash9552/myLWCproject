public class PracticeClassSoql {
	
    public static void myOrderMethod1(){
        List<Contact>crList = [SELECT Id,Name,CreatedDate FROM Contact ORDER BY CreatedDate ASC];
        for(Contact cc : crList ){
            System.debug(cc);
        }     
    
    
    List<Contact>conList = [SELECT Id, Name,ACCOUNT.NAME,accountId FROM Contact WHERE account.Id !=null];
    for(Contact con :conList){
        system.debug(con);  
    }
    List<Contact> ConList1 = [ SELECT Id ,AccountId,Name FROM Contact 
                              WHERE Name IN ('Sarah Smith','Jessi Jones')];
    for(Contact cont :ConList1){
        system.debug(cont);
        
    }
    
    List<Opportunity> OppList = [SELECT Name, Id,AccountId,CurrencyIsoCode 
                                 FROM Opportunity WHERE isDeleted = true ALL ROWS];
    for(Opportunity opp :OppList){
        system.debug(opp);    
    }
}
    
    // Get the account records having at least one contact record
    
    Public static void myMethod(){
        
        Set<Id>AccountiDset= new Set<Id>();
        
        List<Contact>conList = [SELECT ID, Name, AccountId FROM Contact];
        
        for(Contact con :conList){
            
            AccountiDset.add(con.AccountId);
        }
        List<Account>accHvingCon = [SELECT Id, Name FROM Account WHERE ID IN :AccountiDset];
        
        for(Account acc: accHvingCon){
            
            System.debug(acc);
        }
        
    }
    Public static void MyMethod1(){
        
        Set<Id>accountIds = new Set<Id>();
        
        List<Contact>conList = [SELECT Id, AccountId FROM Contact];
        
        for(Contact con : conList){
            
            accountIds.add(con.AccountId);
        }
        List<Account>accounthaveChild = [SELECT Id, Name FROM Account WHERE ID IN :accountIds];
        
        for(Account acc : accounthaveChild){
            
            System.debug(acc);
        }
    }
    public static void myMethod2(){

	List<Account>parentTOchildList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts)FROM Account];

		for(Account acc : parentTOchildList){
			
			for(Contact con : acc.Contacts){

				System.debug(con);

				}
			}
	}
}