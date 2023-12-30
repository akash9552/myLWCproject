Public class LeadTriggerHandlerClass22{
    /*
    
    Public Static void checkEmaiIsUique(List<Lead>leadNewList, Map<Id,Lead>leadOldMap){
        
        Set<String>emailOfContact = new Set<String>();
        
        List<Contact>conList = [SELECT ID, Email FROM Contact];
        
        for(Contact con : conList ){
            
            emailOfContact.add(con.Email);
        }		
        
        List<Lead>leadList = [SELECT Id, Email FROM Lead WHERE Email  in : emailOfContact] ;		
        
        for(Lead ld : leadNewList){
            if(leadList.size()>0){
                ld.addError('This Email is already exists on contact' );
            }
        }
    }
    
    public static void avoidSameEmail(List<Lead>leadNewList){
        
        set<Id> DuplicateEmail = new set<Id>();
        
        for(Lead led : leadNewList){
            DuplicateEmail.add(led.Email);
        }
        
        List<Contact> ContactToBeChecked = [select Id, Email from contact WHERE Email IN :DuplicateEmail];
        
        Map<string, Contact> mapContact = new Map<string,Contact>();
        
        for(contact con:ContactToBeChecked){
            
            mapContact.put(con.Email, con);
        }
        for(Lead ld :leadNewList){
            if(Ld.Email != null){
                if(ld.Email != mapContact.get(ld.Id).Email ){
                    if(mapContact.containsKey(ld.Email)){
                        ld.Email.addError('Email already exists');
                    }
                    
                }
            }
            
        }
    }
    
    Public static void avoidDuplicateEmail(List<Lead> newLeadList){
        Set<String> emailIdSet = new Set<String>();
        for(Lead le : newLeadList){
            if(le.Email != null){
                emailIdSet.add(le.Email);
            }
        }  
        List<Lead> leadRecord = [SELECT Id, Email FROM Lead WHERE Email IN : emailIdSet];
        for(Lead le : newLeadList){
            
        }
    }

*/
    
    Public static boolean checkTrigger = true;
    
    Public static void recursionExample(List<Lead>leadList){
        
        List<Lead> leadRecoed = new List<Lead>();
        
        for(Lead le : leadList){
            Lead le1 = new Lead();
            le1.LastName ='test';
            le1.Company = 'test company';
            leadRecoed.add(le1);
        }
        insert leadRecoed;
    }
    
    public static void updateLeadRecord(List<Lead>newLeadList, map<Id, Lead> leadOldMap){
     
        for(Lead le:newLeadList){
            if(le.Email != null && le.Email != leadOldMap.get(le.Id).Email){
                le.Phone='9552229822';
            }
        }
    }
    
    //1.Create a duplicate lead when a lead is inserted. 
    
    public static void createDuplicateLead(List<Lead>newLeadList){
        
        List<Lead> leadInsert = new List<Lead>();
        for(Lead le:newLeadList){
            
            Lead lee = new Lead();
            lee.LastName = 'duplicate Lead';
            lee.Company = 'PKKA';
            leadInsert.add(lee);
        }
        if(!leadInsert.isEmpty()){
            insert leadInsert;
        }
    }
}