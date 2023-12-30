public class RevewTriggerHandlerClass {
	
    // write a trigger such that when new revew is created or updated related to any position then papulate taht latest 
    // revewnumber in LatestRevewNumber field on position
    Public static void updatePosition(List<Revew__c> newRevewList){
        
        List<Position__c> posUpdate = new List<Position__c>();
        
        for(Revew__c rew:newRevewList){
            Position__c pos =new Position__c();
            pos.Id=rew.position__c;
            pos.LatestRevewNumber__c=rew.Name;
            posUpdate.add(pos);
        }
        if(!posUpdate.isEmpty()){
            update posUpdate;
        }
    }
}