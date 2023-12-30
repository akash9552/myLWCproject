public class ContactTriggers {
    
    // write a trigger when Contact is inserted without Parent Account create One Account with name as Acc ContactName
    Public static void createAccountToContact(List<Contact> conNewList){
       List<Account> accInsert = new List<Account>(); 
        
        system.debug(accInsert);
        
        for(Contact con:conNewList){
            if(con.AccountId == null){
                Account acc = new Account();
                acc.Name = 'Acc '+con.LastName;
                accInsert.add(acc);
            }
        }
        if(!accInsert.isEmpty()){
            insert accInsert;
        }
    }
    
    Public static void updateAccountWithAccNameasConPhone(List<Contact> conNewList){
        
        List<Account> updateAcc = new List<Account>();
        
        for(Contact con: conNewList){
            if(con.AccountId != null){
                Account acc =new Account();
                acc.Id = con.AccountId;
                acc.Name= con.Phone +''+con.LastName;
                updateAcc.add(acc);
            }
        }
        if(!updateAcc.isEmpty()){
            update updateAcc;
        }
    }
    
    //Show the error on the deletion of last contact of their respective account.
    
    Public static void preventContactDeletion(List<Contact> conOldList){
        
        set<Id> accountIdset = new set<Id>();
        
        for(Contact con: conOldList){
            if(con.AccountId != null){
                accountIdset.add(con.AccountId);
            }
        }
        Map<Id, Account> accmap = new Map<Id, Account>([select Id,(select Id from Contacts) from 
                                                        Account where Id IN:accountIdset]);
        for(Contact con :conOldList){
            if(accmap.get(con.AccountId).Contacts.size()<=1){
                con.addError('This is last contact');
            }
        }   
    }
    
   /*Write a trigger on Contact , when a contact insert an email should be sent to contact email id with specified template.
    So first you need to create text template. Template Design is below.*/

    Public static void sendEmailToconUsingTemplate(List<Contact> conNewList){
        
        List< Messaging.SingleEmailMessage> sendEmailList =new List< Messaging.SingleEmailMessage>();
        
        EmailTemplate emailTemplate = [Select Id,Subject,Description,HtmlValue,DeveloperName,Body from EmailTemplate where 
                                       name='Contact Email Template' LIMIT 1];
        
        List<string> conEmails = new List<string>();
        
        for(Contact con :conNewList){
            if(con.Email != null){
                conEmails.add(con.Email);
            }
            Messaging.SingleEmailMessage msg =new  Messaging.SingleEmailMessage();
            
            msg.setTargetObjectId(con.Id);
            
            msg.setTemplateId(emailTemplate.Id);
            
            msg.setToAddresses(conEmails);
            
            sendEmailList.add(msg);
        }
        if(!sendEmailList.isEmpty()){
            Messaging.sendEmail(sendEmailList);
        }
    }
    
    //Write a trigger on contact to prevent duplicate records based on Contact Email & Contact Phone.
    /*This trigger should run on the "before insert" and "update" events. Here, we retrieve a list of all records
        that have an email or phone associated with them. To do this, we use a set of phone numbers and email addresses. 
        Afterwards, we check if each record contains either of these using the "isContain()" function.*/
    
 
    Public static void avoidDuplicateConInsert(List<Contact> conNewList){
        
        set<string> emailset =new set<string>();
        set<string> phoneset =new set<string>();
        
        for(Contact con : conNewList){
            if(con.Phone != null || con.Email != null){
                phoneset.add(con.Phone);
                emailset.add(con.Email);
            }
        }
        
        List<Contact> conListWithEmailCon = [select ID, Email, Phone from Contact where Email IN:emailset 
                                             OR Phone IN:phoneset];
        
        for(Contact con: conNewList){
            if(!conListWithEmailCon.isEmpty()){
               con.addError('This email or Phone is Duplicate'); 
            }
        }
    }
    
    // dulication Avoid on the basis of first Name of contact
    
    Public static void avoidFirstNameDulicate(List<Contact> conNewList){
        
     set<String> conFirstName = new set<String>();
       // Map<string, Contact> conMap = new Map<string, Contact>();
        
        for(Contact con :conNewList){
            if(con.FirstName != null){
             conFirstName.add(con.FirstName);
               //conMap.put(con.FirstName, con);
            }
        }
        List<Contact> conRecords =[select Id, FirstName from Contact where FirstName IN:conFirstName];
        for(Contact con :conNewList){
            if(conRecords.size()>0){
                con.addError('duplicate FirstName found');
            }
        }
    }
    
  //When Contact update collect all opportunity Amount And Update this amount on Account Level Field (Total Opportunity Amount)
	
    Public static void updateAccwithOPPfieldWhenConUpdate(List<Contact> connewlist){
        
        set<Id> accountId = new set<Id>();
        
        for(Contact con :connewlist){
            if(con.AccountId != null){
                accountId.add(con.AccountId);
            } 
        }
        List<AggregateResult> aggrOpp =[select AccountId, sum(Amount) totalAmount from Opportunity where 
                                        AccountId IN:accountId group by AccountId];
        
        List<Account> accUpdate = new List<Account>();
        
        for(AggregateResult agr:aggrOpp){
            Account acc =new Account();
            acc.Id = (Id)agr.get('AccountId');
            acc.Total_Opportunity_Amount_2__c = (decimal)agr.get('totalAmount');
            accUpdate.add(acc);
        }
        if(!accUpdate.isEmpty()){
            update accUpdate;
        }
    }  
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}