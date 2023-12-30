@isTest
public class RollUpSummaryHandler405_TestClass {
    
    @testSetup
    Public static void setUpdata(){
        Test.startTest();
            
        Contact con = new Contact();
        con.LastName = 'Kirshna';
        insert con;
        
        Account acc = new Account();
        acc.Name = 'Radha';
        insert acc;
        
        Test.stopTest();
    }
    
    @isTest
    Public static void afterInsertContactCount(){
        Test.startTest();
        List<Contact>conList = [SELECT Id,Name FROM Contact LIMIT1];
        
        RollUpSummaryHandler405.afterInsertContactCount(conList);
        
        //List<Account>acclist = [SELECT Id,Name FROM Account Limit 1];
         //Update acclist;
        
        Test.stopTest();
    }
    
   @isTest
    Public static void afterUpdateContactCount(){
        Test.startTest();
        List<Contact>conList = [SELECT Id,Name FROM Contact LIMIT1];
        
        Map<Id,Contact>conMap =new Map<Id,Contact>([SELECT Id,Name FROM Contact LIMIT1]);
        
        RollUpSummaryHandler405.afterUpdateContactCount(conList,conMap);
        
       // List<Account>acclist = [SELECT Id,Name FROM Account Limit 1];
        // Update acclist;
        
        Test.stopTest();
    }
    @isTest
    Public static void afterDeleteContactCount(){
        Test.startTest();
        List<Contact>conList = [SELECT Id,Name FROM Contact LIMIT1];
        
        RollUpSummaryHandler405.afterDeleteContactCount(conList);
        
       // List<Account>acclist = [SELECT Id,Name FROM Account Limit 1];
        // Update acclist;
        
        Test.stopTest();
    }

}