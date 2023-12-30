public class accountTriggerHandler4 {
    // if isActive checkbox is false on Account record of account object then delete its child contacts
    public static void deleteChaildCon(List<Account>accNewList){
        
        //Set<ID>accid = new Set<ID>();
        
        List<Contact>contoupdate = new List<Contact>();
        
        for(Account acc: accNewList){
            if(acc.Phone != null){
                for(Contact con : acc.Contacts) {
                    con.Phone = acc.Phone;
                    contoupdate.add(con);
                }
               // accid.add(acc.Id);
            }
        }
        //List<Contact>conlist = [SELECT Id FROM Contact WHERE AccountId =:accid];
        //update conlist;
        if(!contoupdate.isEmpty()){
            update contoupdate;
        }
    }
    
}