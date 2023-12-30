trigger RevewTrigger on Revew__c (After insert, after Update) {

    if(Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate){
            RevewTriggerHandlerClass.updatePosition(Trigger.new);
        }
    }
}