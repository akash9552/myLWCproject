public class conHClass {
    Public static void deletedContactCountOnAccount(List<Contact>conOldList){
       
        Set<Id>AccountIds = new Set<Id>();
        for(Contact con : conOldList){
            if(con.AccountId !=null) {
                AccountIds.add(con.AccountId);
            }
        }
       integer count=[select Count() FROM Contact WHERE AccountId!=null AND isDeleted =true ALL ROWS];
                                                                
        List<Account>acclist = [SELECT Id, Name, Deleted_Contacts__c FROM Account WHERE Id IN :AccountIds];
        
        List<Account>accupdate = new List<Account>();
        
        for(Account acc : acclist) {
            acc.Deleted_Contacts__c = count;
            accupdate.add(acc);
        }
        update accupdate;
    }
    
    public static void myMethod(List<Contact>conNewList){
        
        List<Student1__c>LisInsert = new List<Student1__c>();
        
        for(Contact con : conNewList){
           Student1__c std = new Student1__c();
           std.Contact__c = con.Id;
            std.Name = 'Test2';
            std.Email__c = con.Email;
            LisInsert.add(std);
        }
        if(!LisInsert.isEmpty()){
            Insert LisInsert;
        }
    }
    
     /*
    on creation of contact record check account email if it is prasent then create contact record related to Account
     if not prasent then create account record and relate contact record to that Account.
    */
    Public static void createContact(List<Contact>conNewList){
        
        List<Contact>childToParent =[SELECT ID, Account.Email__c FROM Contact WHERE ID =:conNewList AND AccountId != null];
        
        List<Contact>conlistToInsert = new List<Contact>();
        
        List<Account>accountToInsert = new List<Account>();
        
        for(Contact con : childToParent){
            if(Account.Email__c != null){
                Contact con1 = new Contact();
                con1.LastName ='test con777';
                conlistToInsert.add(con1);
            }
             if(Account.Email__c == null){
             Account acc = new Account();
             acc.Id = con.AccountId;
             acc.Name = 'test acc777';
                 accountToInsert.add(acc);
            }
        }
        if(!conlistToInsert.isEmpty()){
            insert conlistToInsert;
        }
        if(!accountToInsert.isEmpty()){
            insert accountToInsert;
        }
    }
    
    //Upon contact creation an email should be sent to email populated on Contact with specified template.
	
    public static void sendEmailContactCreated(List<Contact>conNewList, Map<Id, Contact> conOldMap){
        List<Messaging.SingleEmailMessage> msemailList = new  List<Messaging.SingleEmailMessage>();
        
        for(Contact con : conNewList){
            List<string> emailList = new List<string>();
            
            if(con.Email != null || con.Email !=conOldMap.get(con.Id).Email){
                emailList.add(con.Email);
                
                messaging.SingleEmailMessage sendEmailobj = new Messaging.SingleEmailMessage();
                sendEmailobj.setToAddresses(emailList);
                
                string subject = 'Contact creation';
                sendEmailobj.setSubject(subject);
                
                string body = 'hi your contact is created in our org with details:first Name'+con.Name+' phone '+con.Phone;
                sendEmailobj.setPlainTextBody(body);
                
                msemailList.add(sendEmailobj);
            }
            
            Messaging.sendEmail(msemailList);
            
        }
        
        
    }
}