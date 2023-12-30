public class ListCustomSettingApexClass {
    public static void createRecords(){
        kiran__c tc = new kiran__c();
        tc.Name = 'created from code';

        insert tc;
        
    } 
}