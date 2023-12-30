public class BatchClass3 implements Database.Batchable<sObject>,Database.allowsCallouts{
    
    public Database.QueryLocator start(Database.BatchableContext info){
        
        String query = 'SELECT Id, Name FROM Account';
        
        return Database.getQueryLocator(query);
 
    }
    
    public void execute(Database.BatchableContext info, List<Account> accountList){
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://restapi.adequateshop.com/api/Tourist?page=2');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        
        System.debug('Status Code : '+res.getStatusCode());
        System.debug('Body : '+res.getBody());
        
    }
    
    public void finish(Database.BatchableContext info){
        
    }
}