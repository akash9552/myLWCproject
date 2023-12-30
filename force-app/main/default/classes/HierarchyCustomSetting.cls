public class HierarchyCustomSetting {
    
    public static void accessHRecord(){
        
        testHierarchyCustomSetting__c hRecords = testHierarchyCustomSetting__c.getOrgDefaults();
        system.debug(hRecords);
    }

}