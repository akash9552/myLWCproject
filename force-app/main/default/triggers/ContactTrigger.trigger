trigger ContactTrigger on Contact (After insert, after update, before delete, before insert, before update) {
    
    if(Trigger.isAfter){
        if(Trigger.isUpdate){
            
            ContactTriggers.updateAccwithOPPfieldWhenConUpdate(Trigger.new);
        }
    }
    if(Trigger.isBefore ){
        if(Trigger.isInsert){
          // ContactTriggers.avoidFirstNameDulicate(Trigger.new);
        }
        if(Trigger.isUpdate){
            //ContactTriggers.avoidDuplicateConUpdate(Trigger.New, Trigger.oldMap);
        }
        
    }
}