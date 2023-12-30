@RestResource(urlMapping='/myRestClass/*')
global class MyRestClass {

    @httpPost
    global static void createAccountData() {
        try {
            RestRequest req = RestContext.request;
            
            Blob JSONBlob = req.requestBody;
            String JSONString = JSONBlob.toString();

            List<AccountWrapper> accountWrapperList = (List<AccountWrapper>)JSON.deserialize(JSONString, List<AccountWrapper>.class);
			List<Account> accToInsert = new List<Account>();
            
            for(AccountWrapper accWrapperObj : accountWrapperList) {
                Account acc = new Account();
                acc.Name = accWrapperObj.FullName;
                acc.Email__c = accWrapperObj.Email;
                acc.SLAExpirationDate__c = Date.newInstance(accWrapperObj.SLADate.year, accWrapperObj.SLADate.month, accWrapperObj.SLADate.day);
                
                accToInsert.add(acc);
            }
            
            insert accToInsert;
        }catch(Exception e) {
            RestResponse res = RestContext.response;
            String JSONBody = JSON.serialize(e.getMessage());
            
            res.responseBody = Blob.valueOf(JSONBody);
            res.statusCode = 404;
        }
    }
    public class AccountWrapper {
        String FullName;
        String Email;
        DateWrapper SLADate;
    }
    
    public class DateWrapper {
        Integer year;
        Integer day;
        Integer month;
    }
}