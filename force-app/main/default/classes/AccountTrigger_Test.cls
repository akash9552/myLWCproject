@isTest()
public class AccountTrigger_Test {
  
    @testSetup
    public static void myMethod(){
        Test.startTest();
        
        Account acc1 = new Account();
        acc1.Name = 'Acc tested by AKash 12';
        acc1.AccountNumber = '9552229822';
        insert acc1;
        
        Test.stopTest();
    }
    @isTest
    public static void beforeUpdateMethod(){
        Test.startTest();
        
        Account acc = [SELECT Id,Rating FROM Account LIMIT 1];
	delete acc;
        Test.stopTest();
         
    }
     @isTest
    public static void beforeUpdateMethod2(){
        Test.startTest();
        
        Account acc = [SELECT Id, Name FROM Account LIMIT 1];
        system.debug(acc.get('Name'));

        Test.stopTest();
         
    }
}