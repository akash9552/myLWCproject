public class SOQLClass2 {
    public static void myMethod1(){
        List<Contact>crList = [SELECT Id,Name,CreatedDate FROM Contact ORDER BY CreatedDate ASC];
        for(Contact cc : crList ){
            System.debug(cc);
        }     
    }
    public static void myMethod2(){
        List<Contact>conList = [SELECT Id, Name,ACCOUNT.NAME,accountId FROM Contact WHERE account.Id !=null];
        for(Contact con :conList){
            system.debug(con);
        } 
    }
    public static void ContactMethod3(){
        List<Contact> ConList1 = [ SELECT Id ,AccountId,Name FROM Contact 
                                  WHERE Name IN ('Sarah Smith','Jessi Jones')];
        for(Contact cont :ConList1){
            system.debug(cont);
        }
    }
    public static void ContactMethod4(){
        List<Opportunity> OppList = [SELECT Name, Id,AccountId,Account.IsActive__c
                                     FROM Opportunity WHERE Account.IsActive__c = true];
        for(Opportunity opp :OppList){
            system.debug(opp);
        }	
    }
}