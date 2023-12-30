public class OpportunityTriggerHandler12 {
    //when opportunity inserted with no parent account then create a parent account for that opportunity
    
    public static void createParentAccount(List<Opportunity>oppNewList){
        
        
        List<Opportunity>oppList = [SELECT Id, AccountId FROM Opportunity WHERE Id =:oppNewList];
        
        List<Account>accListInsert = new List<Account>();
        
        for(Opportunity opp : oppList){
            if(opp.AccountId == null){
                Account acc = new Account();
                acc.Id = opp.AccountId;
                acc.Name = opp.Name;
                accListInsert.add(acc);
            }
        }
        if(!accListInsert.isEmpty()){
            insert accListInsert;
        }
    }
   /* when opportunity is inserted or update and they have associate with any parent account 
        then opportunity status display as Accaunt status
  */
    Public static void updateParentAccount(List<Opportunity>oppnewlist){
        
        List<Account>acctoupdate = new List<Account>();
        
        for(Opportunity opp : oppnewlist){
            if(opp.Status__c != null && opp.AccountId != null){
                Account acc = new Account();
                acc.Id = opp.AccountId;
                acc.status__c =opp.Status__c;
                acctoupdate.add(acc);
            }
        }
        if(!acctoupdate.isEmpty()){
            update acctoupdate;
        }
    }
    
    // write a trigger such that only system admin are abel to edit the record
    
    Public static void systemAdminCanedit(List<Opportunity>oppoldList) {
        
        Id currentProfileId = userInfo.getProfileId();
        
        system.debug(currentProfileId);
        
        Profile currentProfileName =[select Name from profile where Id =:currentProfileId];
        
        system.debug(currentProfileName);
        
        for(Opportunity opp :oppoldList){
            if(currentProfileName.Name != 'System Administrator'){
                opp.addError('only system admin can edit the record');
            }
        }
    }
   /* 
    write a trigger such that when Account record of any perticular opportunity is changed then papulate the new Account Name
        and old Account Name in descripton box of Opportunity record.
 */
    Public static void updateOpp(List<Opportunity> oppNewList, Map<Id, Opportunity> oppOldMap){
        
        set<Id> newaccId = new set<Id>();
        
        for(Opportunity opp:oppNewList){
            if(opp.AccountId != null){
                if(opp.AccountId !=oppOldMap.get(opp.Id).AccountId){
                    newaccId.add(opp.AccountId);
                    newaccId.add(oppOldMap.get(opp.Id).AccountId);
                }
            }
            Map<Id, String> newaccMap = new Map<Id, string>();
            
            List<Account> accList =[select id, Name from Account where Id In:newaccId];
            
            for(Account acc :accList){
                newaccMap.put(acc.Id, acc.Name);
            }
            for(Opportunity opp1:oppNewList){
                
                Opportunity oldOpp = oppOldMap.get(opp.Id);
                
                if(opp1.AccountId != oldOpp.AccountId){
                    opp.Description = 'New Name is:==>'+newaccMap.get(opp1.AccountId)+''+'Old Name is:==>'+newaccMap.get(oldOpp.AccountId);
                }
            }
        }
    } 
}