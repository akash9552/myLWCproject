public class ParentChildClass {
    public static void myMethod(){
        List<Account> accList = [SELECT Id,Name,(SELECT Id,Name FROM Contacts)FROM Account WHERE Id = '0015i00000BNsqXAAT'];
        
        for(Account acc:accList){
            for(Contact con: acc.Contacts){
                system.debug(con.Name);
            }
        }
    }
     public static void myMethod2(){
        List<position__c> posList = [SELECT Id,Name,(SELECT Id,Name FROM Job_Postings__r)FROM position__c ];
        
        for(position__c pos : posList){
            for(Job_Posting__c jpo: pos.Job_Postings__r){
                system.debug(jpo.Name);
            }
        }
    } 
}