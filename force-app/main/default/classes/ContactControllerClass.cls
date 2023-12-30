public class ContactControllerClass {
    
    @AuraEnabled(cacheable=true)
    
    public static List<Contact> conList(){
        return[select Id, Name, Email from Contact where Email != null];
    }

    public static void mySoslQuery(){
        List<List<sObject>> soslList=[FIND'Akash'Returning Account];
      //  List<Account>accList=soslList[0];
        system.debug(soslList);
    }
}