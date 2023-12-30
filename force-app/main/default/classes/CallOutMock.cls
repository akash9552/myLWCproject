@isTest
public class CallOutMock implements HttpCallOutMock {
    
    public HttpResponse respond (HttpRequest req){
        
        HttpResponse res = new HttpResponse();
       
        res.setStatusCode (200);
        res.setBody ('Test HSON Body');
        
        return res;
    }
}