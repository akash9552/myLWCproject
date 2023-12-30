public with sharing class ErrorMsgUseVs {
    


    Public static void accAmountNotNull(List<Account> accNewList){

        for(Account acc:accNewList){
            if(acc.Email__c == null){
                acc.addError('please enter email');
            }
        }
    }
}