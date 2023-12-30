public class ScheduleClass3 implements Schedulable{
    
    public void execute (SchedulableContext sc){
        
         List<String> emailAddress = new List<String>();
         emailaddress.add('akashgutte9552@gmail.com');
               
        
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
        
        Messaging.SingleEmailMessage sendEmail = new Messaging.SingleEmailMessage();
        
        sendEmail.setToAddresses(emailAddress);
        sendEmail.setSubject('Apex Subject');
        
        String body = 'Congratulations you are selected in salesforce . we are offering you seven lakh, if you are interested please contact on below details';
        sendEmail.setPlainTextBody(body);
        listMail.add(sendEmail);
        
        Messaging.sendEmail(listMail);

    }

}