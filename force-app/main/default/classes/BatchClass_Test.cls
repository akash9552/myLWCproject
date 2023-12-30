@isTest
public class BatchClass_Test {
    
    @testSetup
    
    public static void setupData(){
        Test.startTest();
        
        List<Account>accList = new List<Account>();
        
        for(Integer i = 1; i <= 200; i++){
            Account acc = new Account();
            acc.Name = 'Test Account '+i;
            accList.add(acc);
        }
        insert accList;
        
        Test.stopTest();
    }
    @isTest
    public static void batchClass(){
        Test.startTest();
         Database.executeBatch(new BatchClass(), 50);
        Test.stopTest();
    }
}