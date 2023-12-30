public class AggrigateClass {
    
    //Just debugging the AggregateResult List
    
    Public static void aggrigateMethod1(){
        List<AggregateResult> oppList = [SELECT count(id), sum(amount), min(amount), max(amount) FROM Opportunity];
        system.debug(oppList);
    }
    
    public static void aggregateMethod2() {
        
        List<AggregateResult> oppList = [SELECT count(id), sum(amount), min(amount), max(amount) FROM Opportunity];
        
        for(AggregateResult ar : oppList) {
            System.debug('Count is : '+ar.get('expr0'));
            System.debug('Sum Amount is : '+ar.get('expr1'));
            System.debug('Min Amount is : '+ar.get('expr2'));
            System.debug('Max Amount is : '+ar.get('expr3'));
        }
    }
    
    public static void aggregateMethod3() {
        
        List<AggregateResult> oppList = [SELECT count(id) countOfOpp, sum(amount) sumAmount,
                                         min(amount) minAmount, max(amount) maxAmount FROM Opportunity];
        /*
Giving unique name for the aggregate function inside the query like 
countOfOpp, sumAmount, minAmount, maxAmount in the below example

*/
        for(AggregateResult ar : oppList) {
            System.debug('Count is : '+ar.get('countOfOpp'));
            System.debug('Sum Amount is : '+ar.get('sumAmount'));
            System.debug('Min Amount is : '+ar.get('minAmount'));
            System.debug('Max Amount is : '+ar.get('maxAmount'));
        }
    }
    
    
    
}