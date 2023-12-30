public class AccountTriggerHandler3 {
    
//Write a trigger such that if a account has atleast one contact then account must be non editable.

    Public static void accountNonEditable(List<Account>accNewList, Map<Id, Account>accNewMap){
       
        Map<Id, Account> ParentTOchild =new Map<Id, Account>([SELECT ID,(SELECT ID FROM Contacts)
                                                             FROM Account WHERE Id IN :accNewMap.keySet()]);
        for(Account acc : accNewList){
            if(ParentTOchild.get(acc.ID).Contacts.size()>0){
                acc.addError('You cannot edit this account');
            }
        }
        
    }
    
    
    //create opp record when acc have no opp
	
    Public static void createOpp(List<Account> accNewList, Map<Id, Account>accOldMap){
        
        List<Account> accToOpp = [SELECT Id,(SELECT Id FROM Opportunities) from Account WHERE Id IN :accNewList];
        
        List<Opportunity> oppToInsert = new List<Opportunity>();
        
        for(Account acc : accToOpp){
            for(Opportunity opp: acc.Opportunities){
                if(acc.Opportunities.size()<1){
				
                    Opportunity opp1 = new Opportunity();
                    opp1.AccountId = acc.id;
                    opp1.Name = acc.Name;
                    opp1.CloseDate = system.today();
                    opp1.CloseDate = Date.newInstance(1960, 2, 17);
	                    oppToInsert.add(opp1);
                }
            }
        }
        if(!oppToInsert.isEmpty()){
            insert oppToInsert;
        }
    }



Public static void checkOpp(List<Account> accList){
    
    
    set<Id> accountIdset = new Set<Id>();
    
    for(Account acc : accList) {
        
        accountIdset.add(acc.id);
        
    }
    
    List<Account> AccoppList = [select id,Name,(select id, Name from Opportunities)from Account where Id IN: accountIdset];
    
    List<Opportunity> oppListToInsert = new List<Opportunity>();
    
    for(Account acc : AccoppList){
        
        if(acc.Opportunities.size()<1){ 
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.id;
            opp.Name = 'Pletra trigger';
            opp.StageName = 'closed won';
            opp.CloseDate = Date.newInstance(2023, 8, 8);
            oppListToInsert.add(opp);
            
        }
    }
    if(!oppListToInsert.isEmpty()){
        
        insert oppListToInsert ;
    }
}
}