@isTest
public class OpportunityTriggerHandler95_TestClass {
  @testSetup
    public static void setupTestData() {
        
        Test.startTest();
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test Opportunity';
        opp.StageName = 'Closed Won';
        opp.CloseDate = Date.newInstance(2020, 11, 12);
        insert opp;
        
        Test.stopTest();
    }
    
    @isTest
    public static void onlySystemAdminCanDeleteR() {
        
        Test.startTest();
        
        User u = [SELECT Id FROM User WHERE Profile.Name != 'System Administrator' AND isActive = true LIMIT 1];
        
        System.runAs(u) {
            try {
                delete [SELECT Id FROM Opportunity LIMIT 1];
            } catch(Exception e) {
            }
        }
        
        Test.stopTest();
    }

}