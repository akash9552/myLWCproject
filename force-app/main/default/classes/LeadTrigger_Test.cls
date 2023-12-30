@isTest

public class LeadTrigger_Test {
   @testSetup
    public static void setupTestData() {
        Test.startTest();
        
        List<Lead> leadToInsert = new List<Lead>();
        
        for(Integer i=0; i<200; i++) {
            Lead l = new Lead();
            l.LastName = 'Test Last Name '+i;
            l.Company = 'Test Company';
            l.Status = 'Open - Not Contacted';
            
            leadToInsert.add(l);
        }
        
        insert leadToInsert;
        
        Test.stopTest();
    }
    
    @isTest
    public static void insertDuplicateLead() {
        //Positive
        List<Lead> leadList = [SELECT Id, Name FROM Lead];
        System.assertEquals(400, leadList.size());
    }

}