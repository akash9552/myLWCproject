public class TriggerPractice2 {

    Public static void chechBoxTrue(List<Account> accNewList, Map<Id, Account> accOldMap){
        
        for(Account acc : accNewList){
            if(acc.Email__c != null && acc.Email__c != accOldMap.get(acc.Id).Email__c){
                acc.IsActive__c = true;
            }
        }
    }
     public static void setCloseDate(List<Opportunity> oppNewList, Map<Id, Opportunity> oppOldMap) {
        
        for(Opportunity opp : oppNewList) {
            
            if(oppOldMap != null) {
                if(opp.StageName != oppOldMap.get(opp.Id).StageName) {
                    if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost') {
                        opp.CloseDate = System.today();
                    }
                }
            } else if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost'){
               
                opp.CloseDate = System.today();
                
            }
        }
    }
    
    //Write a trigger such that if the Opportunity Stage Name is Closed Won or Closed Lost then the Close Date must
    // be populated with today's date.

    Public static void closeDate(List<Opportunity> oppNewList, Map<Id, Opportunity> oppOldMap){
        
        for(Opportunity opp:oppNewList){
            if(oppOldMap != null){
            if(opp.StageName != oppOldMap.get(opp.Id).StageName){
                if(opp.StageName =='Closed Won'|| opp.StageName =='Closed Lost'){
                    opp.CloseDate = System.Today();
                } 
            }
            }else{
                if(opp.StageName == 'Closed Won' || opp.StageName == 'Closed Lost') {
                opp.CloseDate = System.today();
                }
             
            }  
        }
    }

}