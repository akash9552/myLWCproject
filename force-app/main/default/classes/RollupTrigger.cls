public class RollupTrigger {

    Public static void insertDeleteUndeleteMethod(List<Case> caseList){
          set<Id> accIdSet = new set<Id>();
        
        for(Case cs:caseList){
            if(cs.AccountId != null){
                accIdSet.add(cs.AccountId);
            }
        }
        List<AggregateResult> caseAggrquery = [select AccountId, count(Id) caseCount from Case where AccountId
                                               IN:accIdSet GROUP BY AccountId];
        
        List<Account> accUpdate =new List<Account>();
        
        for(AggregateResult caseAggr:caseAggrquery){
            Account acc = new Account();
            acc.Id = (Id)caseAggr.get('AccountId');
            acc.Case_Count__c =(decimal)caseAggr.get('caseCount');
            accUpdate.add(acc);
        }
        if(!accUpdate.isEmpty()){
            update accUpdate;
        }
    }
  Public static void updateMethod(List<Case> caseList, Map<Id, Case> caseOldMap){
          set<Id> accIdSet = new set<Id>();
        
        for(Case cs:caseList){
            if(cs.AccountId != null && cs.AccountId != caseOldMap.get(cs.Id).AccountId){
                accIdSet.add(cs.AccountId);
                accIdSet.add(caseOldMap.get(cs.Id).AccountId);
            }
        }
        List<AggregateResult> caseAggrquery = [select AccountId, count(Id) caseCount from Case where AccountId
                                               IN:accIdSet GROUP BY AccountId];
        
        List<Account> accUpdate =new List<Account>();
        
        for(AggregateResult caseAggr:caseAggrquery){
            Account acc = new Account();
            acc.Id = (Id)caseAggr.get('AccountId');
            acc.Case_Count__c =(decimal)caseAggr.get('caseCount');
            accUpdate.add(acc);
        }
        if(!accUpdate.isEmpty()){
            update accUpdate;
        }
    }
    
    
    // avoid duplicate based on email
    // 
    public static void avoidduplicateCase(List<Case> acseNewList){
        
        set<String> eamilset = new set<String>();
        for(Case cs :acseNewList){
            if(cs.Email__c != null){
                eamilset.add(cs.Email__c);
            }
        }
        List<Case> caseRecord = [select Id, Email__c from Case where Email__c In:eamilset];
        
        for(Case cs :acseNewList){
            if(caseRecord.size()>0){
                cs.addError('this email already exists');
            }
        }
    }
    
}