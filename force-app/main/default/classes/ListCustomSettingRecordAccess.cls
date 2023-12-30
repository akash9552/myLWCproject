public class ListCustomSettingRecordAccess {
    
    public static void accessRecords(){
        Map<String,kiran__c>customSettingMap =kiran__c.getAll();
        
        system.debug(customSettingMap);
        
        List<kiran__c>customSettingList =kiran__c.getAll().values();
        system.debug(customSettingList);
        
    }
    
}