public class AccountTriggers {

    //write a trigger on account to prevent AccountDeletion if it contains Closed won opp
    //=> this tigger run in before delete event and we pass Trigger.new and Trigger.oldMap from trigger
    Public static void prvrntAccDeletion(List<Account> accOldList, Map<Id, Account> accOldMap){
        
        Map<Id,Account>accMap =new Map<Id, Account>([select Id,(select Id, StageName from Opportunities where StageName ='Closed Won' Limit 1) 
                                  from Account where ID In:accOldMap.keySet()]);
        
        for(Account acc:accOldList){
            if(accMap.get(acc.Id).Opportunities.size()>0){
                acc.addError('nono closed won opp here');
            }
        }
    }
    
    // if account has more tahn two con prvent it from deletion
    Public static void accPrventDeletion(List<Account> accOldList, Map<Id, Account> accOldMap){
        Map<Id, Account> accMap = new Map<Id, Account>([select id,(select id from Contacts) 
                                                         from Account where Id iN:accOldMap.keySet()]);
        
        for(Account acc:accOldList){
            if(accMap.get(acc.id).Contacts.size()>=2){
               acc.addError('no no 2 or morethan two con');
            }
        }
    }
    
    /*Write a trigger on Account , when an account insert , automatically account
	billing address should populate into the account shipping address.*/
    //=> this trigger run in before insert event and we pass trigger.new context from trigger as this is befor we do not need update
    
    Public static void papulateBillingAdressInShippingAddress(List<Account> accNewList){
        
        for(Account acc:accNewList){
            acc.BillingCity =acc.ShippingCity;
            acc.BillingCountry =acc.ShippingCountry;
            acc.BillingState =acc.ShippingState;
            acc.BillingStreet =acc.ShippingStreet;
            acc.BillingLatitude =acc.ShippingLatitude;
            acc.BillingLongitude =acc.ShippingLongitude;
        }
    }
 
    /*Write a trigger on Account when Account is update check all opportunity inside the account.
	 Update all Opportunities Stage to close lost if an opportunity created date is greater
	 than 30 days from today and stage not equal to close won.
     */
    //=> as we make changes on another object we have to use After Trigger and we want to fire Trigger if Account Update
    //  so trigger is on Account and use after update event
    Public static void upadteRelatedOppStage(List<Account> accNewList){
        
        Map<Id, Account> updatedAccountsMap = new Map<Id, Account>();
        
        for(Account acc :accNewList){
            updatedAccountsMap.put(acc.Id, acc);
        }
        List<Opportunity> oppListRelatedToUpdatedAcc = [select AccountId, StageName from Opportunity where 
                                                     StageName != 'Closed Won' AND AccountId IN:updatedAccountsMap.keySet()];
        List<Opportunity> oppUpdate = new List<Opportunity>();
        
        for(Opportunity opp :oppListRelatedToUpdatedAcc){
            if(opp.CreatedDate < system.now()-30){   // here we check that created date is it older than 30 days
                opp.StageName = 'Closed Lost';
                oppUpdate.add(opp);
            }
        }
        if(!oppUpdate.isEmpty()){
            update oppUpdate;
        }
    }
    
    /*Once an account an email should go to the admin user with specified text below.
 	An account has been created and name is "Account Name".
     */
    //=> this trigger should run on afetr insert event and we pass trigger.new 
    /*
     therr thing are need to do thi 
	1) create instance
	2) set three methods setToAddresses(),  setSubject(), setPlainTextBody()
	3) get email and store in list 
	create list of that instance and add instance variable in that and finally use Messaging.sendEmail.
    */
    Public static void sendEmailAccUser(List<Account> accNewList){
        
        List<Messaging.SingleEmailMessage> listMail = new List<Messaging.SingleEmailMessage>();
        
        List<String> emailaddress = new List<String>();
        
        User userObj=[select Id,Profile.Name,Email from user where Profile.Name='System Administrator' Limit 1];

        for(Account acc : accNewList){
            if( userObj.Email != null){
                emailaddress.add(userObj.Email);
                Messaging.SingleEmailMessage msg = new Messaging.SingleEmailMessage();
                // create instance of Messaging.SingleEmailMessage
                msg.setToAddresses(emailaddress);
                
                msg.setSubject('Account Created');
                
                String body = 'An account has been created and name is  '+acc.Name;
                msg.setPlainTextBody(body); 
                listMail.add(msg);
            }
        }
        if(!listMail.isEmpty()){
            Messaging.sendEmail(listMail);
        }
    }
    
    /*Once an account will update then that Account will update with the total amount from All Opportunities on Account level.
	Account field name would be Total Opportunity Amount.
     */ 
    Public static boolean ExecuteTrigger = true;
      Public static void appulateTotalOppAmountOnAcc(List<Account> accNewList){
        Map<Id, Account> updatedAccMap =new Map<Id, Account>();
        
        for(Account acc :accNewList){
            updatedAccMap.put(acc.Id, acc);
        }
      //  List<Opportunity> oppList =[select AccountId, Amount from Opportunity where AccountId IN:updatedAccMap.keySet()];
        
        List<AggregateResult> Oppaggr =[select AccountId, sum(Amount) totalAmount from Opportunity 
                                     where AccountId IN :updatedAccMap.keySet() group by AccountId];
        List<Account> accListUpdate = new List<Account>();
        for(AggregateResult aggr :Oppaggr){
            Account acc = new Account();
            acc.Id = (Id)aggr.get('AccountId');
            acc.Total_Opportunity_Amount__c = (decimal)aggr.get('totalAmount');
            accListUpdate.add(acc);
        }
        if(!accListUpdate.isEmpty()){
            update accListUpdate;
        }
    }
    
    /*Write a trigger on Account when an account is update when account type
	change send email to all contacts that your account information has been change.
    Subject: Account Update Info
    Body : Your account information has been updated successfully. Account
    Name : XYZ.
     */
    //=> here we have to use after update event and use Trigger.new context v. and use messaging.singleemailmessage
    
    public static void sendEmailToallCntact(List<Account> accNewList, Map<Id, Account>accoldMap){
        
        Map<Id, Account> updatedAcc = new Map<Id, Account>();
        for(Account acc: accNewList){
            if(acc.Type != accoldMap.get(acc.Id).Type){
                updatedAcc.put(acc.Id, acc);
            }
        }
        List<Contact> conList = [select AccountId, Email, Account.Name from Contact where AccountId IN :updatedAcc.keySet()];
        
        List< Messaging.SingleEmailMessage> mailList = new List<Messaging.SingleEmailMessage>();
        
        List<string> contactEmails =new List<string>();
        
        for(Contact con :conList){
            if(con.Email != null){
               contactEmails.add(con.Email); 
            }
            Messaging.SingleEmailMessage msg =new  Messaging.SingleEmailMessage();
            msg.setToAddresses(contactEmails);
            msg.setSubject('Account type changed');
            
            string body ='Your account information has been updated successfully : Account Name is  '+con.Account.Name;
            msg.setPlainTextBody(body);
            
            mailList.add(msg);
        }
        if(!mailList.isEmpty()){
             Messaging.sendEmail(mailList);
        }
    }
    
    //When an account BillingCity is update , update all contacts MailingCity with account BillingCity
    //
    Public static void updateContactBillingcity(List<Account> accnewList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> updatedaccMap = new Map<Id, Account>();
        for(Account acc : accnewList){
            if(acc.BillingCity !=accOldMap.get(acc.Id).BillingCity){
                updatedaccMap.put(acc.Id, acc);
            }
        }
        List<Contact> relatedCon =[select AccountId, MailingCity from Contact where AccountId IN:updatedaccMap.keySet()];
        
        List<Contact> conToUpdate =new List<Contact>();
        
        for(Contact con: relatedCon){
            con.MailingCity = updatedaccMap.get(con.AccountId).BillingCity;
            conToUpdate.add(con);
        }
        if(!conToUpdate.isEmpty()){
            update conToUpdate;
        }
    }
    
    // create number of contact to Account wich number we enter in Number of location field in Account
    //=> this trigger must run in after insert event
   
    Public static void createContactToAcc(List<Account> accNewList){
        
        integer i;
        Id accId;
        string accName;
        
        List<Contact> conInsertList = new List<Contact>();
        
        for(Account acc : accNewList){
            if(acc.NumberofLocations__c != null && acc.NumberofLocations__c >=0){
                i = (integer)acc.NumberofLocations__c;
                accName = acc.name;
                accId = acc.Id; 
            }
        }
        for(integer j=1; j<=i; j++){
            Contact con = new Contact();
            con.AccountId =accId;
            con.lastName = accName+j;
            conInsertList.add(con);
        }
        if(!conInsertList.isEmpty()){
            insert conInsertList;
        }
    }
    
    // write a trigger such that when Account phone change upadte all contact with same phone.
    
    public static void updateChildWhenAccUpdate(List<Account> accNwList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> updatedAccount = new Map<Id, Account>();
        
        for(Account acc : accNwList){
            if(acc.phone != null && acc.Phone != accOldMap.get(acc.Id).Phone){
                updatedAccount.put(acc.Id, acc);
            }
        }
        List<Contact> conList = [select Id, Phone from Contact where AccountId IN:updatedAccount.keySet()];
        
        List<Contact> conUpdateList = new List<Contact>();
        
        for(Contact con:conList){
            con.AccountId = updatedAccount.get(con.AccountId).Id;
            con.Phone = updatedAccount.get(con.AccountId).Phone;
            conUpdateList.add(con);
        }
        if(!conUpdateList.isEmpty()){
            update conUpdateList;
        }
    }
    
    // write a trigger to prevent deletion of Associated Contact deleteion on dleteion of Account record
     
    Public static void preventConDetionAccdeletion(List<Account> accOldList){

	set<Id> accountidset = new set<Id>();
        system.debug(accountidset);
        for(Account acc:accOldList){
            accountidset.add(acc.Id);
        }
        List<Contact> conList = [select Id, AccountId from Contact where AccountId IN:accountidset];
        system.debug(conList);
        List<Contact> conListupdate = new List<Contact>();
          system.debug(conListupdate);
        for(Contact con:conList){
            if(!accountidset.contains(con.AccountId)){
                conListupdate.add(con);
            }
        }
        if(!conListupdate.isEmpty()){
            update conListupdate;
        }
    }
    public static void preventDeletionContact (List<Account>accOldList){
        
        Set<Id> accIdSet =new Set<Id>();
        
        for(Account acc :accOldList){
            accIdSet.add(acc.Id);
        }
        List<Contact> conList = [SELECT ID, AccountId FROM Contact WHERE AccountId IN :accIdSet];
        if(!conList.isEmpty()){
            for(Contact con :conList){
                con.addError('This Contatc is associate with account');
            }
        }
    }

    public static void handleAccountDelete(List<Account> accounts) {
        Set<Id> accountIds = new Set<Id>();

        // Collect the IDs of the Account records being deleted
        for (Account acc : accounts) {
            accountIds.add(acc.Id);
        }

        // Query for related Contacts
        List<Contact> relatedContacts = [SELECT Id, AccountId FROM Contact WHERE AccountId IN :accountIds];

        // Create a map to hold the Contacts and their corresponding Accounts
        Map<Id, List<Contact>> accountToContactsMap = new Map<Id, List<Contact>>();

        // Populate the map with Contacts associated with each Account
        for (Contact con : relatedContacts) {
            if (accountToContactsMap.containsKey(con.AccountId)) {
                accountToContactsMap.get(con.AccountId).add(con);
            } else {
                accountToContactsMap.put(con.AccountId, new List<Contact>{con});
            }
        }

        // Check if there are Contacts related to the Account being deleted
        for (Account acc : accounts) {
            if (accountToContactsMap.containsKey(acc.Id)) {
                // Prevent deletion by adding an error to each Contact
                List<Contact> relatedContacts1 = accountToContactsMap.get(acc.Id);
                for (Contact con : relatedContacts1) {
                    con.addError('You cannot delete this Account because it has associated Contacts.');
                }
            }
        }
    }
    
    
    //update contact phone number as account phone udates 
    
    Public static void updatechild(List<Account> accNewList, Map<Id,Account>accOldmap){
        
        Map<Id, Account> updatedAccount = new Map<Id, Account>();
     
        for(Account acc: accNewList){
            if(acc.Phone != null && acc.Phone != accOldmap.get(acc.id).Phone){
                updatedAccount.put(acc.id, acc);
            }
        }
        List<Contact> conList = [select Id, Phone from Contact where AccountId IN:updatedAccount.keySet()];
        List<Contact> conUpdate = new List<Contact>();
        for(Contact con : conList){
            con.Phone = updatedAccount.get(con.AccountId).Phone;
            con.AccountId =updatedAccount.get(con.AccountId).Id;
            conUpdate.add(con);
        }
        if(!conUpdate.isEmpty()){
            update conUpdate;
        }
    }
    
    /*
You have a custom field on the Account object called conNames, which is of the text data type. 
Whenever you insert a new Account record with a value in the conNames field such as " Rohit ", "Virat", or "Rinku", 
you want to automatically create a related contact for that Account. The number of contacts created should match the 
number of conNames values entered, and each contact's last name should match the corresponding conNames value
(e.g. Rohit contact's last name should be " Rohit ",  Virat contact's last name should be "Virat", and so on). 
     */
    Public static void createContactWithSplitFunction(List<Account> accNewList){
        
        
         Map<Id, List<String>> accountToNamesMap = new Map<Id, List<String>>();
        for(Account acc: accNewList){
            if(acc.contactNames__c != null){
                accountToNamesMap.put(acc.Id, acc.contactNames__c.split(','));
            }
        }
        List<Account> accList = [select Id, contactNames__c from Account where Id IN:accountToNamesMap.keySet()];
        
        List<Contact> conInsert = new List<Contact>();
        
        for(Account acc:accList){
            List<String> names = accountToNamesMap.get(acc.Id);
            for (String name : names) {
                Contact con = new Contact();
                con.LastName = name.trim();
                con.AccountId = acc.Id;
                conInsert.add(con);
            }
        }
        
      
        if(!conInsert.isEmpty()){
            insert conInsert;
        }
    }
    
    Public static void createContact(List<Account> accNewList){
        
        List<Contact> newContacts = new List<Contact>();

        for (Account acc : accNewList) {
            if (acc.contactNames__c != null){
                List<String> names = acc.contactNames__c.split(',');

                for (String name : names) {
                    Contact con = new Contact(
                        LastName = name.trim(),
                        AccountId = acc.Id
                    );
                    newContacts.add(con);
                }
            }
        }

        if (!newContacts.isEmpty()) {
            insert newContacts;
        }
    }
    Public static void fireErrormsg(List<Account> accList){

       // This is change from dc + this is comment from vs code
    }
}