public class MockPracticeClass {
    
    public static void myMethod(){
        list<position__c>polist = [SELECT Id, Name FROM position__c];
        for(position__c  pos : polist){
            System.debug(pos);
        }
    }
    public static void myMethod1(){
        list<position__c>positionList = new list<position__c>([SELECT Id, Name FROM position__c]);
        for(position__c  pos1 : positionList){
            System.debug(pos1);
        }
    }
    public static void myMethod2(){
        list<position__c>polist = [SELECT Id,Name, Max_pay__c FROM position__c WHERE Max_pay__c >500000 
                                   ORDER BY Max_pay__c DESC];
        for(position__c  pos : polist){
            System.debug(pos);
        }
     }
    public static void myMethod3(id PositionID){
        list<position__c>polist = [SELECT Id, Name FROM position__c WHERE id = :PositionID]; 
        system.debug(polist);
    }
    public static void myMethod4(){
        
        list<Contact>parentToChild = [SELECT Id, Name, Account.id, Account.Name, Account.Phone 
                                      FROM Contact WHERE Phone !=Null ];
           //List<Contact> conList = [SELECT Id, Account.Rating, Account.Name, Account.Phone FROM Contact];

        for(Contact con :parentToChild ){
            system.debug(con);
        }
    }
}