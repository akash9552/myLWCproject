public class ContactTriggerHandler {
   
    
    /*write a trigger such that when new contact is created which is related to any 
    account then the last name of contact record must be a Account Name.
	*/
    Public static void conLastName(List<Contact> conNewList){
        
        set<Id> accountIdset = new set<Id>();
        
        for(Contact con :conNewList){
            if(con.AccountId != null){
               accountIdset.add(con.AccountId);
            } 
        }
        List<Contact> conList = new List<Contact>();
        
        system.debug(conList);
        
        List<Account> accList=[select Id, Name, (select AccountId, LastName from Contacts)
                               from Account where Id IN :accountIdset];
        
        for(Account acc : accList){
            for(Contact con:acc.Contacts){
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            conList.add(con);
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    
    Public static void conLastName1(List<Contact> conNewList){
        
      set<Id> accountIdset = new set<Id>();
        
         for(Contact con :conNewList){
            if(con.AccountId != null){
               accountIdset.add(con.AccountId);
            } 
    }
        List<Account> accList =[select Id, Name from Account where Id IN:accountIdset];
        
        Map<Id, Account> accMap = new Map<Id, Account>();
        
        for(Account acc:accList){
            accMap.Put(acc.id, acc);
        }
           
        for(Contact con :conNewList){
            
            con.LastName=accMap.get(con.AccountId).Name;
           
        }
        
}
    
    Public static void conLastName2(List<Contact> conNewList){
        List<Contact> conList =[select Account.Name, LastName from contact where Id IN:conNewList];
        
        List<Contact> conUpdate = new List<Contact>();
        for(Contact con:conList){
            Contact con2 = new Contact();
            con2.LastName = con.LastName+''+con.Account.Name;
            conUpdate.add(con2);
        }
        if(!conUpdate.isEmpty()){
            update conUpdate;
        }
    }
    
    Public static void conLastName3(List<Contact> conNewList){
        Set<Id> accountIdset = new Set<Id>();
        
        for(Contact con:conNewList){
            if(con.AccountId != null){
               accountIdset.add(con.AccountId); 
            }
        }
        List<Contact> conList = [select Id, LastName, Account.Name from Contact where AccountId in:accountIdset];
        
        List<Contact> conUpdate = new List<Contact>();
        
        for(Contact con:conList){
            Contact con2=new Contact();
            con2.LastName = con.LastName+''+con.Account.Name;
            conUpdate.add(con2);
        }
        if(!conUpdate.isEmpty()){
            update conUpdate;
        }
    }
    
    // Create a new Trigger on Contact that will check for duplicates before allowing a new record into the database.
    Public static void avoidDuplicateContact(List<Contact> conNewList){
        
        set<string> conName = new set<String>();
        
        for(Contact con :conNewList){
            if(con.FirstName != null){
                conName.add(con.FirstName);
            }
        }
        List<Contact> conList = [select Id, FirstName from Contact where FirstName IN:conName];
        
        for(Contact con:conNewList){
            if(conList.size()>0){
                con.addError('Duplicate FirstName found');
            }
        }
    }
 
    // write a trigger such that only system admin are able to delete contact record
    Public static void preventConDeletion(List<Contact> conOldList){
        
       // Id currentUserId = userInfo.getProfileId();
            
       Profile currentProfileName = [select Name from Profile where Id =:userInfo.getProfileId()];
        
       // user currentUserName = [select Id, Profile.Name from user Where Id=:userInfo.getUserId()];
        
        for(Contact con:conOldList){
            if(currentProfileName.Name !='System Administrator'){
                con.addError('you are not able to delete this record');
            }
        }
    }
}