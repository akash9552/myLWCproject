public class AccountHandlerClass_2 {
    
    //Prevent account from deleting, if it has 2 or more contacts
    Public static void myMethod2(){
        
    }
    
    //Prevent account record from being edited if the record is created 7 days back.

    Public static void preventEditionAcc(List<Account>accNewList){
        
        for(Account acc : accNewList){
            if(acc.CreatedDate < System.today()-6){
                acc.addError(Account.CreatedDate,'You cannot update account created 7 days back');

            }
        }
    }
    
    //Write a trigger on Account and check only System Administrator profile users should be able to delete an account.
	
    Public static void checkUser(List<Account> accOldList){
        
        Profile p =[SELECT Name, Id FROM Profile WHERE Name ='System Administrator'];
        
        for(Account acc : accOldList){
            if(UserInfo.getProfileId() !=p.Id){
                acc.addError('Only System Administrator can delete Acount Record');
            }
        }
    }
    
    // avoid duplicate Account on the basis of Email
    
    Public static void avoidDuplicateAccEmail(List<Account> accNewList){
        
       set<String> accEmail = new Set<String>();
       Map<string, Account> accMap = new Map<String, Account>();
        
        for(Account acc :accNewList){
            if(acc.Email__c != null){
                accEmail.add(acc.Email__c);
            }
        }
       List<Account> accWithEamil = [select Id, Email__c from Account where Email__c In:accEmail];
        
        for(Account acc :accWithEamil){
            accMap.put(acc.Email__c, acc);
        }
        for(Account acc:accNewList){
            if(accMap.containsKey(acc.Email__c)){
                acc.addError(Account.Email__c, 'Account with duplicate eamil');
            }
        }
    }
    
    Public static void avoidDuplicateAccPhone(List<Account> accNewList){
        
        set<String> phoneSet = new Set<String>();
     
        for(Account acc :accNewList){
            if(acc.Phone != null){
                phoneSet.add(acc.Phone);
            }
        }
        List<Account> accList = [select Id, Phone from Account where Phone IN :phoneSet];
        
        for(Account acc :accNewList){
            if(accList.size()>0){
                acc.addError(Account.Phone, 'Duplicate phone found');
            }
        }
    }
    
    /*
    public static void preventAcc(List<Account> accOldList){
        
        List<Account> accToChild =[select id,(select id from Contacts) from Account where ID IN:accOldList];
        
        for(Account acc:accToChild ){
            
            if(acc.Contacts.size()>=2){
                acc.addError('this Account contain more than two Active Contact');
            }
        }
    }
*/
     Public static void preventAccDeletion1(List<Account> accOldList, Map<Id,Account> accOldMap){
        
        Map<Id, Account> accMap = new Map<Id, Account>([select id,(select id from Contacts)from Account
                                                        where Id IN:accOldMap.keySet()]);
        for(Account acc :accOldList){
            if(accMap.get(acc.Id).contacts.size()>=2){
                acc.addError('This Account contain more than two contact');  
            }
        }
    }
     
Public static void preventAccdeletion(List<Account> accOldList){
    
    integer count =[SELECT Count() FROM Contact WHERE AccountId =:accOldList];
    
    for(Account acc :accOldList){
        
        if(count>=2){
            acc.addError('this Account contain more than two Active Contact');
            
        }
    }
}
    
    /*Write a trigger on Account object that will insert a new Account with same name when
 the value of isActive__c field is change from true to false or Account insert with isActive__c field as false.
    */
     public static boolean executeTrigger = true;
    Public static void createAccount(List<Account> accNewList){
       
        List<Account> accList = new List<Account>();
        
        for(Account acc :accNewList){
            if(acc.IsActive__c == false){
                
                    Account acc1 = new Account();
                    acc1.Name=acc.Name;
                    accList.add(acc1);
            
            }
        }
        if(!accList.isEmpty()){
            insert accList;
        }
    }
    
    // write a trigger such that when accountName changes change its all related contact last name
    
    Public static void changeConlastNameAsAccountNAME(List<Account> accNewList, Map<Id, Account> accOldMap){
        
       Map<Id, Account> changedEcordMap = new Map<Id, Account>();
        
        for(Account acc:accNewList){
            if(acc.Name != accOldMap.get(acc.Id).Name){
                changedEcordMap.put(acc.Id, acc);
            }
        }
        List<Contact> conList = [select Id, LastName, AccountID from Contact where AccountId In:changedEcordMap.keySet()];
        
        List<Contact> conUpdate = new List<Contact>();
        
        for(Contact con:conList){
            con.AccountId = changedEcordMap.get(con.AccountId).Id;
            con.LastName = changedEcordMap.get(con.AccountId).Name;
            conUpdate.add(con);
        }
        if(!conUpdate.isEmpty()){
           update conUpdate;
        }
    }
    
    // write a trigger such that if Account has contact then prevent from deletion
    
    Public static void preventAccIfHasCon(List<Account> accOldList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> accMap = new Map<Id, Account>([select id,(select id from Contacts)
                                                        from Account where Id IN:accOldMap.keySet()]);
        for(Account acc:accOldList){
            if(accMap.get(acc.Id).Contacts.size()>0){
                acc.addError('This Account contain contact not able to delete');
            }
        }
    }
    //write a trigger such taht is Account has closed won opp then you are not able to delete this
    
    Public static void prventAccContainClosedWonOpp(List<Account> accOldList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> accMap = New Map<Id, Account>([select Id,(select Id, StageName from Opportunities
                                                          where StageName ='Closed Won')from Account where
                                                        Id In:accOldMap.keySet()]); 
        for(Account acc :accOldList){
            if(!accMap.get(acc.Id).Opportunities.isEmpty()){
                acc.addError('This acc contain closed won opp');
            }
        }
    }
    
    Public static void beforeUpdateRating(List<Account> accNewList, Map<Id, Account> accOldMap){
        
        for(Account acc:accNewList){
            if(acc.Rating != accOldMap.get(acc.Id).Rating){
               acc.Rating ='Hot'; 
            }
        }
    }
    
}