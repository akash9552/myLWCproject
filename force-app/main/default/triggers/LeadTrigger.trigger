trigger LeadTrigger on Lead (after Insert, before insert, before update){
    
    if(duplicateLead.executeTrigger){
        duplicateLead.executeTrigger=false;
        
        if(Trigger.isBefore && Trigger.isInsert){
            duplicateLead.createDuplicateLead(Trigger.new);
        }
    }
}