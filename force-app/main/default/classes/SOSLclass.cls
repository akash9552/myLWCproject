public class SOSLclass {
    /*
    public static void mySOSLmethod(){
        list<list<sObject>>sosllist = [FIND 'Rohit' RETURNING Account(Name,Id),Contact(Name,Id),Position__c(Name,Id)];
      //  system.debug(sosllist); 
        list<Account> acclist = sosllist[0];
        list<Contact> conlist = sosllist[1];
        system.debug(acclist);
        system.debug(conlist);
    }
    */
    Public static void jasonSerialize(){
        
        List<Account> parentChild = [SELECT ID, Name, Industry,(SELECT Id, Name, Email FROM Contacts)FROM Account];
       /* 
        System.debug(parentChild);
        
        String jasonData = JSON.serialize(parentChild);
        system.debug(jasonData);
        */
        String jasonData1 = JSON.serializePretty(parentChild);
        system.debug(jasonData1);
    }
}