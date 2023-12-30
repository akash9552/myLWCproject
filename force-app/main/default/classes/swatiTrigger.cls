public class swatiTrigger {
    
    //When a user creates Account record with rating Hot, if Annual revenue is blank set annual revenue to $20000
    
    Public static void setAnnualRev(List<Account> accNewList){
        for(Account acc : accNewList){
            if(acc.Rating =='Hot' && acc.AnnualRevenue == null){
                acc.AnnualRevenue =20000;
            }
        }
    }
    /*  
When an Opportunity gets created, update the highest opportunity amount in the account record.
Create a custom field in Account to store the highest amount of related opportunities.
*/
    
    public static void updtAccHighAmount(List<Opportunity> newOpportunities) {
        
        Set<Id> accountIds = new Set<Id>();
        
        for (Opportunity opp : newOpportunities) {
            if (opp.AccountId != null) {
                accountIds.add(opp.AccountId);
            }
        }
        
        List<Account> accountsToUpdate = new List<Account>();
        
        List<AggregateResult> oppAggr =[SELECT AccountId Id, MAX(Amount) maxAmount FROM Opportunity 
                                        WHERE AccountId IN :accountIds GROUP BY AccountId];
        
        for (AggregateResult result : oppAggr){
            
            Account acc = new Account();
            acc.Id = (Id)(Id)result.get('Id');
            acc.MaxAmountOpp__c = (Decimal)result.get('maxAmount');                                           
            
            accountsToUpdate.add(acc);
        }
        if(!accountsToUpdate.isEmpty()){
            update accountsToUpdate;
        }
    }
}