@isTest
public class AccountTrigger_Test47 {
    
    @testSetup
    public static void setupTestData() {
        Test.startTest();
        
        Account acc = new Account();
        acc.Name = 'Test Account45';
        insert acc;
        
        Test.stopTest();
    }
    
    @isTest
    public static void beforeUpdate() {
        Test.startTest();
        
        Account acc = [SELECT Id FROM Account LIMIT 1];
        
        try{
        	update acc;
        } catch(Exception e) {
            System.debug(e.getMessage());
        }
        
        Test.stopTest();
    }
}