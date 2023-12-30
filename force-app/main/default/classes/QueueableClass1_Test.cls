@isTest
public class QueueableClass1_Test {
    
    @testSetup
    public static void setupTestData() {
        Test.startTest();
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test123';
        opp.CloseDate = System.today();
        opp.StageName = 'Closed Won';
        insert opp;
        
        Test.stopTest();

    }
      @isTest
    public static void QueueableClass1() {
        Test.startTest();
        
        System.enqueueJob(new QueueableClass1());
        
        Test.stopTest();
        
    }
}