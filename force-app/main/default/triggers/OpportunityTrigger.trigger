trigger OpportunityTrigger on Opportunity (after insert, after update, after delete) {
    if (Trigger.isAfter){
        if(Trigger.isInsert || Trigger.isUpdate) {
            swatiTrigger.updtAccHighAmount(Trigger.new);
        }else if (Trigger.isDelete) {
            swatiTrigger.updtAccHighAmount(Trigger.old);
        }
    }
}