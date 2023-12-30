public class batchClassAssignAccToCon implements Database.Batchable<sObject>,Database.Stateful {
	/* using batch apex update contact in such a way that if contact has no Account and same phone numer's 
	 Account is availabelthen assign that account to that contact
	 */
    public Database.queryLocator start (Database.BatchableContext bc){
        string query ='select Id, Phone from Contact where Phone != null';
         system.debug(query);
        return Database.getQueryLocator(query);
    }
    public void execute(Database.BatchableContext bc, List<Contact> conList){
        
        Map<string, Id> accMap= new Map<String, Id>();
        system.debug(accMap);
        
        set<String>phonestring = new set<String>();
        system.debug(phonestring);
        
        for(Contact con:conList){
            if(con.Phone != null){
                 phonestring.add(con.Phone);
            }
        }
        List<Account> accList = [select Id, Phone from Account where Phone In:phonestring];
                                 
        for(Account acc :accList){
            accMap.put(acc.Phone, acc.Id);
        }
        List<Contact> conUpdate = new List<Contact>();
           system.debug(conUpdate);
        for(Contact con : conList){
            if(accMap.containsKey(con.Phone)){
                con.AccountId = accMap.get(con.Phone);
                conUpdate.add(con);
            }
        }
        if(!conUpdate.isEmpty()){
            update conUpdate;
        }
        
    }
    public void finish (Database.BatchableContext bc){
        
    }
}