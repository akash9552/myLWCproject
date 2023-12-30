public class JobApplicationTriggerHandler {
    
    Public static void sendEmailMethod(List<Job_Application__c> jANewList){
        
        List<Messaging.Email> sendEmail = new List<Messaging.Email>();
        
        Set<Id> jobApplicationId = new Set<Id>();
        
        for(Job_Application__c ja : jANewList){
            jobApplicationId.add(ja.Id);
        }
        List<Job_Application__c> childToParent = [SELECT ID, Name,status__c,Candidate_ID__r.FIrst_Name__c, Candidate_ID__r.Email__c
                                                  FROM Job_Application__c WHERE ID IN :jobApplicationId];
        List<String> emailList = new List<String>();
        system.debug(emailList);
        
        for(Job_Application__c jap : childToParent){
            if(jap.status__c == 'New' && jap.Candidate_ID__c != null){
                
                    emailList.add(jap.Candidate_ID__r.Email__c);
                    
                    Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                    
                    message.setToAddresses(emailList);
                    
                    String subject = 'Regarding New job application';
                    message.setSubject(subject);
                    
                    String body = 'Hi '+jap.Candidate_ID__r.FIrst_Name__c+' new job application ready with status as new';
                    message.setPlainTextBody(body);
                    
                    sendEmail.add(message);
            }
             Messaging.sendEmail(sendEmail);
        }
    }
}