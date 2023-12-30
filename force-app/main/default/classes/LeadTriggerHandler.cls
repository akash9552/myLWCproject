public class LeadTriggerHandler {
	/*
    public static Boolean executeTrigger = true;
    
    public static void insertDuplicateLead(List<Lead> leadNewList) {
        
        List<Lead> leadToInsert = new List<Lead>();
        
        for(Lead ld : leadNewList) {
                        
            Lead l = new Lead();
            l.LastName = ld.LastName;
            l.Company = ld.Company;
            l.Status = ld.Status;
            
            leadToInsert.add(l);
        }
        
        if(!leadToInsert.isEmpty()) {
            insert leadToInsert;
        }
    }
*/
     public static void myMethod(List<Lead>leadOldList){
        
        Profile systemAdminProfile = [SELECT Id, Name FROM Profile WHERE Name ='System Administrator' LIMIT 1];
        
        if(UserInfo.getProfileId() != systemAdminProfile.Id){
            for(Lead le : leadOldList){
                le.addError('You have insufficient access to delete this record');
            }
        }
    }
    
    // write a trigger such that only system admin are able to update lead record
    
    Public static void updateLead(List<Lead> newLeadList){
        
        ID curentId = userInfo.getProfileId();
        
        Profile currentProfileName = [select Name from Profile where ID =:curentId];
        
        for(Lead le:newLeadList){
            if(currentProfileName.Name !='System Administrator'){
                le.addError('only system admin can update lead record');
            } 
        }
    }
}