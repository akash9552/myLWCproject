public class SOQLinMAP {
    public static void myMethod(){
        MAP<Id,Account>accMap = new MAP<Id,Account>([SELECT Id,Name,Budget__c,Site,Phone FROM Account]);
        system.debug(accMap);
    }  
    //  LIKE method with '%' and '__'
    public static void myMethod1(){
        List<Account>acclist = [SELECT Id,Name FROM Account WHERE Name LIKE '%ROHIT%'];
        system.debug(acclist);
    }
    public static void myMethod2(){
        list<position__c>polist = [SELECT Id,Name FROM position__c WHERE Name LIKE '%Developer'];
        system.debug(polist);
    }  
    public static void myMethod3(){
        List<Opportunity>opplist = [SELECT Id,Name FROM Opportunity WHERE Name LIKE '_____%'];
        system.debug(opplist);
    }
}