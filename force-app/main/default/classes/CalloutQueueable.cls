public class CalloutQueueable implements Queueable, Database.allowsCallouts{
    
    public void execute(QueueableContext qc) {
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('http://restapi.adequateshop.com/api/Tourist?page=2');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        
        System.debug('Status Code : '+res.getStatusCode());
        System.debug('Body : '+res.getBody());
        
    }
}