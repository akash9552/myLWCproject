public class positionTriggerHndaler {
    // email send code
    Public static void sendEmailToHr(List<position__c> posNewList){
        
        List<Messaging.Email>EmailList = new List<Messaging.Email>();
        
        Set<Id> setofPositionId = new Set<Id>();
        
        for(position__c pos :posNewList){
            setofPositionId.add(pos.Id);
            
        }
        for(position__c pos :[SELECT Id, Name,status__c, Hiring_Manager__r.Email,Hiring_Manager__r.Name FROM
                              position__c where Id IN :setofPositionId]){
                                  
                                  if(pos.status__c == 'Open Approval' && pos.Hiring_Manager__c != null){
                                      
                                      Messaging.SingleEmailMessage message = new Messaging.SingleEmailMessage();
                                      
                                      List<String> toadress = new List<String>{
                                          pos.Hiring_Manager__r.Email
                                              };
                                                  System.debug(toadress);
                                      message.setToAddresses(toadress);
                                      
                                      string subject = 'Regarding contact creation';
                                      message.setSubject(subject);
                                      System.debug(subject);
                                      String body = 'Hi '+pos.Hiring_Manager__r.Name+' your Position is created sucessfully';
                                      message.setPlainTextBody(body);
                                      System.debug(body);
                                      EmailList.add(message);
                                      
                                  }
                                  Messaging.sendEmail(EmailList);
                                  
                              }
        
    }
    
    // when Phone or Email on Position object changes papulate these values in Revew records
    
    public static void updateRevewPosition(List<Position__c> newPosList, Map<Id, Position__c> oldPositionMap){
        
        Map<Id, Position__c> updatedMap = new Map<Id, Position__c>();
        
        for(Position__c pos:newPosList){
            if(pos.Phone__c !=oldPositionMap.get(pos.Id).Phone__c || pos.Email__c !=oldPositionMap.get(pos.Id).Email__c){
                updatedMap.put(pos.Id, Pos);
            }
        }
        List<Revew__c> revList =[select Id, Email__c, Phone__c, Revew__c.position__c from Revew__c where position__C In:updatedMap.Values()];
        
        List<Revew__c> revListUpdate = new List<Revew__c>();
        
        for(Revew__c rev : revList){
            rev.Email__c=updatedMap.get(rev.position__C).Email__c;
            rev.Phone__c=updatedMap.get(rev.position__C).Phone__c;
            revListUpdate.add(rev);
        }
        if(!revListUpdate.isEmpty()){
            update revListUpdate;
        }
    }
}