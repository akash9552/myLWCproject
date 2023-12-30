public class duplicateLead {
       

    Public static Boolean executeTrigger =true;
    
    Public static void createDuplicateLead(List<Lead> newLead){
        
        List<Lead> insertLead = new List<Lead>();
        
        for(Lead le:newLead){
            Lead le2 = new Lead();
            le2.LastName = le.LastName;
            le2.Company=le.Company;
            le2.Status = le.Status;
            insertLead.add(le2);
        }
        if(!insertLead.isEmpty()){
            insert insertLead;
        }
    }
}