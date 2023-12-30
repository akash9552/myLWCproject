public class LeadHaandlerClass {
    /*  
Write a trigger such that when you create a new Lead with Email as not null.
Check ifan existing lead is present with the same email. If present throw an 
error message that “Duplicate lead found with same email”
*/
    public static void duplicateLeadWithEmail(List<Lead>newleadList){
        
        Set< String >Emailset1 = new Set< String >();
        
        for(Lead ld : newleadList){
            if(ld.Email !=null){
            Emailset1.add(ld.Email);
            }
        }
        List<Lead>LeadList = new List<Lead>();
        
        LeadList =[SELECT Email FROM Lead WHERE Email IN :Emailset1];
        
        Set<String>Emailset2 = new Set< String >();
        
        for(Lead ld1 : LeadList){
            Emailset2.add(ld1.Email);
        }
         for(Lead ld : newleadList) {
            if(Emailset2.contains(ld.Email)) {
                ld.addError(Lead.Email,'Duplicate lead found with same email');
            }
        }

    }
    
    /*
      When lead is created or updated then check if the email of lead is already there in
      existing contacts. If email already exist then throw error. 
     */
    Public static void duplicateEmailOnContact(List<Lead> newLeadList, Map<Id, Lead> leadOldMap){
     
        Map<String, Contact> conMap = new Map<String, Contact>();
        
        List<Contact> conList = [SELECT ID, Email FROM Contact];
        for(Contact con : conList){
            if(con.Email != null){
                conMap.put(con.Email, con);
            }
        }
           
        for(Lead le : newLeadList){
            if(le.Email != null && le.Email != leadOldMap.get(le.Id).Email){
                if(conMap.containsKey(le.Email)){
                    le.Email.addError('Email already exists');
                }
            }
        }
    }
    
    
     public static Boolean executeTrigger = true;
     public static void createDuplicateLead(List<Lead>newLeadList){

        List<Lead> leadInsert = new List<Lead>();
        for(Lead le:newLeadList){
            
            Lead lee = new Lead();
            lee.LastName = le.LastName;
            lee.Company = le.Company;
            lee.Status = le.Status;
            leadInsert.add(lee);
        }
        if(!leadInsert.isEmpty()){
            insert leadInsert;
        }
    }
    
    // update field on lead befor context
    
    Public static void updateLead(List<Lead>newLead, Map<Id,Lead>leadOldMap){
        for(Lead le:newLead){
            if(le.Rating != null || le.Rating !=leadOldMap.get(le.Id).Rating){
                if(le.Rating =='Hot'){
                      
                }else if(le.Rating =='Warm'){
                    le.Bu__c=50;
                }else{
                     le.Bu__c=10;
                }
            
            }
        }
    }
}