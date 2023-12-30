@isTest
public class OpportunityTrigger_Test {
    
    @TestSetup
    
    Public static void setupTestData(){
        
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = Date.newInstance(2020, 11, 18);
        insert opp;
        
        Test.setCreatedDate(opp.id, DateTime.newInstance(2020, 02, 02));
        
        Test.startTest();
        Opportunity oppque = [SELECT Id, CreatedDate FROM Opportunity LIMIT 1];
        System.debug(oppque.CreatedDate);
        
        Test.stopTest();
    }
    @isTest
    public static void checkActivebox(){
    }
}