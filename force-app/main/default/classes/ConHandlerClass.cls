public class ConHandlerClass {
    
    public static void whenConCreateSendEmail(list<Contact>conOldlist){
        
        EmailTemplate et = [Select id from EmailTemplate where name = :'new contact email templet'];
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();   
        
        for(Contact con : conOldlist){
            
            if(con.AccountId != null && con.Email != null){
                
                Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
                
                singleMail.setTargetObjectId(con.Id);
                singleMail.setTemplateId(et.Id);
                
                  emails.add(singleMail);
                
            }
        }
         Messaging.sendEmail(emails);
                 
    }
    
}