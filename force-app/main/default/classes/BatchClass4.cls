public class BatchClass4 implements Database.Batchable<sObject>, Database.Stateful {
    
  public Database.QueryLocator start(Database.BatchableContext info) {
        
        String query = 'SELECT Id, Owner.Email FROM Case WHERE Status = \'New\'';
        
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Account> caseList){
        
        
    }
    public void finish(Database.BatchableContext info){
        
    }
    
}