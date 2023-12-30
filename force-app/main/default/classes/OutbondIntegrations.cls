public class OutbondIntegrations {
   /* 
    // outbound integration or call to Indain Post if we give pin code they give plces name of that pincode
    Public static void indianPostalCallOut(string enterPincode){
        
        string endpoint ='https://api.postalpincode.in/pincode/'+enterPincode; 	  // using this we set end point 
      
        Http p = new Http(); 	 						// using this we create a http protocall
       
        HttpRequest request = new HttpRequest();		// we create a request
        request.setEndpoint(endpoint);		 			//set end point
        request.setMethod('GET');						// set GET method
        
        HttpResponse response = p.Send(request);		// we send an request using http protocall and get response back
        system.debug(response);
        
        string body = response.getBody();				// that response we store in this body
        system.debug(body);
        
        //respose we get in JSON format we need to deserialize
        system.JSONParser jp = JSON.createParser(body);
        
        system.debug(jp);
        
        List<String> Codeplaces = new List<String>();
        
        while (jp.nextToken() != null){
            if(jp.getText() == 'Name'){
                jp.nextToken();
               Codeplaces.add(jp.getText());
            }
        }
        for( string plse :Codeplaces){
            system.debug(plse);
        }
    }
	
    // outbound integration or call to Utrace if we give ip adress they give details
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
    */
    //outbound integration or call to FreeCurrancy API they give free Currency conversion
    Public static void callFreeCurrancyApi(){
        
        string endPoint ='https://api.freecurrencyapi.com/v1/latest?apikey=J4l7bJ7TGmmq1pSlcAun6yriVG6AMvgoyT8Edp1h&base_currency=USD&currencies=INR,USD';
        Http p = new Http();
        httpRequest request = new httpRequest();
        request.setEndpoint(endPoint);
        request.setMethod('GET');
        
        httpResponse response = p.send(request);
        system.debug(response);
        string body = response.getBody();
        system.debug(body);
        
         Map<String, Object> ResponseMap = (Map<String, Object>)JSON.deserializeUntyped(response.getBody());
        Map<String, Object> DataMap = (Map<String, Object>)ResponseMap.get('data');
        
        System.debug('DataMap : '+DataMap);
        
        Decimal INR = (Decimal)DataMap.get('INR');
        Decimal USD = (Decimal)DataMap.get('USD');
        
        System.debug('INR : '+INR);
        System.debug('USD : '+USD);

    }
}