public class AssignChildBatchClass implements Database.Batchable<sObject> {
    
    Map<Id, Contact> Conmap2 = new Map<Id, Contact>();
    
    Public AssignChildBatchClass(Map<Id, Contact> comMap) {
        Conmap2 = comMap;
    }
    
    public Database.QueryLocator start(Database.BatchableContext info) {
        
        String query = 'SELECT Id, LastName, Phone from Contact where Id IN:Conmap2.keySet()';
        
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext info, List<Contact> caseList) {
        
        List<Account> accList = new List<Account>();
        
        for(Contact con : caseList){
            Account acc = new Account();
            acc.Id = con.AccountId;
            acc.Name =con.LastName;
            acc.Phone =con.Phone;
            accList.add(acc);
        }
        
        If(!accList.isEmpty()){
            insert accList;
        }
    }
    public void finish(Database.BatchableContext info) {
        
    }
}