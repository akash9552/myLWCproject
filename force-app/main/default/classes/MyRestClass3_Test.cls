@isTest
public class MyRestClass3_Test {

     @isTest

    public static void httpPostTestMethod(){
        RestRequest req = new RestRequest();
        RestResponse res = new RestResponse();
        
        String JSONBody = '[{"Name" : "Postman Record 1","Address__c" : "Pune","Age__c" : 25},{"Name" : "Postman Record 2","Address__c" : "Mumbai","Age__c" : 32}]';
        
        req.requestURI = '/services/apexrest/myRestClass/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSONBody);
        
        RestContext.request = req;
        
        Test.startTest();
        MyRestClass3.createAccountData();
        
       JSONBody = '';
        
        req.requestURI = '/services/apexrest/myRestClass3/';
        req.httpMethod = 'POST';
        req.requestBody = Blob.valueOf(JSONBody);
        
        RestContext.request = req;
        RestContext.response = res;
        
        MyRestClass3.createAccountData();
        Test.stopTest();

        
        
    }
    
}