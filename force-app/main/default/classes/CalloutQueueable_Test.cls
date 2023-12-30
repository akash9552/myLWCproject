@isTest
public class CalloutQueueable_Test {

    @isTest
    public static void calloutQueueable() {
        Test.startTest();
        
        Test.setMock(HttpCalloutMock.class, new CalloutMock1());
        System.enqueueJob(new CalloutQueueable());
        
        Test.stopTest();
    }
}