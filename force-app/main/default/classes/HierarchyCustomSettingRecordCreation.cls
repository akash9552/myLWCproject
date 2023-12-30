public class HierarchyCustomSettingRecordCreation {
    
    public static void defoultLevelRecord(){
        testHierarchyCustomSetting__c DlevelR = new testHierarchyCustomSetting__c();
        DlevelR.RecordName__c = 'created using code';
        DlevelR.Discount__c = 10 ;
        insert DlevelR;
    }
    public static void userLevelRecord(){
        testHierarchyCustomSetting__c UlevelR = new testHierarchyCustomSetting__c();
        UlevelR.RecordName__c = 'created using code1';
        UlevelR.Discount__c = 15 ;
        UlevelR.SetupOwnerId = UserInfo.getUserId();
        insert UlevelR;
    }
    public static void profileLevelRecord(){
        testHierarchyCustomSetting__c PlevelR = new testHierarchyCustomSetting__c();
        PlevelR.RecordName__c = 'created using code2';
        PlevelR.Discount__c = 20 ;
        PlevelR.SetupOwnerId = UserInfo.getProfileId();
        
        insert PlevelR;
    }
}