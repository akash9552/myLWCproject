trigger CalculatorTrigger on Calculator__c (before insert,before update) {
    
    if(Trigger.isBefore){
        if(Trigger.isInsert || Trigger.isUpdate){
            
               CalculatorClassHandler.calMethod(Trigger.new);
    
        }
    }
    
 
}