public class CustomMetadataClass {

    public static void getAllMethod1(){ 
        
        //getAll():-
        
        Map<String,Custom_metadata__mdt>cmdataMap = Custom_metadata__mdt.getALL();
        
        system.debug(cmdataMap);
        
        system.debug(cmdataMap.values());
    }
    public static void getAllMethod2(){
        
        // getInstance(recordId)
        
        Custom_metadata__mdt cmDataRecords = Custom_metadata__mdt.getInstance('');
        system.debug(cmDataRecords);
        // This give you null 
        
        List<Custom_metadata__mdt> cmDataRecords2 = [SELECT Id, DeveloperName FROM Custom_metadata__mdt];
        
        for(Custom_metadata__mdt records : cmDataRecords2){
            
            Custom_metadata__mdt RecordsData = Custom_metadata__mdt.getInstance(records.Id);
            system.debug(RecordsData);
        }
    }
    public static void getAllMethod3(){
        
        //getInstance(developerName)
        
        List<Custom_metadata__mdt> cmDataRecords2 = [SELECT Id, DeveloperName FROM Custom_metadata__mdt];
        
        for(Custom_metadata__mdt records : cmDataRecords2){
            
            Custom_metadata__mdt RecordsData = Custom_metadata__mdt.getInstance(records.DeveloperName);
            system.debug(RecordsData);
        }
        
    }
}