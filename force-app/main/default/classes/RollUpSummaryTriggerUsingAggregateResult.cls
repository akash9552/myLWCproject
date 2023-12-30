public class RollUpSummaryTriggerUsingAggregateResult {

    Public static void oppAfterInsert(List<Opportunity>oppNewList){
       Set<Id> accountIdset = new Set<Id>();
        for(Opportunity opp:oppNewList){
            if(opp.AccountId != null){
                accountIdset.add(opp.AccountId);
            }
        }
        List<Account> accTOupdate = new List<Account>();
        
        List<AggregateResult> oppList = [select AccountId,count(Id) countOfOpp from Opportunity
                                         where AccountID IN :accountIdset GROUP BY AccountId];
        for(AggregateResult aggr :oppList){
            
            Account acc = new Account();
            acc.Id = (Id)aggr.get('AccountId');
            acc.Opportunity_count__c = (Decimal)aggr.get('countOfOpp');
            accTOupdate.add(acc);
        }
        if(!accTOupdate.isEmpty()){
            update accTOupdate;
        }
    }
}