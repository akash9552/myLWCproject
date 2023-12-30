public class OpportunityTriggerHandler {

    
    
    //Update Account Rating to ‘Hot on account when opportunity stage equals ‘closed won’

    Public static void updateAccount(List<Opportunity> oppNewList){
        
        set<Id> accountIdSet = new Set<Id>();
        
        for(Opportunity opp : oppNewList){
            if(opp.AccountId != null && opp.StageName == 'Closed won'){
                accountIdSet.add(opp.AccountId);
            }
        }
        List<Account> accList = [ SELECT ID, Rating FROM Account WHERE ID IN :accountIdSet];
        List<Account> accToUpdate = new List< Account>();
        for(Account acc : accList){
            acc.Rating = 'Hot';
            accToUpdate.add(acc);
        }
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
    
    Public static void updateAccount2(List<Opportunity> oppNewList){
        
        List<Account> accListToUpdate = new List<Account>();
        
        for(Opportunity opp : oppNewList){
            if(opp.StageName =='closed won' && opp.AccountId != null){
                Account acc = new Account();
                acc.Id = opp.AccountId;
                acc.Rating ='Hot';
                accListToUpdate.add(acc);
            }
        }
        if(!accListToUpdate.isEmpty()){
            update accListToUpdate;
        }
    }
    
    // if opportunity stageName is closed won or closed lost then its close date is todays date 
    
      public static void setCloseDate(List<Opportunity> oppNewList, Map<Id, Opportunity> oppOldMap) {
        for(Opportunity opp : oppNewList) {
            
            if(oppOldMap != null) {
                if(opp.StageName != oppOldMap.get(opp.Id).StageName) {
                    if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost') {
                        opp.CloseDate = System.today();
                    }
                }
            }else{
                opp.CloseDate = System.today();
            }
            //if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost') {
                
            //}
        }
    }
    
    /*Write trigger such that when Account changes which is associtaed to Opportunity then the 
chaged new Account name and old Account name must be reflect
in description field on opportunity
*/
    Public static void updateChildOpp(List<Opportunity>oppNewList, Map<Id, Opportunity>oppOldMap){
        
        List<Opportunity>oppList=[SELECT Id, Account.Id, Account.Name FROM Opportunity WHERE
                                  AccountId != null AND ID =:oppNewList];
        
        List<Opportunity>oppUpdate = new List<Opportunity>();
        
        for(Opportunity opp:oppList){
            if(opp.AccountId != oppOldMap.get(opp.Id).AccountId){
                //opp.Description = 'old Account Name is';
               // opp.Description = oppOldMap.get(opp.Id).Account.Name;
                //opp.Description= 'New Account Name is';
                opp.Description =opp.Account.Name;
                oppUpdate.add(opp);
            }
        }
        if(!oppUpdate.isEmpty()){
            update oppUpdate;
        }
    }
    
    /*Trigger to check use of custom label
write a trigger such that when opp stageName is update with  Value Proposition then its type changes 
to Existing Customer - Upgrade . please use custom label for stage name and type field .
*/
    Public static void checkCustomLabel(List<Opportunity>oppNewList, Map<Id, Opportunity>oppOldMap ){
        
        for(Opportunity opp :oppNewList){
            if(oppOldMap != null){
                if(opp.StageName != oppOldMap.get(opp.Id).StageName){
                    if(opp.StageName == Label.Custom_label_for_opp_stage_name ){
                        opp.Type = Label.Custom_label_for_opp_Type;
                    }
                }
            }else{
                opp.Type = Label.Custom_label_for_opp_Type;
            }
        }
    }
    
    // when lead source is "web" then probablity should be 50%
    public static void handleBeforeMethod(List<Opportunity>oppNewList, Map<Id,Opportunity> oppOldMap){
        
        for(Opportunity opp : oppNewList){
            
            if(oppOldMap != null){
                
                if(opp.LeadSource != oppOldMap.get(opp.Id).LeadSource){
                    if(opp.LeadSource =='Web'){
                        opp.Probability = 50;
                    }
                }
            } else{
                opp.Probability = 50;
            }
        }
    }
 
    /*
      When a Opportunity Stage (field) is changed, create a Task record on
      Opportunity and assign it to Logged In User/Opportunity Owner / Any User.
     */
    Public static void taskCreationOnOppUpdate(List<Opportunity> oppNewList, Map<Id, Opportunity>oppOldMap){
        
        List<Task> tasktoAssign = new List<Task>();
        
        for(Opportunity opp : oppNewList){
            if(opp.StageName !=oppOldMap.get(opp.Id).StageName){
                Task t= new Task();
                t.WhatId = opp.Id;
                t.Subject = 'Email';
                t.Priority = 'Normal';
                t.status = 'Not Started';
                t.OwnerId = UserInfo.getUserId();
                tasktoAssign.add(t);
            }
        }
        if(!tasktoAssign.isEmpty()){
            insert tasktoAssign;
            system.debug(tasktoAssign);
        }
    }
    
    /*
     Write a trigger on Account when Account Active field is updated from ‘Yes’
     to ‘No’ then check all opportunities associated with the account. Update all
     Opportunities Stage to close lost if stage not equal to closed won.
     */
    Public static void updateOppOnUpdateAccount(List<Account> accNewList, Map<Id, Account>accOldMap){
        
        List<Id>accId =new List<Id>();
        
        for(Account acc :accNewList){
            if(acc.IsActive__c != accOldMap.get(acc.id).IsActive__c && acc.IsActive__c == False){
                accId.add(acc.Id);
            }
        }
        List<Account> parentToChild = [SELECT Id, IsActive__c,(SELECT ID, StageName FROM Opportunities) 
                                       FROM Account WHERE Id IN :accId];
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc :parentToChild){
            if(acc.Opportunities != null){
                for(Opportunity opp :acc.Opportunities){
                    if(opp.StageName != 'closed Won' && opp.StageName != 'Closed lost'){
                        opp.StageName ='Clased Lost';
                        oppList.add(opp);
                    }
                }
            }
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
    
    /* update the parent Account field with the Opportunity Name that has the highest Amount
     */
    
    Public static void updateAccWithHigestOppName(List<Opportunity> oppNewList, Map<Id, Opportunity> oppOldMap){
        
        set<Id> accountIdset = new Set<Id>();
        
        for(Opportunity opp: oppNewList){
            if(opp.AccountId != null && opp.Amount != Null){        
                if(opp.AccountId !=oppOldMap.get(opp.Id).AccountId){
                    accountIdset.add(opp.AccountId);					// this work in update condition
                    accountIdset.add(oppOldMap.get(opp.Id).AccountId); // using this we store id of acc if opp Amount changes
                }else{
                    accountIdset.add(opp.AccountId);            // This will work in insert condition
                }
            }
            else{
                   accountIdset.add(opp.AccountId);
            }
        }
        List<Account> accList =[select Id, Name, Higest_Amount_Opp__c,(select Name, Amount from Opportunities 
                                                                      where Amount !=null order by Amount desc LIMIT 1) 
                               								 from Account where Id IN:accountIdset];
        List<Account> accListUpdate = new List<Account>();
        
        for(Account acc :accList){
            if(!acc.Opportunities.isEmpty()){
                
                acc.Higest_Amount_Opp__c = acc.Opportunities[0].Name;
                accListUpdate.add(acc);
            }else{
                 accListUpdate.add(acc);
            }
        }
        if(!accListUpdate.isEmpty()){
            update accListUpdate;
        }
    }
    
    Public static void updateParent(List<Opportunity> oppNewList, Map<Id, Opportunity> oppOldMap){
        
        set<Id> oppAccountId = new set<Id>();
        
        for(Opportunity opp : oppNewList){
            if(opp.AccountId != null){
                oppAccountId.add(opp.AccountId);
            }
        }
        Map<Id,Opportunity> oppMap =new Map<Id, Opportunity>([select Id, Name, AccountId, Account.Higest_Amount_Opp__c, Amount from Opportunity 
                                     where Id IN:oppAccountId AND Amount != null order by Amount desc LIMIT 1]);
        
        List<Account> accListUpdate = new List<Account>();
        
        for(Opportunity opp:oppNewList){
            Account acc = new Account();
                acc.Id=oppMap.get(opp.AccountId).AccountId;
                acc.Higest_Amount_Opp__c =oppMap.get(opp.AccountId).Name;
            accListUpdate.add(acc);
        }
        if(!accListUpdate.isEmpty()){
            update accListUpdate;
        }
    }
}