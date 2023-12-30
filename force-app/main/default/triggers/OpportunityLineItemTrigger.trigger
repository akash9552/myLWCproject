trigger OpportunityLineItemTrigger on OpportunityLineItem (before insert) {
    
    if(Trigger.isAfter && Trigger.isInsert){
        OpliItemTriggerHandler.createAsset(Trigger.new);
    }

}