public class ConHandalerClass14 {
    
    public static void preventDuplicateRecords(List<Contact> conNewList) {
        
        Set<String> emailSet = new Set<String>();
        Set<String> phoneSet = new Set<String>();
        
        for(Contact con : conNewList) {
            emailSet.add(con.Email);
            phoneSet.add(con.Phone);
        }
        
        List<Contact> existingContactsSameInfo = [SELECT Id, Email, Phone FROM Contact WHERE Email IN : emailSet OR Phone IN : phoneSet];
        
        Map<String, Id> emailMap = new Map<String, Id>();
        Map<String, Id> phoneMap = new Map<String, Id>();
        
        for(Contact con : existingContactsSameInfo) {
            emailMap.put(con.Email, con.Id);
            phoneMap.put(con.Phone, con.Id);
        }
        
        for(Contact con : conNewList) {
            
            if(con.Phone != null && con.Email != null) {
                if(phoneMap.containsKey(con.phone) != phoneMap.containsKey(con.Phone)) {
                    if(emailMap.get(con.Email) != emailMap.get(con.Email)) {
                        con.addError(Contact.phone, 'Duplicate Phone  found on an existing record');
                        con.addError(Contact.Email ,'Dupicate Email found on an existing record');
                    }
                }
            }
        }
    }
}