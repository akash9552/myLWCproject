@RestResource(urlMapping='/myRestClass3/*')

global class MyRestClass3 {
    @httpPost
    global static void createAccountData() {
        
        try {
            RestRequest req = RestContext.request;
            
            Blob JSONBlob = req.requestBody;
            String JSONString = JSONBlob.toString();
            
            System.debug('JSONString : '+JSONString);
            
            List<Account> accountToInsert = (List<Account>)JSON.deserialize(JSONString, List<Account>.class);
            insert accountToInsert;
            
        } catch(Exception e) {
            RestResponse res = RestContext.response;
            String JSONBody = JSON.serialize(e.getMessage());
            
            res.responseBody = Blob.valueOf(JSONBody);
            res.statusCode = 404;

        }
    }
}