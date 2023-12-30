public class OpportunityTriggers {

    /*Create a fields on Opportunity Client Contact, Once an Opportunity client
	Contact update then update Account client contact with same on Opportunity Client Contact Opportunity_Client_Contact__c*/
    public static void upadteAccIfOppupdate(List<Opportunity> oppnewlist, Map<Id, Opportunity> oppOldMap){
        
        List<Account> acclistUpdate = new List<Account>();
        
        for(Opportunity opp:oppnewlist){
            if(opp.AccountId != null){
                if(opp.Opportunity_Client_Contact__c !=oppOldMap.get(opp.Id).Opportunity_Client_Contact__c){
                   Account acc = new Account();
                    acc.Id= opp.AccountId;
                    acc.Opportunity_Client_Contact__c = opp.Opportunity_Client_Contact__c;
                    acclistUpdate.add(acc);
                }
            }
        }
        if(!acclistUpdate.isEmpty()){
            update acclistUpdate;
        }
    }
    
    //If Opportunity Stage is Closed won, Create a task with Subject- 'Task Created'.Task is other object.
    Public static void createTaskOnOpp(List<Opportunity> oppnewList, Map<Id, Opportunity>oppOldMap){
        List<Task>taskList = new List<Task>();
        
        for(Opportunity opp:oppnewList){
            if(opp.StageName !=oppOldMap.get(opp.Id).StageName && opp.StageName =='Closed Won'){
                
                Task tk = new Task();
                tk.WhatId =opp.Id;
                tk.Status ='Not Started';
                tk.Subject='Task Created';
                tk.Priority='Normal';
                taskList.add(tk);
            }
        }
        if(!taskList.isEmpty()){
            insert taskList;
        }
    }
}