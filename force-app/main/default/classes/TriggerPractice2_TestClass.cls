@isTest
public class TriggerPractice2_TestClass {
    
    @testSetup 
    public static void testsetUpMethod(){
         Test.startTest();
        Account acc1 = new Account();
        acc1.Name ='test';
        insert acc1;
         Test.stopTest();
        
    }
    @isTest
    Public static void chechBoxTrue(){
        Test.startTest();
       Account acc = [select ID, IsActive__c from Account limit 1];
        acc.IsActive__c = true;
        update acc;
        System.assert(acc.IsActive__c = true);
        System.assertEquals(True, acc.IsActive__c); 
        Test.stopTest();
        
    }  
    
}