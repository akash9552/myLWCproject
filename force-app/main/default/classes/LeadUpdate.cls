/*Create a batch apex which should check all the open not contacted leads 
created in the current week and update the lead as Closed Lost. The 
batch apex should be scheduled to run on every Sunday at 10:00 pm
*/
global class LeadUpdate implements Database.Batchable<sObject>, Schedulable{
    
   global Database.QueryLocator start(Database.BatchableContext BC) {
       
        string query = 'select Id, Name, Status From Lead where CreatedDate = THIS_WEEK AND Status =\'Open - Not Contacted \'';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Lead> leadList){
        
        List<Lead> updateLead = new List<Lead>();
        
        for(Lead le : leadList){
            le.Status='Closed - Not Converted';
            updateLead.add(le);
        }
        if(!updateLead.isEmpty()){
            update updateLead;
        }
    }
    global void finish(Database.BatchableContext BC) {
    }
    
    global void execute(SchedulableContext sc){
        LeadUpdate leup = new LeadUpdate(); 
       database.executeBatch(leup);
    }
}