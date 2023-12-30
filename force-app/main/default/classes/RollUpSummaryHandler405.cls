public class RollUpSummaryHandler405 {
    
    public static void afterInsertContactCount(List<Contact>conNewList){
        
        Set<Id> accountIds = new set<Id>();
        
        for(Contact con : conNewList){
            if(con.AccountId != Null){
                accountIds.add(con.AccountId);
            }
        }
        List<Account>accConList =[SELECT Id,Contact_Count__c,(SELECT Id FROM Contacts) FROM Account WHERE Id =:AccountIds];
        
        List<Account>accToUpdate = new List<Account>();
        
        for(Account acc : accConList){
            acc.Contact_Count__c = acc.Contacts.size();
            accToUpdate.add(acc);
        }
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
    
    public static void afterUpdateContactCount(List<Contact> conNewList, Map<Id, Contact> conOldMap){
        
        Set<Id>accountIds = new Set<Id>();
        
        for(Contact con: conNewList){
            if(con.AccountId != null && con.AccountId != conOldMap.get(con.Id).AccountId){
                accountIds.add(con.AccountId);
            }
            
            List<Account>accConList =[SELECT Id,Contact_Count__c,(SELECT Id FROM Contacts) FROM Account WHERE Id =:accountIds];
            
            List<Account>acctoupdate = new List<Account>();
            
            for(Account acc:accConList){
                acc.Contact_Count__c = acc.Contacts.size();
                //here we map Contact_Count__c field on account object with contact size
                acctoupdate.add(acc);
            }
            if(!acctoupdate.isEmpty()){
                update acctoupdate;
            }
        }
    }
    
    public static void afterDeleteContactCount(List<Contact>conOldList){
        
        Set<Id>accountIds = new Set<Id>();
        
        for(Contact con:conOldList){
            if(con.AccountId !=Null){
                accountIds.add(con.AccountId); 
            }
        }
        
        List<Account>acclist = [SELECT Id, Contact_Count__c, (SELECT Id, Name FROM Contacts)
                                FROM Account WHERE Id IN :accountIds];
        
        List<Account>acctoupdate = new List<Account>();
        
        for(Account acc:acclist){
            acc.Contact_Count__c = acc.Contacts.size();
            acctoupdate.add(acc);
        }
        if(!acctoupdate.isEmpty()){
            Update acctoupdate;
        }
    }
}