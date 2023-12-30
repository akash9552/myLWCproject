public class contactClassCallBatch {
    
    public static void contactMethod (List<Contact> conNewList, Map<Id, Contact> conOldMap){
        
        set<string> phoneSet = new set<String>();
        
        List<Account> accList = [select Id, Phone from Account];
        
        for(Account acc : accList){
            if(acc.Phone != null){
                phoneSet.add(acc.Phone);
            }
        }
        List<Contact> conList = [select Id, Phone, AccountId from Contact where Phone IN :phoneSet AND Id In:conNewList];
        
        Map<Id, Contact> comMap = new Map<Id ,Contact>();
        
        for(Contact con :conList){
            if(con.AccountId == null){
                if(con.phone != conOldMap.get(con.Id).Phone){
                     comMap.put(con.Id, con);
                }
            }
        }
        
        if(!comMap.isEmpty()){
           Database.executeBatch(new AssignChildBatchClass(comMap));
        }
    }

}