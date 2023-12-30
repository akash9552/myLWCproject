trigger AccounTriggerWorkSpace2 on Account (after update) {
    if(AccountTriggers.ExecuteTrigger){
        AccountTriggers.ExecuteTrigger=false;
         if(Trigger.isAfter && Trigger.isUpdate){
        AccountTriggers.appulateTotalOppAmountOnAcc(Trigger.new);
    }
    }
   

}