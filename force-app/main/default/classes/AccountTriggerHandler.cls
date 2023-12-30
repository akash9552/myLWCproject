public class AccountTriggerHandler {
    
    //Write a trigger that will populate Account Email and phone and phone into all Child Contacts Email fields
    
    public static void updateChildRecord1(List<Account> accNewList) {
        
        
        List<Account>ParentToChildClass =[SELECT Id, Email__c, Phone,
                                          (SELECT Id, Email, Phone FROM Contacts ) FROM Account WHERE Id = :accNewList];
        // here we query the records of account with child records
        // when we use list in where close use Id =: and when we use set in where close use Id IN :setName
        
        List<Contact>contoUpdateList = new List<Contact>();
        
        for(Account acc : ParentToChildClass) {
            if(acc.Email__c != null && acc.Phone != null){
                for(Contact con : acc.Contacts){   // here we have to make nested for loop for contacts of each acc record
                    con.Email = acc.Email__c;      //here we map the fields of parent with child object
                    con.Phone = acc.Phone;
                    contoUpdateList.add(con);
                }
            }
        }
        
        if(!contoUpdateList.isEmpty()){
            update contoUpdateList;
        }
    }
    Public static void updateChildRecord2(List<Account>accNewList) {
        
        List<Contact>conList =[SELECT Id, Email, Phone, Account.Email__c, Account.Phone FROM Contact WHERE
                               AccountId =:accNewList];
        
        List<Contact>conList1 = new List<Contact>();
        
        for(Contact con : conList){
            con.Email = con.Account.Email__c;
            con.phone = con.Account.Phone; 
            conList1.add(con);
        }
        if(!conList1.isEmpty()){
            update conList;
        }
    }
    
    /*Create an isActive checkbox on Account. If this checkbox is true update all the 
    child Opportunities StageName to “Closed Won”
    */
    Public static void updateOpportunitiesStage1(List<Account>accNewList){
        
        List<Account>accRecordwithOpp =[SELECT Id, IsActive__c, (SELECT ID, StageName FROM Opportunities)
                                        FROM Account WHERE Id =:accNewList];
        
        List<Opportunity>oppListToUpdate = new List<Opportunity>();
        
        for(Account acc : accRecordwithOpp){
            if(acc.IsActive__c == true){
                
                for(Opportunity OPP : acc.Opportunities){
                    if(opp.StageName != 'Closed Won'){
                        opp.StageName = 'Closed Won';
                        oppListToUpdate.add(opp);
                    }
                }
            }
        }
        if(!oppListToUpdate.isEmpty()){
            update oppListToUpdate;
        }
    }
    public static void updateOpportunitiesStage2(List<Account> accNewList) {
        
        List<Opportunity> oppList = [SELECT Id, StageName FROM Opportunity WHERE 
                                     AccountId = :accNewList AND Account.isActive__c = true AND StageName != 'Closed Won'];
        
        for(Opportunity opp : oppList) {
            opp.StageName = 'Closed Won';
        }
        if(!oppList.isEmpty()) {
            update oppList;
        }
    }
    
    
    /*Create an Account Email Domain text field on Contact. Write a trigger such that the parent account email
      domain gets added to all the child Contacts “Account Email Domain” field.
      For Ex:- If the parent account has the email “test@velocity.com” then all 
     child contacts “Account Email Domain” field will have “velocity.com” as it’s value.
     */
    Public static void addEmailDomainnOnchild1(List<Account>accNewList){
        
        List<Account>parentToChildQ =[SELECT Id, Email__c, (SELECT Id, Account_Email_Domain__c FROM Contacts)
                                      FROM Account WHERE Id =:accNewList];
        List<Contact>conlist = new List<Contact>();
        
        for(Account acc : parentToChildQ){
            if(acc.Email__c != null){
                for(Contact con : acc.Contacts){
                    if(con.Account_Email_Domain__c !=null){
                     acc.Email__c = con.Account_Email_Domain__c.substringAfter('@'); 
                    conlist.add(con);
                    }
                }
            }
        }
        if(!conlist.isEmpty()){
            update conlist;
        }
    }
    Public static void addEmailDomainnOnchild2(List<Account>accNewList){
        
          List<Contact> conList = [SELECT Id, Account.Email__c, Account_Email_Domain__c 
                                   FROM Contact WHERE AccountId = :accNewList AND Account.Email__c != null];
        
        for(Contact con : conList) {
            con.Account_Email_Domain__c = con.Account.Email__c.substringAfter('@');  
        }
        
        if(!conList.isEmpty()) {
            update conList;
        }
    }
    
    /* write a trigger such that when account is created along with that 
     create one opportunity and contact to that account
     */
    Public static void createOppAndCon(List<Account>accNewList){
        
        List<Contact>conList = new List<Contact>();
       List<Opportunity>oppList = new List<Opportunity>();
        
        for(Account acc: accNewList){
            
            Contact con = new Contact();
            con.AccountId = acc.Id;
            con.LastName = acc.Name;
            conList.add(con);
            
            Opportunity opp = new Opportunity();
            opp.AccountId = acc.Id;
            opp.Name = acc.name;
            opp.CloseDate = system.today();
            opp.StageName = 'Closed Won';
            oppList.add(opp);
        
        }
        if(!conList.isEmpty()){
            insert conList;
           
        }
        if(!oppList.isEmpty()){
             insert oppList;
        }
    }
    
    /*
      write a trigger such that if account has at least one chaild contact then account must be non editable.
     */
    Public static void accNonEditable1(List<Account>accNewList){
        
           set<Id>accIdset = new Set<Id>();
       
         List<Contact>conlist = [SELECT Id, AccountId FROM Contact WHERE AccountId =:accNewList];
        
        for(Contact con : conlist){
            accIdset.add(con.AccountId);
        }
        List<Account> accListHaveAtListOneContact = [SELECT Id, Name FROM Account WHERE Id IN:accIdset];
        
        for(Account acc :accNewList){
            if(accListHaveAtListOneContact.size()>0){
                acc.addError('This account has contact you cannot edit');
            }
        }
        
    }
    Public static void accNonEditable2(List<Account>accNewList){
        
        Set<Id>accountIds = new Set<Id>();
        
        for(Account acc :accNewList){
            accountIds.add(acc.Id);
        }
        Map<Id,Account>parentchildquery = new Map<Id,Account>([SELECT Id, (SELECT Id, AccountId FROM Contacts)
                                                               FROM Account WHERE Id IN :accountIds]);
        for(Account acc1 :accNewList){
            if(parentchildquery.get(acc1.Id).Contacts.size()>0){
                acc1.addError('you cannot edit this record becose this has child contact1');
            }
        }
    }
    Public static void accNonEditable3(List<Account>accNewList, Map<Id,Account>accNewMap){
        
        Map<Id,Account>parentchildQuery = new Map<Id,Account>([SELECT Id,(SELECT Id FROM Contacts)FROM 
                                                               Account WHERE Id IN :accNewMap.KeySet()]);
        for(Account acc : accNewList){
            if(parentchildQuery.get(acc.Id).Contacts.size()>0){
               acc.addError('you cannot edit this record becose this has child contact2'); 
            }
        }
    }
    
    /*
     Write a trigger such that if an Account has any Child Opportunity having
     StageName as ‘Closed Won’ then prevent deletion of that Account. 
     */
    Public static void preventDeletionAcc(List<Account>accoldList) {
        
        Map<Id,Account>parentchildquery = new Map<Id,Account>([SELECT Id,(SELECT Id, StageName FROM Opportunities 
                                                                          WHERE StageName = 'Closed Won' LIMIT 1)
                                                              FROM Account WHERE Id =:accoldList]);
        for(Account acc : accoldList){
            if(parentchildquery.get(acc.Id).Opportunities.size()>0){
                acc.addError('This account has Closed Won Opportunities');
            }
            //if(!parentchildquery.get(acc.Id).Opportunities.isEmpty()){}
        }
    }
    /*
     Write a trigger on Account , when an account insert , automatically account
     billing address should populate into the account shipping address.
     */
    Public static void papulateBillingAdress(List<Account>accNewList) {
        
        for(Account acc : accNewList) {
            acc.ShippingCity = acc.BillingCity;
            acc.ShippingCountry = acc.BillingCountry;
            acc.ShippingGeocodeAccuracy = acc.BillingGeocodeAccuracy;
            acc.ShippingLatitude = acc.BillingLatitude;
            acc.ShippingLongitude = acc.BillingLongitude;
            acc.ShippingPostalCode = acc.BillingPostalCode;
            acc.ShippingState = acc.BillingState;
            acc.ShippingStreet = acc.BillingStreet;
        }
    }
    
    /*
     Write a trigger on Account when Account is update check all opportunity
    inside the account. Update all Opportunities Stage to close lost if an
    opportunity created date is greater than 30 days from today and stage not
    equal to close won.
     */
    Public static void updateoppStageName(List<Account>accNewList) {
        
        List<Opportunity>childOppList = [SELECT Id, StageName FROM Opportunity WHERE 
                                    StageName != 'Closed Won' AND AccountID =:accNewList AND CloseDate > NEXT_N_Days:30];
        for(Opportunity opp : childOppList){
           opp.StageName = 'Close Lost';
        }
        if(!childOppList.isEmpty()){
            update childOppList;
        }
    }
    
    /*Create a field on Account Named (Client Contact lookup to Contact)
      Once an account insert a contact will create with the name of account and that
      contact will be the client contact on Account
     */
    Public static void createChildContact(List<Account>accNewList) {
        
        Map<Id,Contact> conMap = new Map<Id,Contact>();
        
        List<Account> acclistUpdate = new List<Account>();
        
        for(Account acc : accNewList) {
            if(acc.Client_Contact__c != null){
                Contact con = new Contact();
                con.LastName = acc.Client_Contact__c;
                conMap.put(acc.Id,con);
            }
        }
        for(Account acc : accNewList){
            acc.Client_Contact__c = conMap.get(acc.Id).Id;
            acclistUpdate.add(acc);
        }
        
        if(!acclistUpdate.isEmpty()){
            update acclistUpdate;
        }
    }
    /*Once an account will update then that Account will update 
      with the total amount from All Opportunities on Account level.
      Account field name would be Total Opportunity Amount.
     */
    Public static void rollupSumofAmountonAccount(List<Account>accNewList) {
        
 
        List<AggregateResult> oppRollUp = [SELECT AccountId, sum(amount) ammountSum FROM Opportunity 
                                           WHERE AccountId = :accNewList GROUP BY AccountId];
        List<Account>accUpdateList = new List<Account>();
        
        for(AggregateResult aggr : oppRollUp) {
            Account acc =new Account();
              acc.Id = (Id)aggr.get('AccountId');
            acc.Total_Opportunity_Amount__c = (Decimal)aggr.get('ammountSum');
			accUpdateList.add(acc);
        } 
        if(!accUpdateList.isEmpty()) {
            update accUpdateList;
        }
    }
    
    /*I want to display count of deleted contacts on account which are related
     */
    Public static void deletedContactCountOnAccount(List<Account>accOldList) {
        
        List<Contact>deletedconList = [SELECT Id, AccountId FROM Contact WHERE 
                                       AccountId =:accOldList AND isDeleted = true ALL ROWS];
        
        List<Account>accUpdate = new List<Account>();
        
        for(Account acc : accOldList) {
            Contact con = new Contact();
            acc.Id = con.AccountId;
            acc.Deleted_Contacts__c = deletedconList.size();
            accUpdate.add(acc);
        }
        update accUpdate;
    }
    /*
     Write a trigger such that if an Account has any Child Contact having
     level as ‘primary’ then prevent deletion of that Account. 
     */
    Public static void preventAccDeletion(List<Account>accOldList){
        Map<Id,Account>accMap = new Map<Id,Account>([SELECT Id, (SELECT Id, Level__c FROM Contacts WHERE 
                                                                 Level__c ='Primary' LIMIT 1)
                                                     FROM Account WHERE Id =:accOldList]);
        for(Account acc :accOldList) {
            if(accMap.get(acc.Id).Contacts.Size()>0){
               acc.addError('you are not able to delete this account this account has primary contact');
            }
        }
    }
    /*
    write a trigger such that when new contact is ctreated realated to any Account
      then Lastname of that contact must be account name.
    */
    /*
      write a trigger such that when contact is udate
      then Lastname of that contact must be its parent account name.
     */
    Public static void updateChidName(List<Account>accNewList) {
        
        List<Account>parentToChild = [SELECT Id, Name, (SELECT Id, LastName FROM Contacts) 
                                      FROM Account WHERE Id =:accNewList];
        List<Contact>updatecontact = new List<Contact>();
        
        for(Account acc : parentToChild) {
            if(acc.Name !=null) {
                for(Contact con : acc.Contacts){
                    if(con.AccountId !=null) {
                    con.LastName = acc.Name ;
                    updatecontact.add(con);
                    }
                }
            }
        }
        if(!updatecontact.isEmpty()){
            update updatecontact;
        }
    }
    
    //trigger to update contact LastName whenever account name is updated
   
    public static void accountMethod(List<Account>aclist,map<id,account> oldmap){
        set<id> accountId=new set<id>();
        for(Account ac:aclist){
            account accountOld=oldmap.get(ac.id);
            if(ac.Name!=accountOld.Name){
                accountId.add(ac.Id);
            }
        }
        if(accountId.size()>0){
            map<id,account> accountmap=new map<id,account>([select id,Name,(select id,LastName from contacts) 
                                                            from account where id in:accountId]);
            List<contact> clist=new List<contact>();
            for(account ac:aclist){
                account accountOld=oldmap.get(ac.id);
                if(ac.Name!=accountOld.Name){
                    if(accountmap.containskey(ac.id)){
                        account ac1=accountmap.get(ac.id);
                        List<contact>lstCont = ac1.contacts;
                        for(contact c:lstCont){
                            c.LastName=ac.Name;
                            clist.add(c);
                        }
                    }
                }
            }
            if(!clist.isEmpty()){
                update clist;
            }
            
        }
    }
    Public static void preventDeletion(List<Account>accOldList){
        profile systemAdminProfile = [SELECT Id FROM Profile WHERE Name ='System Administrator' LIMIT 1];
        
        if(UserInfo.getProfileId() != systemAdminProfile.Id){
            for(Account acc : accOldList){
                acc.addError('Only System Admins can delete account Record');
            }
        }
    }
    /*
     Whenever new account is created with annual revenue more than 50,000
then add Smriti Sharan as contact name
*/
    public static void createConAnnualRevenue(List<Account>accNewList){
        List<Contact>conList= new List<Contact>();
        for(Account acc : accNewList){
            if(acc.AnnualRevenue != null && acc.AnnualRevenue >50000){
                Contact con = new Contact();
                con.Id = acc.Id;
                con.LastName ='Smiriti';
                con.FirstName ='Sharan';
                conList.add(con);
            }
        }
        insert conList;
    }
    // write a trigger such that when account email get updated papulate taht updated email on all related contact
    Public static void updateContactWithEmail(List<Account> accNewList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> updatedMap = new Map<Id, Account>();
        system.debug('updatedMap');
        for(Account acc : accNewList){
            if(accOldMap != NULL){
                if(acc.Email__c != null && acc.Email__c !=accOldMap.get(acc.Id).Email__c){
                  updatedMap.put(acc.Id, acc);  
                }
            }
        }
        List<Contact> conListToUpdate =new List<Contact>();
        
        system.debug('conListToUpdate');
        
        List<Contact> conList = [select AccountId, Email from Contact where AccountId IN :updatedMap.keySet()];
        system.debug('conList');
        for(Contact con : conList){
            //con.AccountId = updatedMap.get(con.AccountId).Id;
            con.Email = updatedMap.get(con.AccountId).Email__c;
            conListToUpdate.add(con);
        }
        if(!conListToUpdate.isEmpty()){
            update conListToUpdate;
        }
    }
}