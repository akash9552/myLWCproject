public class ChildParentClass {
    public static void myMethod(){
        list<Revew__c>revlist = [SELECT Name,Id,Job_Application__r.Name,position__r.Name FROM Revew__c ];
        for(Revew__c rev : revlist){
            system.debug(rev.Id+'===' +rev.position__r.Name+ '=====> ' +rev.Job_Application__r.Name );
        }
    }
     public static void mySOQL(string objectName , string fieldName)
    {
        string stringSOQL = 'SELECT '+fieldName+' FROM Opportunity '+objectName+'';
        system.debug(stringSOQL);
        List<sObject> oppList = Database.query(stringSOQL);
        System.debug(oppList);
    }
}