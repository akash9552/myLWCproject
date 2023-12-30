public class SOQLClass {
    public static void soqlLooping2(){
        List<Opportunity>oppList = [SELECT Id,Name,CloseDate,StageName
                                    FROM Opportunity WHERE StageName = 'Closed Won' OR CloseDate = :Date.Today().addDays(90) ];
        for(Opportunity opp : oppList){
            system.debug('Opportunity names: '+opp.Name);
            
        }  
    } 
    public static void soqlLooping1(){
        List<Account>accList = [SELECT Id,Name
                                    FROM Account WHERE CreatedDate = TODAY];
        for(Account acc : accList){
            system.debug('Account names: '+acc.Name);
           
        }  
    } 
 public static void soqlLooping3(){
        List<Account>accList = [SELECT Id,Name,AnnualRevenue
                                    FROM Account WHERE AnnualRevenue > 5000 AND AnnualRevenue < 10000];
        for(Account acc : accList){
            system.debug('Account names: '+acc.Name +' ' +acc.AnnualRevenue);
            
        }  
    }
    
//Retrive 10 Account and all Cases realated to each Account and Put in map such that AccountId as key and value as Case records

    Public static void eySoqlQuestion(){
        
        Map<Id,List<Case>> caseMap = new Map<Id,List<Case>>();
        
        List<Account> accToCaseList = [select Id,(select Id from Cases) from Account LIMIT 10];
        system.debug(accToCaseList);
        
        for(Account acc :accToCaseList){
            caseMap.put(acc.Id, acc.Cases);
        }
        system.debug(caseMap);
    }
    
    // Get Account Record having atleast one Contact record
    
    Public static void accMethod(){
        set<Id> accountIdSet = new Set<Id>();
        
        List<Contact> conList=[select AccountId from Contact where AccountId !=null];
        for(Contact con :conList){
            accountIdSet.add(con.AccountId);
        }
        List<Account> accList =[select Name from Account where Id IN:accountIdSet order by Name];
        for(Account acc :accList){
            system.debug(acc.Name);
        }
    }
    
     public static void customSoql(){
        
        List<Revew__c> childToParent = [select Name, Interviewer_Name__c, Job_Application__r.status__c, 
                                        Job_Application__r.Name from Revew__c];
        for(Revew__c rev:childToParent){
            system.debug(rev.Job_Application__r.Name);
              system.debug(rev.Job_Application__r.status__c);
        }
     }
    public static void myDynamicsoql(string fieldName, string objectName){
        string soqlstr= 'select '+FieldName+' from '+objectName+'';
        system.debug(soqlstr);
        List<sObject> objlist= database.query(soqlstr);
        system.debug(objlist);
        
        for(sObject soobj:objlist){
    system.debug(soobj.get('Name'));
        }
    }
    public static void mySoslQuery(){
        List<List<sObject>> soslList=[FIND'Akash'Returning Account(Name), Contact(Name)];
       List<Account>accList=soslList[0];
        List<Contact>conList =soslList[1];
        system.debug(accList);
        system.debug(conList);
        for(Account acc:accList){
            system.debug(acc.get('Name'));
        }
         for(Contact con:conList){
            system.debug(con.get('Name'));
        }
        
    }
    
    public static void leadRecord(){
        
        List<Lead> allLead = [select Id, Name from Lead ALL ROWS];
        system.debug(allLead);
        
        List<Account> accList = [select Name,(select Name from Contacts ) from Account where Id 
                                 In(select AccountId from Contact where AccountId !=null)];
    }
    
    
}