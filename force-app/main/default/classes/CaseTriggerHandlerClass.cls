public class CaseTriggerHandlerClass {
    
    // Make rollup summary of case on account object
   /* 
    Public static void caseInsertMethod(List<Case>caseNewList) {
        
        Set<Id>accountIds = new Set<Id>();
        
        for(Case cs : caseNewList) {
            if(cs.AccountId != null){
               accountIds.add(cs.AccountId); 
            } 
        }
        List<Account>parenttochild =[SELECT Id, Case_Caount__c, (SELECT Id, AccountId FROM Cases) 
                                     FROM Account WHERE Id IN :accountIds];
        
        List<Account>acctoupdate = new List<Account>();
        
        for(Account acc : parenttochild) {
            acc.Case_Caount__c = acc.Cases.size();
            acctoupdate.add(acc);
        }
        if(!acctoupdate.isEmpty()) {
            update acctoupdate;
        }
    }
    
    Public static void caseUpdateMethod(List<Case>caseNewList, Map<Id, Case>caseOldMap) {
        
        Set<Id>accountIds = new Set<Id>();
        for(Case cs : caseNewList) {
            if(cs.AccountId != null && cs.AccountId != caseOldMap.get(cs.Id).AccountId) {
                accountIds.add(cs.AccountId);
                accountIds.add(caseOldMap.get(cs.Id).AccountId);
            }
        }
       List<Account>parenttochild =[SELECT Id, Case_Caount__c, (SELECT Id, AccountId FROM Cases) 
                                     FROM Account WHERE Id IN :accountIds];
        
        List<Account>acctoupdate = new List<Account>();
        
        for(Account acc : parenttochild) {
            acc.Case_Caount__c = acc.Cases.size();
            acctoupdate.add(acc);
        }
         if(!acctoupdate.isEmpty()) {
            update acctoupdate;
        }
    }
    
    Public static void caseDeleteMethod(List<Case>caseOldList) {
        Set<Id>accountIds = new Set<Id>();
        
        for(Case cs : caseOldList) {
            if(cs.AccountId != null) {
                accountIds.add(cs.AccountId);
            }
        }
        List<Account>parenttochild = [SELECT Id, Case_Caount__c,(SELECT Id, AccountId FROM Cases)
                                      FROM Account WHERE Id IN : accountIds];
        
        List<Account>acctoupdate = new List<Account>();
        for(Account acc : parenttochild) {
            acc.Case_Caount__c = acc.cases.size();
            acctoupdate.add(acc);
        }
    }
*/
    
 /*When a Case is created on any Account, put the latest case number on the
   Account in the ‘Latest Case Number’ field.
 */
    
    Public static void caseToAccount(List<Case> caseNewList){
        
        List<Account> accToUpdate = new List<Account>();
        
        for(Case cs : caseNewList){
            if(cs.AccountId != null){
             Account acc =new Account();
         		acc.Id = cs.AccountId;
                acc.Latest_Case_Number__c = cs.CaseNumber;
                accToUpdate.add(acc);
            }
            if(!accToUpdate.isEmpty()){
                update accToUpdate;
            }
        }
    }
    
    /*
     whenever escalation checkbox is checked for a case on an Account a follow up task is automatically created
     for primary Contact on that Account.
     */ 
    Public static void createTaskForContact(List<Case> newCase, Map<Id,Case> caseOldMap){
        
        Set<Id> accIdset = new Set<Id>();
        Map<Id,Contact> conMap = new Map<Id, Contact>();
        List<Task> taskListInsert = new List<Task>();
        
        for(Case cs : newCase){
            if(cs.Escalation__c !=caseOldMap.get(cs.Id).Escalation__c && cs.Escalation__c == true && cs.AccountId !=null){
                accIdset.add(cs.Id);
            }
        }
        List<Contact> primaryConList = [SELECT Id, Primary_Contact__c, AccountId FROM Contact WHERE Id IN :accIdset
                                        AND Primary_Contact__c = true order by LastModifiedDate LIMIT 1];
        for(Contact con : primaryConList){
            conMap.put(con.AccountId, con);
        }
        for(Case cs2 :newCase){
            if(conMap.containskey(cs2.AccountId)){
                Contact primaryCon = conMap.get(cs2.AccountId);
                
                task tk = new task();
                tk.WhoId = primaryCon.Id;
                tk.Subject = 'Follow up task';
                tk.Status ='not started';
                tk.Priority = 'high';
                taskListInsert.add(tk);
            }
        }
        if(!taskListInsert.isEmpty()){
            try{
                 insert taskListInsert;
            }catch(exception ex){
                system.debug('error-->'+ex.getMessage());
            }
        }
    }
    
    //Write a trigger such that any non System Admin user must not able to delete an Case
    // show an error as 'You have insufficient access to delete this record'.

    Public static void deleteAction(List<Case>oldCase){
        
        Profile profileName = [select Id, Name from Profile WHERE Name ='System Administator' LIMIT 1];
        
        if(userInfo.getUserId() !=profileName.id){
            for(Case cs :oldCase ){
                cs.addError('You have insufficient access to delete this record');
            }
        }
    }
    
    // Make rollup summary of case on account object
    
    Public static void insertDeleteMethod(List<Case> newCaseList){
        
        set<Id> accOuntIdset = new Set<Id>();
        
        for(Case cs:newCaseList){
            if(cs.AccountId != null){
                accOuntIdset.add(cs.AccountId);
            }
        }
        List<AggregateResult> caseAggerGate = [select AccountId, count(Id) caseCount from 
                                               Case where AccountId IN :accOuntIdset GROUP BY AccountId];
        
        List<Account> accListUpdate = new List<Account>();
        
        for(AggregateResult csearg :caseAggerGate){
            Account acc = new Account();
            acc.Id = (Id)csearg.get('AccountId');
            acc.Case_Count__c = (decimal)csearg.get('caseCount');
            accListUpdate.add(acc);
        }
        if(!accListUpdate.isEmpty()){
            update accListUpdate;
        }
    }
     Public static void upadteMethod(List<Case> newCaseList, Map<Id, Case>caseOldmap){
        
        set<Id> accOuntIdset = new Set<Id>();
        
        for(Case cs:newCaseList){
            if(cs.AccountId != null && cs.AccountId !=caseOldmap.get(cs.Id).AccountId){
                accOuntIdset.add(cs.AccountId);
                accOuntIdset.add(caseOldmap.get(cs.Id).AccountId);
            }
        }
        List<AggregateResult> caseAggerGate = [select AccountId, count(Id) caseCount from 
                                               Case where AccountId IN :accOuntIdset GROUP BY AccountId];
        
        List<Account> accListUpdate = new List<Account>();
        
        for(AggregateResult csearg :caseAggerGate){
            Account acc = new Account();
            acc.Id = (Id)csearg.get('AccountId');
            acc.Case_Count__c = (decimal)csearg.get('caseCount');
            accListUpdate.add(acc);
        }
        if(!accListUpdate.isEmpty()){
            update accListUpdate;
        }
    }
    
    // avoid duplicate case on basis of Email
    
    Public static void duplicateCase(List<Case> newCaseList){
        
        set<String> emailString = new Set<String>();
        
        system.debug(emailString);
        
        for(Case cs:newCaseList){
            
               emailString.add(cs.SuppliedEmail);
            
        }
        for(Case cs : newCaseList){
            if(emailString.Contains(cs.SuppliedEmail)){
                cs.addError('This Email already exists');
            }
        }
    }
   /* 
    When a Case is created on any Account, put the latest case number on the
 	Account in the ‘Latest Case Number’ field.
	*/
    Public static void caseNumberOnAcc(List<Case> caseNewList){
        
       List<Account> accountUpdate=new List<Account>();
        
        for(Case cs:caseNewList){
            if(cs.AccountId != null){
                
                Account acc=new Account();
                acc.Id=cs.AccountId;
                acc.Latest_Case_Number__c=cs.CaseNumber;
                accountUpdate.add(acc);
            }
            if(!accountUpdate.isEmpty()){
                update accountUpdate;
            }
        }
    }
}