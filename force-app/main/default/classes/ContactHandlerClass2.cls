public class ContactHandlerClass2 {
    
    public static void avoidDuplication (List<Contact>conNewList){
        
        Set<String> emailSet = new Set<String>();
        Set<String> phoneSet = new Set<String>();
        
        for(Contact con : conNewList){
            
            emailSet.add(con.Email);
            phoneSet.add(con.Phone);
        }
        
        List <Contact> contactlist = [SELECT email,phone FROM Contact WHERE email IN :emailSet OR phone IN :phoneSet];
        
      /* Map<String, Id> emailMap = new Map<String, Id>();
        Map<String, Id> phoneMap = new Map<String, Id>();
        
        for(Contact con :contactlist){
            emailMap.put(con.Email, con.Id);
            phoneMap.put(con.Phone, con.Id);
            
        }
*/
        for(Contact con1 : conNewList){
            
            if(contactlist.size()>0){
                con1.addError('Duplicate Phone and Email found on an existing record');
            }
           /*if(!emailMap.isEmpty() && !phoneMap.isEmpty()){
                con1.addError('Duplicate Phone and Email found on an existing record');
           */ }
        }
    }