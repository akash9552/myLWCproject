Trigger AccountTrigger on Account (before insert){
    
    if(Trigger.isBefore){
        if(Trigger.isInsert){
            ErrorMsgUseVs.accAmountNotNull(Trigger.new);
        }
    }
}