public with sharing class ContactController {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact>getContacts(){
       
        return [select Id, LastName, Email, Phone from Contact where Email != null AND Phone != null];
    }
    
    @AuraEnabled
    public static void updateAccounts(Object data) {
        List <Account> accsForUpdate = (List<Account>)JSON.deserialize(JSON.serialize(data), List<Account>.class);
            // using this we deserialize data 
        update accsForUpdate;
    }
}