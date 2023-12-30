public class priyasoftsolutions {
    
    // write a trigger such taht when account phone update update samr number in all contact record
    // 
    Public  static void updateContact(List<Account> accList, Map<Id, Account> accOldMap){
        Map<Id, Account> accMap = new Map<Id,Account>();
        
        for(Account acc: accList){
            
            if(acc.Phone != null && acc.Phone !=accOldMap.get(acc.id).Phone){
                accMap.put(acc.Id, acc);
            }
        }
        List<Contact> conList = [select AccountId, Phone from Contact where AccountId IN :accMap.keySet()];
        List<Contact> conUpdate = new List<Contact>();
        
        for(Contact con: conList){
            con.Phone = accMap.get(con.AccountId).Phone;
            conUpdate.add(con);
        }
        if(!conUpdate.isEmpty()){
            update conUpdate;
        }
    }

}