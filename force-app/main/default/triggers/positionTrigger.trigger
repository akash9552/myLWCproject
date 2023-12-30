trigger positionTrigger on position__c (after insert, after update) {
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            positionTriggerHndaler.updateRevewPosition(Trigger.new, Trigger.oldMap);
        }
    }
}