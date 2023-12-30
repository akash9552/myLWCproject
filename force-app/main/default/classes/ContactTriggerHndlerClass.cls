public class ContactTriggerHndlerClass {
    
    public static void avoidDuplication (List<Contact>conNewList){
        
        Set <String> emailSet = new Set<String>(); 
        Set <String> phoneSet = new Set<String>();
        
        for(contact con:conNewList){
            emailSet.add(con.email);
            phoneSet.add(con.phone);
        }
        List <Contact> contactList = new List<Contact>();
        
        contactlist = [SELECT email,phone FROM Contact WHERE email IN :emailSet OR phone IN :phoneSet];
        
        for (contact con: conNewList) {
            If (contactList.size() > 0) {
                
                con.email.adderror( 'Duplicate Email Found. Use Another Email.');
                con.phone.adderror( 'duplicate Phone found. Use Another Phone.');
            }
        }
    }
    
    /* write a trigger such that Account shuld have only one primary contact 
     i.e checkbox field on Contact shuld be true for only one Contact of Account if user try to make more 
	than one primary contact then show an error*/
    
    Public static void makeOnePrimaryCon(List<Contact> conList){
        
        set<Id> accId = new set<Id>();
        
        for(Contact con:conList){
            if(con.AccountId != null){
                    accId.add(con.AccountId);
            } 
        }
   
        List<Contact> primaryContact = [select AccountId, Primary_Contact__c from Contact where
                                        Primary_Contact__c= true and AccountId In:accId];
        for(Contact con:conList){
            if(primaryContact.size()>=1){
                con.addError('this Acc contain one primary con');
            }
        }
    }
    
    public static void ensureSinglePrimaryContact(List<Contact> newContacts) {
        Map<Id, Integer> accountToPrimaryContactCount = new Map<Id, Integer>();

        // Count the number of primary contacts per Account
        for (Contact contact : newContacts) {
            if (contact.AccountId != null && contact.Primary_Contact__c) {
                if (!accountToPrimaryContactCount.containsKey(contact.AccountId)) {
                    accountToPrimaryContactCount.put(contact.AccountId, 1);
                } else {
                    accountToPrimaryContactCount.put(contact.AccountId, accountToPrimaryContactCount.get(contact.AccountId) + 1);
                }
            }
        }

        // Check for multiple primary contacts and display an error message
        for (Contact contact : newContacts) {
            if (contact.AccountId != null && contact.Primary_Contact__c) {
                if (accountToPrimaryContactCount.get(contact.AccountId) > 1) {
                    contact.addError('An Account can have only one primary contact.');
                }
            }
        }
    }
}