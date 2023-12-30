public class SOQLDynamic {
    public static void myMethod(String fieldName, String objectName){
        
        String stringQuery = 'SELECT '+fieldName+'FROM '+objectName;
        System.debug(stringQuery);
        
        List<sObject> accList = Database.query(stringQuery);       
        System.debug(accList);
    }
    public static void myMethod1(String fieldName){
        string querystring = 'SELECT Id, Name, '+fieldName+' FROM Opportunity';
        system.debug(querystring);
        List<Opportunity>opplist = Database.query(querystring);
        system.debug(opplist);
    }
}