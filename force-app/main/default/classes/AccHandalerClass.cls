public class AccHandalerClass {
    
    //Prevent deletion of an account if there is any opportunity related to that account.
    
   
    
    Public static void preventDeleteionAcc1(List<Account> accOldList){
        for(Account acc: accOldList){
            
            List<Opportunity> oppList = [SELECT ID FROM Opportunity WHERE AccountId =:acc.Id];
            if(oppList.size()>0){
                acc.addError('you are not able to delete Account becouse this contens opp');
            }
        }
    }
    //Prevent deletion of an account if there is any case related to that account.
    Public static void preventAccDeletionCase(List<Account> accOldList){
        Set<Id> accId = new Set<Id>();
        
        for(Account acc : accOldList){
            accId.add(acc.id);
        }
        List<Account> accTCase = [SELECT ID,(SELECT Id FROM Cases) FROM Account WHERE ID IN:accId];
        for(Account acc :accTCase){
            if(acc.Cases.size()>0){
                acc.addError('This acc contains case');
            }
        }
    }
    Public static void preventAccDeletionIfContact(List<Account> accOldList){
       
        List<Contact> conList = [SELECT Id FROM Contact WHERE AccountId IN :accOldList];
        for(Account acc: accOldList){
            if(conList.size()>0){
                acc.addError('You can not delete account where Contact are available');
            }
        }
    }
    Public static void preventdd(List<Account>accOldList){
         Integer count = [SELECT Count() FROM Contact WHERE AccountId IN :accOldList];
        for(Account acc :accOldList){
            if(count>0){
                acc.addError('contact contains');
            }
        }
    }
    public static void preventDelIfHasRelatedCase(List<Account> accList){
        Set<Id> idSet= new Set<Id>();
        for(Account acc:accList){
            idSet.add(acc.Id);
        }
        for(Account acc:[SELECT Id,(SELECT Id FROM Cases)FROM Account
                         WHERE Id IN:idSet]){
                             if(acc.Cases.size() > 0){
                                 acc.addError('You can not delete account where cases are available ');
                                 
                             }
                         }
    }
    
    /*
	  Create “Sales Rep” with data type on the Account object. While we create account records,
      account owners will be systematically inserted into the sales representative field. 
      While we update the record account owner, the sales representative will be systematically updated.     
     */ 
    /*
     Trigger will fires when we try to create the account with the same name i.e. Preventing the users to create Duplicate Accounts
	*/
    Public static void avoidDuplicateAccRecord(List<Account> accNewList, Map<Id, Account> accOldMap){
        Set<String> accNames = new Set<String>();
       
        for(Account acc : accNewList){
            if(acc.Name != null || acc.Name != accOldMap.get(acc.Id).Name){
                 accNames.add(acc.Name);
                accNames.add(accOldMap.get(acc.Id).Name);
                if(accNames.size()>0){
                      acc.addError('Account with duplicate name is not allowed');
                }
            }
        }
    }
    
    Public static void updateChild(List<Account> accNewList, Map<Id, Account> accOldMap){
        
        List<Account> accConList= [select id, Email__c,(select id, Email from Contacts) from Account where Id IN :accNewList];
        
        List<Contact> conUpdate = new List<Contact>();
        
        for(Account acc :accConList){
            if(acc.Email__c != null && acc.Email__c != accOldMap.get(acc.Id).Email__c){
                for(Contact con : acc.Contacts){
                    con.Email = acc.Email__c;
                    conUpdate.add(con);
                }
            }
        }
        if(!conUpdate.isEmpty()){
            update conUpdate;
        }
    }
    
    Public static void updateChildUsingMap(List<Account> accNewList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> accUpdatedMap = new Map<Id, Account>();
        
        for(Account acc :accNewList){
            if(accOldMap != null){
                if(acc.Budget__c != null && acc.Budget__c !=accOldMap.get(acc.Id).Budget__c){
                    accUpdatedMap.put(acc.Id, acc);
                }
            }
        }
        List<Opportunity> oppList = [select AccountId, Description from Opportunity where AccountId IN:accUpdatedMap.KEYsET()];
        
        List<Opportunity> oppLitUpdate = new List<Opportunity>();
        
        for(Opportunity opp :oppList){
            opp.Description = 'Account Budget is changed New budget is: '+accUpdatedMap.get(opp.AccountId).Budget__c;
            oppLitUpdate.add(opp);
        }
        if(!oppLitUpdate.isEmpty()){
            update oppLitUpdate;
        }
    }
    
    Public static void createChildMethod(List<Account> accNewList) {
        /*
        set<Id> accId = new Set<Id>();
        for(Account acc : accNewList){
            accId.add(acc.id);
        }
        */
        List<Account> accToConList = [select Id, Name, Phone,(select Id, Name, Phone from Contacts)
                                      from Account where Id IN:accNewList];
        
        List<Contact> conInsert = new List<Contact>();
        
        for(Account acc :accToConList ){
            if(acc.Contacts.size()<1 ){
                
                Contact con= new Contact();
                con.AccountId =acc.Id;
                con.LastName = acc.Name;
                con.Phone = acc.Phone;
                conInsert.add(con);
            }
        }
        if(!conInsert.isEmpty()){
            insert conInsert ;
        }
    }
    
    /*
    Write a trigger such that whenever a new account is getting created a single child contact must 
	also get created. Try to write test class for this.
     */
    Public static void createContactWithAcc(List<Account> accNewList){
        
        List<Contact> conInsert = new List<Contact>();
        
        for(Account acc :accNewList){
            Contact con = new Contact();
            con.AccountId= acc.Id;
            con.LastName = acc.Name;
            conInsert.add(con);
        }
        if(!conInsert.isEmpty()){
            insert conInsert;
        }
    }
}