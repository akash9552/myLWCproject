public class FutureCallout {

    @future(callout=true)
    /*
    public static void callExternalWebservice() {
        
        Http h = new Http();
        
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://spoonacular.com/food-api/docs#Ingredient-Search');
        req.setMethod('GET');
        
        HttpResponse res = h.send(req);
        
        System.debug('Status Code : '+res.getStatusCode());
        System.debug('Body : '+res.getBody());
    }
*/
    
     public static void callUtrace(string ipAdderess){
        string endpoint = 'http://xml.utrace.de/?query='+ipAdderess;
        http p = new http();
        httpRequest request = new httpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        httpResponse response = p.send(request);
        system.debug(response);
       string body = response.getBody();
        system.debug(body);
    }
}