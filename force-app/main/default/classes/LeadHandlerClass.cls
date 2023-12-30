public class LeadHandlerClass {
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
    }
}