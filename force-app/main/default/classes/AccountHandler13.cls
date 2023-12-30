public class AccountHandler13 {
    
    /* 
Write a trigger such that if an Account has any Child Opportunity having
StageName as ‘Closed Won’ then prevent deletion of that Account.
*/
    
    public static void preventAccountIfithasOpp(List<Account>accOldList){
        
        Map<Id, Account> parentChildQuery = new Map<Id, Account>([SELECT Id, 
                                                                  (SELECT Id FROM Opportunities WHERE 
                                                                   StageName = 'Closed Won' LIMIT 1)
                                                                  FROM Account WHERE Id IN : accOldList]);
        for(Account acc1 : accOldList) {
            
            if(!parentChildQuery.get(acc1.Id).Opportunities.isEmpty()){
                acc1.addError('This account has Closed Won Opportunities');
            }
        }
    } 
    
    /* write a trigger such that when account is created along with that
     create one contact to that account such that contact last namw must be account name
     */
    Public static void createChildContatc(List<Account>accNewList){
         List<Contact>conList = new List<Contact>();
        for(Account acc : accNewList){
             Contact con = new Contact();
            con.AccountId = con.Id;
            con.LastName = acc.Name;
            conList.add(con);
        }
            if(!conList.isEmpty()){
            insert conList;
           
        }
    }
    
      Public static void chOppAndSave(List<Account> accOldList){
        Map<Id, Account> parentTochild = new Map<Id, Account>([SELECT Id,(SELECT Id FROM Opportunities) 
                                                               FROM Account WHERE Id IN :accOldList]);
        for(Account acc : accOldList){
            if(parentTochild.get(acc.Id).Opportunities.size()>0){
                acc.addError('This Account has one opporetunity');
            }
        }
    }
    /* 
Write a trigger such that if an Account has any Child Opportunity having
StageName as ‘Closed Won’ then prevent editing of that Account.
*/
    Public static void preventFromEditing(List<Account>accNewList, Map<Id, Account> accOldMap){
        
        Map<Id, Account> accounttocontact = new Map<Id, Account>([SELECT ID,(SELECT Id, StageName FROM Opportunities
                                                                             WHERE StageName = 'closed won')
                                                                  FROM Account WHERE Id IN :accOldMap.KeySet()]);
        for(Account acc : accNewList){
            if(accounttocontact.get(acc.id).Opportunities.size()>0){
                acc.addError('This account has closed won opportunity please contact to higher outhority');
            }
        }
    }
    
    Public static void preventAccDeletion(List<Account> oldList, Map<Id, Account> accOldMap){
        
       Map<Id, Account> accToOppMap=new Map<Id, Account>([select Id,(select ID, StageName from Opportunities where
                                                                     StageName ='Closed won')from Account where Id IN :accOldMap.KeySet()]); 
                                 
        for(Account acc :oldList){
            if(accToOppMap.get(acc.Id).Opportunities.size()>0){
               acc.addError('This account contain closed won opp'); 
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
    
    // Create a new Trigger on Contact that will check for duplicates before allowing a new record into the database.  

    Public static void myMethod(List<Account>accNewList){
        
        set<String> nameSet= new set<String>();
        
        Map<String, Account> accMap = new Map<String, Account>();
        
        for(Account acc : accNewList){
            nameSet.add(acc.Name);
        }
        List<Account> accListSameName = [select id, Name from Account where Name IN:nameSet];
        
        if(accListSameName.size()>0){
        for(Account acc :accListSameName){
            accMap.Put(acc.Name, acc);
            }
        }
        for(Account acc :accNewList){
            if(accMap.containsKey(acc.Name)){
                acc.addError('Account with same name found');
            }
        }
    }
}