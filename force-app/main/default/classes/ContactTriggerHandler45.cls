public class ContactTriggerHandler45 {
    
    // Make rollup summary of contact on account object.Here we use 4 methods 
    
    public static void afterInsertContactCount(List<Contact> conNewList) {
        
        Set<Id> accountIds = new Set<Id>();
        
        for(Contact con : conNewList) {
            
            if(con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        } 
        contactCount(accountIds);
    }
    
    public static void afterUpdateContactCount(List<Contact> conNewList, Map<Id, Contact> conOldMap) {
        Set<Id> accountIds = new Set<Id>();
        
        for(Contact con : conNewList) {
            
            if(con.AccountId != null && con.AccountId != conOldMap.get(con.Id).AccountId) {
                accountIds.add(con.AccountId);
                accountIds.add(conOldMap.get(con.Id).AccountId);
            }
        }
        contactCount(accountIds);
    }
    
    public static void afterDeleteContactCount(List<Contact> conOldList) {
        
        Set<Id> accountIds = new Set<Id>();
        
        for(Contact con : conOldList) {
            
            if(con.AccountId != null) {
                accountIds.add(con.AccountId);
            }
        }
        contactCount(accountIds);
    }
    
    public static void contactCount(Set<Id> accountIds) {
        
        List<Account> accConList = [SELECT Id, Contact_Count__c, (SELECT Id FROM Contacts)
                                    FROM Account WHERE Id IN : accountIds];
        List<Account> accToUpdate = new List<Account>();
        
        for(Account acc : accConList) {
            acc.Contact_Count__c = acc.Contacts.size();
            accToUpdate.add(acc);
        }
        
        if(!accToUpdate.isEmpty()) {
            update accToUpdate;
        }
    }
    /*
Write a trigger such that when contact is inserted or update with email and phone 
then papulate it's email and phone in tis associated account 
*/
    Public static void updateParentAccountWithEmailandPhone(List<Contact>conNewList){
        
        List<Account>acclistUpdate = new List<Account>();
        
        for(Contact con : conNewList) {
            
            if(con.Email != null && con.Phone != null){
                Account acc = new Account();
                acc.Id = con.AccountId;
                acc.Email__c = con.Email;
                acc.Phone = con.Phone;
                acclistUpdate.add(acc);
            }
        }
        if(!acclistUpdate.isEmpty()){
            update acclistUpdate;
        }
    }
    
    // Make rollup summary of contact on account object.Here we use 4 methods 
    Public static void afterInsertContactCount1(List<Contact>conNewList) {
        
        Set<Id>accountIdset =new Set<Id>();
        
        for(Contact con : conNewList) {
            if(con.AccountId != null) {
                accountIdset.add(con.AccountId);
            }
        }
        List<Account> parentToChildQuery  = [SELECT ID, Contact_Count__c, (SELECT ID, AccountId FROM Contacts)
                                             FROM Account WHERE Id IN : accountIdset];
        List<Account> accToUpdate = new List<Account>();
        
        for(Account acc : parentToChildQuery) {
            acc.Contact_Count__c = acc.Contacts.size();
            accToUpdate.add(acc);
        }
        if(!accToUpdate.isEmpty()){
            update accToUpdate;
        }
    }
    Public static void afterUpdateContactCount1(List<Contact>conNeList, Map<Id, Contact>conOldMap) {
        
        Set<Id> accountIds = new Set<Id>();
        
        for(Contact con : conNeList) {
            if(con.AccountId != null && con.AccountId != conOldMap.get(con.Id).AccountId) {
                accountIds.add(con.AccountId);
                accountIds.add(conOldMap.get(con.Id).AccountId);
            }
        }
        List<Account>parentToChildQ = [SELECT ID, Contact_Count__c, (SELECT ID, AccountId FROM Contacts)
                                       FROM Account WHERE Id IN :accountIds];
        List<Account>acctoUpdate =new List<Account>();
        for(Account acc : parentToChildQ){
            acc.Contact_Count__c = acc.Contacts.size();
            acctoUpdate.add(acc);
        }
        if(!acctoUpdate.isEmpty()){
            update acctoUpdate;
        }
    }
    Public static void afterDeleteContactCount1(List<Contact>conOldList) {
        Set<Id>accountIds = new Set<Id>(); 
        
        for(Contact con : conOldList) {
            if(con.AccountId != null){
                accountIds.add(con.AccountId);
            }
        }
        List<Account>ptocQ = [SELECT Id, Contact_Count__c,(SELECT Id, AccountId FROM Contacts) 
                              FROM Account WHERE Id IN : accountIds ];
        List<Account>acctoUpdate =  new List<Account>();
        
        for(Account acc: ptocQ) {
            acc.Contact_Count__c = acc.Contacts.size();
            acctoUpdate.add(acc);
        }
        if(!acctoUpdate.isEmpty()){
            update acctoUpdate;
        }
    }
    
    /*I want to display count of deleted contacts on account which are related
*/
    Public static void deletedContactCountOnAccount(List<Contact>conOldList) {
        
        set<Id>accIdSet = new set<Id>();
         
        for(Contact con : conOldList) {
            if(con.AccountId != null) {
               accIdSet.add(con.AccountId); 
            }
        }
        Integer count = [SELECT count() FROM Contact WHERE AccountId!=null AND isDeleted = true ALL ROWS];
        
           List<Account>accList = [SELECT Id, Name, Deleted_Contacts__c FROM Account WHERE Id IN :accIdSet];
        List<Account> Accounts= new List<Account>();
        for(Account acc : accList) {
            acc.Deleted_Contacts__c = count;
            Accounts.add(acc);
        }
        update Accounts;
       }  
    /*
    write a trigger such that when new contact is ctreated realated to any Account
      then Lastname of that contact must be account name.
    */
    Public static void updateChild(List<Contact>newConList) {
        
       List<Contact>conList = [SELECT Id, LastName, Account.Name FROM Contact WHERE Id=:newConList];
        
        for(Contact con : conList) {
            if(con.AccountId !=null) {
                
             Account acc = new Account();
                acc.Id = con.AccountId;
                con.LastName = acc.Name;
            
                    
            }
        }
    }
    
    Public static void updateContactLastName(List<Contact>conNewList){
        
        List<Contact>conList = [SELECT Id, LastName, Account.Name FROM Contact WHERE AccountId !=null AND Id =:conNewList];
        
        List<Contact>conListUpdate = new List<Contact>();
        
        for(Contact con : conList){
            con.LastName = con.Account.Name;
            conListUpdate.add(con);
            update conList;
        }
        if(!conListUpdate.isEmpty()){
            update conListUpdate;
       }
    }
    /*write a trigger such that when contact is udate
      then Lastname of that contact must be its parent account name.
    */
    Public static void updateChildConWithParentAccName (List<Contact>conNewList, Map<Id,Contact>conOldMap) {
        
        List<Contact>conlist = [SELECT ID, LastName, Account.Name FROM Contact WHERE AccountId !=null AND Id =:conNewList];
        
        List<Contact>conList1 = new List<Contact>();
        for(Contact con : conlist) {
            if(con.LastName !=conOldMap.get(con.Id).LastName){
               Account acc = new Account();
                acc.Id = con.AccountId;
                con.LastName = acc.Name;
                conList1.add(con);
            }
        }
        if(!conList1.isEmpty()){
            update conList1;
        }
    }
    Public static void updateChildConWithParentAccName2 (List<Contact>conNewList) {
        
        Set<Id>accountidset = new Set<Id>();
        
        for(Contact con :conNewList) {
            if(con.AccountId !=null){
            accountidset.add(con.AccountId);
            }
        }
        List<Account>parentchildQuery = [SELECT Id, Name,(SELECT Id, LastName FROM Contacts) 
                                         FROM Account WHERE ID IN :accountidset];
        
        List<Contact>contactList = new List<Contact>();
        
        for(Account acc : parentchildQuery){
            for(Contact con : acc.Contacts){
                con.AccountId = acc.Id;
                con.LastName = acc.Name;
                contactList.add(con);
            }
        }
        if(!contactList.isEmpty()){
            update contactList;
        }
    }
    
    //write tigger such that i want number of contact realated to particular Account in custom field on account
    
    Public static void countOfcontact1(List<Contact>conoldList){
         Set<ID>accidset = new Set<ID>();
        
        for(Contact con:conoldList){
            if(con.AccountId !=null){
                 accidset.add(con.AccountId);
            }
        }
        List<Account>accparenttochild = [select id, name,(select id, name from contacts)from account where Id IN:accidset];
        
        List<Account>accupdate =new List<Account>();
        
        for(Account acc : accparenttochild){
            acc.Contact_Count__c = acc.Contacts.size();
            accupdate.add(acc);
        }
        if(!accupdate.isEmpty()){
            update accupdate;
        }
    }
    Public static void countOfContactOnAcc(List<Contact>conoldList, Map<Id, Contact>conOldmap){
        
        Set<Id>accIdset = new Set<Id>();
        
        for(Contact con :conoldList){
            if(con.AccountId != null){
                accIdset.add(con.AccountId);
            }
        }
        integer Count =[select Count() FROM Contact WHERE AccountId!=null];
        
       // integer Count = [SELECT ID, (SELECT ID, FROM Contacts) FROM Account WHERE ID IN :accIdset];
        
        List<Account>acclist = [select id, Contact_Count__c from Account where Id IN :accIdset];
        
        List<Account>accUpdate =new List<Account>();
        
        for(Account acc :acclist){
            acc.Contact_Count__c = Count;
            accUpdate.add(acc);
        }
        if(!accUpdate.isEmpty()){
            update accUpdate;
        }
    }
    
     
    /*Write trigger such that when Account changes which is associtaed to Contact then the 
chaged name and new name must be reflect
in description field on Contact
*/
    Public static void showAccountNameOnContact(List<Contact>conNewList, Map<Id, Contact>oldMap){
        
        List<Contact>conList = [SELECT Id, Account.Id, Account.Name FROM Contact WHERE  AccountId != null AND Id =:conNewList];
        
         List<Contact>conListtoUpdate = new List<Contact>();
        
        for(Contact con : conList){
            if(con.AccountId != oldMap.get(con.Id).AccountId) {
                
               con.Description = 'Account of this Contact is changed | old Account Name ='+oldMap.get(con.Id).AccountId
                   +'New Name = '+con.Name;
                
                conListtoUpdate.add(con);
            }
        }
        if(!conListtoUpdate.isEmpty()){
            update conListtoUpdate;
        }
    }
      
}