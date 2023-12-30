public class oppDemoClass {
 Public static void myMethod(List<Opportunity>oppNewList, Map<Id, Opportunity>oppOldMap){
        
          profile systemAdminProfile = [SELECT Id FROM Profile WHERE Name='System Administrator' LIMIT 1];
        
        if(UserInfo.getProfileId() != systemAdminProfile.Id){
            for(Opportunity opp : oppNewList){
                if(opp.Id == oppOldMap.get(opp.Id).Id ){
                    opp.addError('You do not have permission to edit this record');
                }
            }
        }
    }
}