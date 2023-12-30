public class SOQLClasstoday {
    public static void mySOQL(string objectName , string fieldName){
        string stringSOQL = 'SELECT '+fieldName+' FROM '+objectName+'';
        system.debug(stringSOQL);
        List<Opportunity> oppList = Database.query(stringSOQL);
        System.debug(oppList);
    }
    public static void dynamicSOQL(String fieldNames, String objectName){
        String dynamic_SOQL_String = 'SELECT '+fieldNames+' FROM '+objectName;
        system.debug(dynamic_SOQL_String);
        List<sObject> accList = Database.query(dynamic_SOQL_String); 
        system.debug(accList);
    }
    public static void myMethod1(){
        list<Account>acclist = [SELECT Id,Name FROM Account WHERE Id NOT IN (SELECT AccountId FROM Contact)];
        system.debug(acclist);
    } 
    public static void myMethod2(){
        list<Account>acclist = [SELECT Id,Name,Countries__c FROM Account WHERE Countries__c INCLUDES('India;Australia')];
        system.debug(acclist);
    }  
}