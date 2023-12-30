public class AccountTriggerHandler11 {
    /*
    Write a trigger such that if an Account has any Child Opportunity 
    having StageName as ‘Closed Won’ then prevent deletion of that Account.
    */
    Public static void checkChildAndSave(List<Account> accOldList){
        Map<Id,Account> parenttoChild = new Map<Id, Account>([SELECT Id,(SELECT Id, StageName
                                                                         FROM Opportunities WHERE StageName ='Closed Won')
                                                               FROM Account WHERE ID IN :accOldList]);
        for(Account acc :accOldList){
            if(!parenttoChild.get(acc.Id).Opportunities.isEmpty()){
                acc.addError('This Account has closed won Opportunity');
            }
        }
    }
    
    Public static void myMethod(List<Account> accNewList, Map<Id, Account> oldMap){
        
        List<Account> parentTochild = [SELECT ID, Email__c,(SELECT ID, Email FROM Contacts)FROM Account WHERE ID In :accNewList];
        
        List<Contact> conUpdate = new List<Contact>();
        
        for(Account acc :parentTochild){
            if(acc.Email__c != null && acc.Email__c != oldMap.get(acc.id).Email__c){
                
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
    
    /*
      If the Account phone is updated then populate below message indescription
       Description = Phone is Updated! Old Value : XXX & New Value : XXX
     */
    Public static void updateAccount(List<Account> accNewList, Map<Id, Account> accOldMap){
  
        for(Account acc : accNewList){
            if(acc.Phone != null || acc.Phone != accOldMap.get(acc.Id).Phone){
                acc.Description = 'Phone is Updated! Old Value :'+accOldMap.get(acc.id).Phone+'New Value :'+acc.Phone;
            }
        }
    
    }
    
    //Upon Account Creation or updation if Industry is not null and having value as ‘Media’ then populate Rating as Hot.
    //
    Public static void myMethod(List<Account> accNewList){
        
        for(Account acc : accNewList){
            if(acc.Industry =='Media'){
                acc.Rating = 'hot';
            }
        }
    }
    
    /*
     If the Account billing address is updated then update related contacts
     mailing address. 
     */
    Public static void parentToChild(List<Account> accNewList, Map<Id, Account> accOldMap){
        
        Set<Id> accIdSet = new Set<Id>();
        
        for(Account acc : accNewList){
            if(acc.BillingCity != accOldMap.get(acc.Id).BillingCity || 
               acc.BillingCountry != accOldMap.get(acc.Id).BillingCountry ||
               acc.BillingPostalCode != accOldMap.get(acc.Id).BillingPostalCode || 
               acc.BillingStreet != accOldMap.get(acc.id).BillingStreet||
               acc.BillingState != accOldMap.get(acc.Id).BillingState){
                   accIdSet.add(acc.Id);
               }
        }
        List<Account> parentTOchildList = [SELECT Id, BillingCountry, BillingCity, BillingState, 
                                           BillingPostalCode, BillingStreet,(SELECT Id FROM Contacts) 
                                           FROM Account WHERE Id IN :accIdSet];
        
        List<Contact> conList =new List<Contact>();
        
        for(Account acc :parentTOchildList){
            if(acc.Contacts != null){
                for(Contact con : acc.Contacts){
                    con.MailingCountry=acc.BillingCountry;
                    con.MailingCity= acc.BillingCity;
                    con.MailingState=acc.BillingState;
                    con.MailingPostalCode=acc.BillingPostalCode;
                    con.MailingStreet=acc.BillingStreet;
                    conList.add(con);
                }
                if(!conList.isEmpty()){
                    update conList;
                }
            }
        }
    }
    
    /*
     Write a trigger on Account when Account Active field is updated from ‘Yes’
     to ‘No’ then check all opportunities associated with the account. Update all
     Opportunities Stage to close lost if stage not equal to closed won.
     */
    Public static void updateOppOnUpdateAccount(List<Account> accNewList, Map<Id, Account>accOldMap){
        
        List<Id>accId =new List<Id>();
        
        for(Account acc :accNewList){
            if(acc.IsActive__c != accOldMap.get(acc.id).IsActive__c && acc.IsActive__c == False){
                accId.add(acc.Id);
            }
        }
        List<Account> parentToChild = [SELECT Id, IsActive__c,(SELECT ID, StageName FROM Opportunities) 
                                       FROM Account WHERE Id IN :accId];
        List<Opportunity> oppList = new List<Opportunity>();
        
        for(Account acc :parentToChild){
            if(acc.Opportunities != null){
                for(Opportunity opp :acc.Opportunities){
                    if(opp.StageName != 'closed Won' && opp.StageName != 'Closed lost'){
                        opp.StageName ='Clased Lost';
                        oppList.add(opp);
                    }
                }
            }
        }
        if(!oppList.isEmpty()){
            update oppList;
        }
    }
    
    Public static void avoidDuplicateRecord(List<Account> accNewList){
        
        Map<Id, Account> accMap = new Map<Id, Account>([select Id, Name from Account where ID IN:accNewList]);
       
        for(Account acc : accNewList){
            if(acc.Name == accMap.get(acc.Id).Name){
                acc.addError('duplicate account Foud');
            }
        }
    }
    Public static void avoidDuplicateRecord2(List<Account> accNewList){
       Set<String> accNameList = new Set<String>();
        for(Account acc :accNewList){
            accNameList.add(acc.Name);
        }
        for(Account acc : accNewList){
            if(accNameList.contains(acc.Name)){
                acc.addError('duplicate account found with name');
            }
        }
    }
    Public static void avoidDuplicateRecord3(List<Account> accNewList){
        List<Account> accList = [select id, Name, Rating from Account where Rating != null AND Id IN:accNewList];
        for(Account acc : accNewList){
            if(accList.size()>0){
                acc.addError('duplicate account found with name'); 
            }
        }
    }
    
    //When an account BillingCity is updated, update all its contacts MailingCity with account BillingCity.
    
    Public static void updateBillingCity(List<Account>accNewList, Map<Id, Account>accOldMap){
        
        List<Account> accList = [select id, BillingCity,(select id, MailingCity from Contacts) 
                                 from Account where Id In :accNewList];
        
        List<Contact> conList =new List<Contact>();
        for(Account acc : accList){
            if(acc.BillingCity !=null && acc.BillingCity != accOldMap.get(acc.Id).BillingCity){
                for(Contact con: acc.Contacts){
                    con.MailingCity = acc.BillingCity;
                    conList.add(con);
                }
            }
        }
        if(!conList.isEmpty()){
            update conList;
        }
    }
    
    Public static void updateBillingCity1(List<Account>accNewList, Map<Id, Account>accOldMap){
        
        Map<Id, Account> accMapChangedValues = new Map<Id, Account>();
        
        for(Account acc : accNewList){
            if(accOldMap != null){
                if(acc.BillingCity != null &&  acc.BillingCity != accOldMap.get(acc.Id).BillingCity){
                    accMapChangedValues.put(acc.Id, acc);
                }
            }
        }
        List<Contact> conList = [select Id, MailingCity, AccountId from Contact where AccountId IN:accMapChangedValues.keySet()];
        
        List<Contact> conToUpdate = new List<Contact>();
        
        for(Contact con : conList){
            con.MailingCity = accMapChangedValues.get(con.AccountId).BillingCity;
            conToUpdate.add(con);
        }
        if(!conToUpdate.isEmpty()){
            update conToUpdate;
        }
    }
    /*
    Write a trigger on Account, when an account is inserted, automatically account billing address should populate 
        into the account shipping address. 
*/
    Public static void papulateBillingAdressInshippingadd(List<Account> accNewList){
        for(Account acc : accNewList){
            
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
    
    // Prevent account from deleting, if it has 2 or more contacts.
    // 
    Public static void preventAccDeletion1(List<Account> accOldList, Map<Id, Account>accOldMap){
        
        Map<Id, Account> accMap = new Map<Id, Account>([select id,(select id from Contacts)from Account
                                                        where Id IN:accOldMap.keySet()]);
        for(Account acc :accOldList){
            if(accMap.get(acc.Id).contacts.size()>=2){
              acc.addError('This Account contain more than two contact');  
            }
        }
    }
   
    public static void preventAccDeletion(List<Account> accOldList){
        
       Integer count = [SELECT Count() FROM Contact WHERE AccountId =:accOldList];
   
        for(Account acc : accOldList){
            if(count>2){
                acc.addError('this Account contains more than 2 contact');
            }
        }
    }
    
    //Prevent account from deleting, if it has contact with level as Tertiary and lead source as Web
    
    Public static void preventAccDeletion2(List<Account> accOldList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> accConMap = new Map<Id, Account>([select id,(select LeadSource, Level__c from 
                                                           Contacts where LeadSource ='Web' AND Level__c='Tertiary')
                                                           from Account where Id IN :accOldMap.keySet()]);
        for(Account acc :accOldList){
            if(accConMap.get(acc.id).Contacts.size()>0){
                acc.addError('This account contain contact with leadsource as web and level as Tertiery');
            }
        }
        
    }
}