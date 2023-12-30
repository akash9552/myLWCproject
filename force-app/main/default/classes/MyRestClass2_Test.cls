@isTest
public class MyRestClass2_Test {
    
    @TestSetup
    public static void setupData(){
        
        Test.startTest();
        
        Account acc = new Account();
        acc.Name = 'Test account';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'Test contact ';
        con.AccountId = acc.Id;
        insert con;
    }
	@istest
    
    public static void getHttpMethod(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        req.requestURI ='/services/apexrest/myRestClass2/';
        req.httpMethod = 'GET';
        
        RestContext.request = req;
        RestContext.response = res;
        
        
        Test.startTest();
        MyRestClass2.getHttpMethod();
        Test.stopTest();
    }
}