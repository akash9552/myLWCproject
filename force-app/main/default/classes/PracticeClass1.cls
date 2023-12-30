public class PracticeClass1 {
    
    Public static void soqlMethod(string fieldName, string ObjectName){
        
        string dynamicsoql ='select '+fieldName+' from '+ObjectName+'';
        
        system.debug(dynamicsoql);
        
        List<sObject> sobjectList = database.query(dynamicsoql);
        
        system.debug(sobjectList.size());
    }
    
    
    Public static void createMap(){
        
        List<Contact> conList =[select Id, AccountId, Name from Contact where AccountId != null];
        
        Map<Id, List<Contact>> accIdConMap = new Map<Id, List<Contact>>();
        
        for(Contact con : conList){
            if(accIdConMap.containsKey(con.AccountId)){
                accIdConMap.get(con.AccountId).add(con);
            }else{
                accIdConMap.put(con.AccountId, new List<Contact>{con});
            }
        }
        system.debug(accIdConMap);
    }
}