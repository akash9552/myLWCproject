public class AggrigateFlowClass {
    
     @InvocableMethod
    public static List<outputClass> calculateRollUp(List<String> accId) {
        String accParentId = accId[0];
        
        AggregateResult oppAggregateResult = [SELECT count(Id) countOfOpp, 
                                              sum(amount) sumAmount, min(amount) minAmount, 
                                              max(amount) maxAmount, avg(amount) avgAmount
                                              FROM Opportunity WHERE AccountId = :accParentId
                                              GROUP BY AccountId];
        
        List<outputClass> outputList = new List<outputClass>();
        
        outputClass outputObj = new outputClass();
        outputObj.count = (Integer)oppAggregateResult.get('countOfOpp');
        outputObj.sum = (Decimal)oppAggregateResult.get('sumAmount');
        outputObj.min = (Decimal)oppAggregateResult.get('minAmount');
        outputObj.max = (Decimal)oppAggregateResult.get('maxAmount');
        outputObj.avg = (Decimal)oppAggregateResult.get('avgAmount');
        
        outputList.add(outputObj);
        
        return outputList;
        
    }
    
    public class outputClass {
        
        @InvocableVariable
        public Integer count;
        
        @InvocableVariable
        public Decimal sum;
        
        @InvocableVariable
        public Decimal min;
        
        @InvocableVariable
        public Decimal max;
        
        @InvocableVariable
        public Decimal avg;
    }
}