trigger CaseTrigger on Case (before insert, before update, after insert, after update, after delete, after undelete) {
    if(Trigger.isAfter){
        if(Trigger.isInsert){
            RollupTrigger.insertDeleteUndeleteMethod(Trigger.new);
        }
        if(Trigger.isUpdate){
            RollupTrigger.updateMethod(Trigger.new, Trigger.oldMap);
        }
        if(Trigger.isDelete){
            RollupTrigger.insertDeleteUndeleteMethod(Trigger.old);
        }
        if(Trigger.isUndelete){
            RollupTrigger.insertDeleteUndeleteMethod(Trigger.new);
        }
    }
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            RollupTrigger.avoidduplicateCase(Trigger.new);
        }
    }
}