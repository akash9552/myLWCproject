public class BatchClass implements Database.Batchable<sObject>, Database.Stateful {
    
    list<String>emaillist = new List<String>();
    
    public Database.QueryLocator start(Database.BatchableContext info) {
        
        String query = 'SELECT Id, Owner.Email FROM Case WHERE Status = \'New\'';
        
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext info, List<Case> caseList) {
        
        for(Case cs : caseList){
            
            emaillist.add(cs.Owner.Email);
            
        }
      
    }
    public void finish(Database.BatchableContext info) {
        
        System.debug('Finish emailList : '+emailList);
        
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage sendEmail = new Messaging.SingleEmailMessage();
        
        sendEmail.setToAddresses(emailList);
        sendEmail.setSubject('Case Subject');
        String body = 'A case has been just assigned to you';
        sendEmail.setPlainTextBody(body);
        listMail.add(sendEmail);
        
        Messaging.sendEmail(listMail);

       
    }
}