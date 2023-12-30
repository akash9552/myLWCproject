@isTest
public class RestClassTestClass {
    @isTest
    public static void respond(){
        Test.startTest();
        
        MockHttpResponseGenerator fakeMock = new MockHttpResponseGenerator();
        test.setMock(HttpCalloutMock.class, fakeMock);
        
        String ipAddress = '192.168.1.1';
        
        IntegrateXMLUtrace req = new IntegrateXMLUtrace();
       
        req.callUtrace(ipAddress);
        Test.StopTest();
    }
	
}