global class BatchClassforCurrancyC implements Database.Batchable<sObject>, Database.AllowsCallouts{
    
    global Database.QueryLocator start(Database.BatchableContext BC){
        string query = 'select Id, Amount, INR_Amount__c from Opportunity';
       return Database.getQueryLocator(query);
    }
    global void execute (Database.BatchableContext bc, List<Opportunity> oppList){
        
        Http p = new Http();
        string endPoint ='http://apilayer.net/api/live?access_key=28252f50ce28e16e999e70773bb9dab4& source=USD&currencies=INR&format=1';
        HttpRequest req = new HttpRequest();
        req.setEndpoint(endPoint);
        req.setMethod('GET');
        
        HttpResponse res = p.send(req);
        
        string result = res.getBody();
        system.JSONParser jp = JSON.createParser(result);
        
        Decimal amt;
        system.debug(amt);
        while(jp.nextToken() !=null){
            if(jp.getText()=='USDINR'){
                jp.nextToken();
                amt =(Decimal)jp.getDecimalValue();
            }
        }

        List<Opportunity> oppUpdate = new List<Opportunity>();
        
        for(Opportunity opp :oppList){
            if(opp.Amount != null){
                opp.INR_Amount__c = 'Rs'+(amt*opp.Amount);
                oppUpdate.add(opp);
            }
        }
        if(!oppUpdate.isEmpty()){
            update oppUpdate;
        }
    }
    global void finish (Database.BatchableContext bc){
        
    }
}