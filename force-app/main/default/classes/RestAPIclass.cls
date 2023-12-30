@RestResource(urlMapping='/mydemoRestClass/*')
Global class RestAPIclass {

    /*
    @httpGet
    global static void myHttpgetMethod(){
        RestRequest req = RestContext.request;
        //using this pre define method in salesforce we handle request wchich come from postman/external system to salesforce
        
        string accountIdWithURL= req.requestURI;
        system.debug(accountIdWithURL);
        //this give hole url
        
        string accountId =accountIdWithURL.substring(accountIdWithURL.lastIndexOf('/')+1);
        system.debug(accountId);
        //this give only accountId
        
        List<Contact>conList = [select id, name from contact where AccountId =:accountId];
        try{
            RestResponse res = RestContext.response;
            //using this predefine method in salesforce we give the response to external system
            
            String JSONBody =JSON.serialize(conList);
            // using this JSON.serialize we convert normal data into JSON form
            
            res.responseBody = Blob.valueOf(JSONBody);
            // using this we send data to external system in Blob form/ binary form
            res.statusCode =200;
            
        }catch(Exception e){
            RestResponse res = RestContext.response;
            
            String JSONBody =JSON.serialize(e.getMessage());
            
            res.responseBody = Blob.valueOf(JSONBody);
            res.statusCode =404;
            //if try block fail then we got error messege using this catch block
        }
    }
*/
    @httpPost
    global static void createAccountRecordUsingPostman(){
        try{
            RestRequest req = RestContext.request;
            // This is used to handel requet which is come from postman
            
            Blob JSONBlob = req.requestBody;
            // The request comes in blob form we are not able to insert this now we have to convert this blob in string
            
            string JSONstring =JSONBlob.toString();
            
            // using this we convert the jason blob in string using this we got data in json form
 
            system.debug(JSONstring);
            
            //now if we want to insert data in your org we have to deSerialize this data
            
            List<Account>ccountToInsert= (List<Account>)JSON.deserialize(JSONstring, List<Account>.class);
            
            //here we .class becouse Account is an inbuilt class in salesforce
            //(List<Account>) using this make a type cast so that they give list from that class
            
            insert ccountToInsert;
        }catch(Exception e){
            
        }
    }
}