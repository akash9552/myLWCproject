@isTest
public class CalloutQueueableClass_Test {
    
    @isTest
    
    public static void calloutQueueable(){
        Test.startTest();
        
        Test.setMock(HttpCallOutMock.Class, new CallOutMock());
            
        System.enqueueJob(new CalloutQueueableClass());
        
        Test.stopTest();
    }

}