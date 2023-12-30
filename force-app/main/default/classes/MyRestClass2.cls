@RestResource(urlMapping='/myRestClass2/*')
global class MyRestClass2{
    @httpGet
    global static void getHttpMethod() {
        RestRequest req = RestContext.request;
        
        List<Account> accountList = [SELECT Id, Name, (SELECT Id, Name FROM Contacts)  FROM Account];
        
        List<AccountWrapper> accountWrapperList = new List<AccountWrapper>();
        
        for(Account acc : accountList) {
            AccountWrapper accWrapper = new AccountWrapper();
            accWrapper.AccountId = acc.Id;
            accWrapper.FullName = acc.Name;
            
            for(Contact con : acc.Contacts) {
                ContactWrapper conWrapper = new ContactWrapper();
                conWrapper.ContactId = con.Id;
                conWrapper.Name = con.Name;
                
                accWrapper.contactDetails.add(conWrapper);
            }
            
            accountWrapperList.add(accWrapper);
        }
        
        try {
            
            RestResponse res = RestContext.response;
            String JSONBody = JSON.serialize(accountWrapperList);
            
            res.responseBody = Blob.valueOf(JSONBody);
            res.statusCode = 200;
            
        } catch(Exception e) {
            
            RestResponse res = RestContext.response;
            String JSONBody = JSON.serialize(e.getMessage());
            
            res.responseBody = Blob.valueOf(JSONBody);
            res.statusCode = 404;
        }
        
    }
    
    public class AccountWrapper {
        
        Id AccountId;
        String FullName;
        List<ContactWrapper> contactDetails = new List<ContactWrapper>();
    }
    
    public class ContactWrapper {
        
        Id ContactId;
        String Name;
    }
    
    
}