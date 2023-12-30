public class ConHandlerClass3 {
    
    public static void sendEmailMethod(List<Contact> conList){

        
        EmailTemplate et =[SELECT Id FROM EmailTemplate WHERE Name =:'new contact email templet'];
        
        List<Messaging.SingleEmailMessage> emails = new List<Messaging.SingleEmailMessage>();  
        
        List<String> setEmail = new List<String>();
        
        for(Contact con : conList){
            if(con.AccountId != null && con.Email != null){
                Messaging.SingleEmailMessage singleMail = new Messaging.SingleEmailMessage();
                
                singleMail.setToAddresses(setEmail);
                
                singleMail.setTargetObjectId(con.Id);
                singleMail.setTemplateId(et.Id);
                
                emails.add(singleMail);
            }
        }
        
        Messaging.sendEmail(emails);
        
    }
}