public class OpportunityTriggerHandler95 {
    
    //Write a trigger such that if Opportunity is Closed Won then the record should be prevented from getting deleted.
  
    Public static void oppDeletePrevention(List<Opportunity> oppOldList){
        for(Opportunity opp :oppOldList){
            if(opp.StageName == 'Closed Won'){
                opp.addError('stage of this opportunity is Closed Won we are not able to delete');
            }
        }
    }
   
//Write a trigger such that any non System Admin user must not able to delete an opportunity:-

     Public static void onlySystemAdminCanDeleteR(List<Opportunity> oppOldList){
        
        User currntUserName =[select Id, Profile.Name from User where Id =:UserInfo.getUserId()];
        
        for(Opportunity opp:oppOldList){
            if(currntUserName.Profile.Name != 'System Administrator'){
                opp.addError('Only system admin can delete opp records');
            }
        }
    }
}