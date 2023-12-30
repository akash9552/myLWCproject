public class SOQLpracticeClass {
    // Normal soql query that give all contact record in list
    public static void myMethod1(){
        
        List<Contact>contRecordList =[SELECT ID,Name FROM Contact];
        for(Contact con : contRecordList){
            system.debug(con.Name);
        }
    }
    // write soql query on child and get parent records name
    public static void myMethod2(){
        
        List<Contact>conTOacc = [SELECT  Account.Name FROM Contact WHERE AccountId != null];
        
        for(Contact con :conTOacc){
            System.debug(con.Account.Name);
        }
    }
    
    public static void myMethod3(){
        
        List<Contact>conTOacc = [SELECT Account.Name FROM Contact];
        
        for(Contact con :conTOacc){
            System.debug(con.Account.Name);
        }
    }
    // write query on custom child object to get parent id and parent name
    public static void myMethod4(){
        
        List<Revew__c>childToParentCustomObj = [SELECT Id, Name, Job_Application__c, position__r.Name FROM Revew__c];
        
        for(Revew__c rev : childToParentCustomObj){
            
            System.debug(rev.Name +'=='+rev.Job_Application__c +'=='+rev.position__r.Name);
        }
    }
    /* get account record that have at least one contact 
     you can directly get the result using this query [SELECT ID, Name FROM Account WHERE ID IN 
    (select AccountId FROM Contact)]
 */
    public static void myMethod5(){
        
        List<Contact>conlist = [SELECT Id, AccountId FROM Contact];
        
        Set<ID>accountIdSet = new Set<ID>();
        
        for(Contact con : conlist){
            accountIdSet.add(con.AccountId);
        }
        List<Account>acclist = [SELECT Id, Name FROM Account WHERE ID IN :accountIdSet];
        // in operator mostly used with set and list 
        
        System.debug(acclist);
    }
    //parent to chaild query in apex class
    public static void myMethod6(){
        
        List<Account>accToConList = [SELECT Id, Name,(SELECT Id, Name FROM Contacts) FROM Account];
        
        for(Account acc : accToConList){
            
            System.debug(acc.Name);
            
            for(Contact con : acc.Contacts){
               
                System.debug(con.name);
            }
        }
    }
    // parent to child query on custom object that have at least one contact
    public static void myMethod7(){
        
        List<position__c>positionTOJobposting = [SELECT Id, Name, (SELECT Id,Name FROM Job_Postings__r)FROM position__c];
        
        for(position__c po : positionTOJobposting){
            
            System.debug(po.Name);
            
            for(Job_Posting__c jobpo: po.Job_Postings__r){
                
                system.debug(jobpo);
            }
        }
    }
    // Store/ pass soql query result in map
    Public static void myMethod8(){
        
        Map<Id,Account>conMap = new Map<Id,Account>([SELECT ID,Name FROM Account]);
        System.debug(conMap);
        
    }
    
    // partial Dynamic SOQL 
    public static void myMethod9(String FieldName){
        
        String kiran = 'SELECT Id, Name '+FieldName+' FROM Opportunity';
        
        System.debug(kiran);
        
        List<Opportunity>oppList = Database.query(kiran);
        
        System.debug(oppList);
    }
    // fully dynamic soql query
    public static void myMethod10(String FieldName, String ObjectName) {
        
        String DynamicSOQL_Query = 'SELECT Id, '+FieldName+' FROM '+ObjectName;
        
        system.debug(DynamicSOQL_Query);
        
        List<Sobject>SobjectList = Database.query(DynamicSOQL_Query);
        
        System.debug(SobjectList);
        
    }
    // write soql query taht give opportunity record in Ascending  order on the basis of amount
    public static void myMethod11(){
        List<Opportunity>oppList = [SELECT ID, Name, Amount FROM Opportunity ORDER BY Amount ASC];
        
         List<Opportunity>oppList2 = [SELECT ID, Name, Amount FROM Opportunity ORDER BY Amount DESC];
        
            // write soql query taht give opportunity record in Descending  order on the basis of amount

        for(Opportunity opp : oppList){
            system.debug(opp.Amount);
        }
        for(Opportunity opp : oppList2){
            system.debug(opp.Amount);
        }
    }
    
    //Get name from contact where name is either Akash or Gutte

    Public static void myMethod12(){
        List<Contact>conList = [SELECT Id, Name FROM Contact WHERE Name IN ('Akash','Gutte')];
        for(Contact con : conList){
            system.debug(con.Name);
        }
    }
    //Get the 5th highest Amount from Opportunity records. Get only that particular single record
    
    Public static void myMethod13(){
        List<Opportunity>oppList = [SELECT Id, Name, Amount FROM Opportunity WHERE Amount != null 
                                    ORDER BY Amount DESC LIMIT 1 OFFSET 4];
        for(Opportunity opp : oppList){
            system.debug(opp.Amount);
        }
           //system.debug(oppList.size());              
    }
    
    // write soql query for retrieve account those having at least one associate contact
    Public static void myMethod14(){
        List<Account>accList = [SELECT ID, Name FROM Account WHERE ID IN (select AccountId FROM Contact)];
        
        // write soql query that give account record having no contact
        
        List<Account>accList2 = [select id, name from Account where Id not in (select AccountId from Contact)];
        for(Account acc: accList){
            system.debug(accList);
        }
       
        for(Account acc : accList2){
            system.debug(accList2);
        }
    }
    //How can I retrieve all the Lead records created in the last 30 days?
    public static void myMethod15(){
        List<Lead>leadList = [SELECT Id, Name FROM Lead WHERE CreatedDate = LAST_N_DAYS:30];
        for(Lead le : leadList){
            system.debug(le);
        }
    }
    
    //  SOSL in Query Editor and In Apex 
    // In Query Editor you have to write sosl like = FIND {Akash} RETURNING Account (Id, Name , Phone)
      public static void soslExamples(){
        List<List<sObject>> soslList = [FIND 'Akash' RETURNING Account (Id, Name), Opportunity(StageName)];
        
        List<Account> AccountList = soslList[0];
          
        List<Opportunity> oppList = soslList[1];
        
        System.debug(AccountList);
          
        System.debug(oppList);
    }
    // Dnyamic sosl 
    Public static void dynamicsosl(){
        string dynamicSOSL = 'FIND \'Akash\' RETURNING Contact (Id, Name, Email, Phone)';
        List<List<sObject>>conList = Search.query(dynamicSOSL);
        system.debug(conList);

    }
    
  // How would you write a query if I need to display number of opportunities and number of contacts on a Salesforce Account?
  
    public static void countOfContactANDOpportunity(){
   /*
        integer count= [select(select Count(ID) from Contacts GROUP BY ID), (select count(ID) from Opportunities GROUP BY Id)
                        from Account WHERE Id = '0015i00000ujTPfAAM'];
        
        system.debug(count);
*/
   /*
        List<Account> accList = [SELECT ID,(SELECT ID FROM Contacts),(SELECT Id FROM Opportunities)
                                 FROM Account WHERE ID = '0015i00000ujTPfAAM'];
        
        for(Account acc : accList){
            system.debug(acc.Contacts.size());
            system.debug(acc.Opportunities.size());
        }
       */ 
         }
}