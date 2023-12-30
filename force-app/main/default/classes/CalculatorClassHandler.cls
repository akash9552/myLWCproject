public class CalculatorClassHandler {
    
    public static void calMethod(list<Calculator__c>calculaterList){
        
        for(Calculator__c calist :calculaterList){
            
            if(calist.Number_1__c == null && calist.Number_2__c == null){
                
                calist.addError('Number1 and number 2 fields are requird');
                
            }
            else{
                calist.Addition__c = calist.Number_1__c + calist.Number_2__c;
                
                calist.Subtraction__c = calist.Number_1__c - calist.Number_2__c;
                
                calist.Division__c = calist.Number_1__c / calist.Number_2__c;
                
                calist.Multiplication__c = calist.Number_1__c * calist.Number_2__c;

            }
        }
        
    }

}