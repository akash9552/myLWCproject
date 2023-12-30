public class LeadTriggerHandlerClass {
    
     public static Boolean executeTrigger = true;

    public static void isertDuplicateLead(List<Lead>leadNewList){
        
        List<Lead>addtoLead =new List<Lead>();
        
        for(Lead Id : leadNewList){
            
            Lead le = new Lead();
            le.LastName = Id.LastName;
            le.Company = Id.Company;
            le.Status = Id.Status;
            addtoLead.add(le);
        }
        if(!addtoLead.isEmpty()){
            insert addtoLead;
        }
        System.debug(addtoLead.size());
    }
}