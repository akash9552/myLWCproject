trigger Student1Trigger on Student1__c (before insert, before update) {
    if(Trigger.isbefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            Student1TriggerHandler.Mymethod(Trigger.new);
        }
    }
}