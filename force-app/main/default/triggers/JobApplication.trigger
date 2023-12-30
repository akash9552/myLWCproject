trigger JobApplication on Job_Application__c (After insert) {
    
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            JobApplicationTriggerHandler.sendEmailMethod(Trigger.new);
        }
    }
}