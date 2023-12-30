public class LeadHandelerClass2 {
    /*
     Write a trigger such that when you create a new Lead with Email as not null. 
     Check if an existing lead is present with the same email. 
     If present throw an error message that “Duplicate lead found with same email”.
	*/
     public static void duplicateLeads(List<Lead> leadNewList) {
         
        Set<String> emails1 = new Set<String>();
       
        
        for(Lead ld : leadNewList) {
            if(ld.Email != null) {
                emails1.add(ld.Email);
                
            }
        }
        List<Lead> leadEmailList = [SELECT Id, Email FROM Lead WHERE Email IN : emails1 ];
         
        Set<String>emails2 = new Set<String>();
         
        for(Lead ld : leadEmailList) {
            emails2.add(ld.Email);
        }
        
        for(Lead ld : leadNewList) {
            if(emails2.contains(ld.Email)) {
                ld.addError('Duplicate lead found with same email');
            }
        }
    }
    
    Public static void duplicateLeadWithEmail(List<Lead>leadnewList){
        
        Set<String>emails = new Set<String>();
         Set<String>phoneNumbers = new Set<String>();
        
        for(Lead ld : leadnewList){
            if(ld.Email != null && ld.Phone != null ){
                
              emails.add(ld.Email); 
                phoneNumbers.add(ld.Phone);
                
                // yaha humne record create karte samaya jo email de rahe ho wo 1 set me dal diya
                // ab isi set ka use karke record late hai matlab isi email wala koi record hai akaya dekhana hai
                
            }
        }
        
        List<Lead> reacord_Of_Lead_withDupicateEmail =[SELECT Id, Email FROM Lead WHERE Email in :emails OR Phone IN :phoneNumbers];
        
        for(Lead ld2 : leadnewList){
            if(reacord_Of_Lead_withDupicateEmail.size()>0){
                ld2.addError('Duplicate lead found with same email and phone');
            }
        }
        
    }
    
   // while creating lead or updating , check if Email alrwady exist in contacts or not, if exists throw an error
    
    Public static void checkEmailonContact(List<Lead>newLeadlist) {
        
        Set<String> emailoflead = new Set<String>();
        
        for(Lead led : newLeadlist){
            if(led.Email  != null){
                 emailoflead.add(led.Email);
            }
        }
        
        List<Contact>conList = [SELECT Id, Email FROM Contact WHERE Email IN : emailoflead];
        
        for(Lead led2 : newLeadlist){
            if(conList.size()>0){
                led2.addError('This email is already exists in contact record');
            }
        }
    }
    
    Public static void checkEmailonContact2(List<Lead>newleadlist){
        
        set<String>Emailset = new set<String>();
        for(Lead led : newleadlist){
            if(led.Email !=null){
                Emailset.add(led.Email);
            }
        }
        Map<String,Contact> emailmap = new Map<String, Contact>();
         List<Contact> conlist = [SELECT ID, Email FROM Contact WHERE Email IN : Emailset];
        for(Contact con : conlist){
            emailmap.put(con.Email, con);
        }
        for(Lead ld : newleadlist){
            if(ld.Email != null){
                if(emailmap.Containskey(ld.Email)) {
                    
                    ld.addError('Email already exists on account');
                    
                }
                if( Emailset.contains(ld.Email)){
                 ld.addError('Email already exists on account');
            }
            
            }
        }  
    }
    
}