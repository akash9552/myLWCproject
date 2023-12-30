public class EmailSendingClass {
    
    public static void sendEmail(List<Contact>conNewlist){
              
        List<String> emailaddress = new List<String>();
         emailaddress.add('pradeepgutte2001@gmail.com');
        
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage sendEmail = new Messaging.SingleEmailMessage();
        
        sendEmail.setToAddresses(emailAddress);
        
        sendEmail.setSubject('Apex Subject');
        String body = 'Apex Email Body : This is just a testing';
        sendEmail.setPlainTextBody(body);
        listMail.add(sendEmail);
        
        for(Contact con : conNewlist){
           
            if(con.AccountId != null && con.Email != null){
                
                 emailaddress.add(con.Email);
                
                sendEmail.setTargetObjectId(con.Id); 
                
               //sendEmail.setTemplateId(listMail);
                
                
            }
            if(emailaddress.size()>0){
           Messaging.sendEmail(listMail);
            }
        }
    }
    
}