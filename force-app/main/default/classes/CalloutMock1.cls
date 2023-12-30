@isTest
public class CalloutMock1 implements HttpCalloutMock{

    public HttpResponse respond(HttpRequest req) {
        
        HttpResponse res = new HttpResponse();
        
        res.setStatusCode(200);
        res.setBody('Test JSON Body');
        
        return res;
    }
}