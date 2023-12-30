public class IntegrateXMLUtrace {
   
    public void callUtrace(string ipAdderess){
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