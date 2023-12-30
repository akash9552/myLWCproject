public class AvoidDuplicateContact {
    
   //Write a trigger on contact to prevent duplicate records based on Contact Email& Contact Phone.

    Public static void avoidDuplicateCon(List<Contact> conNewList){
        
        set<string> emailSet = new set<String>();
        set<string> phoneSet = new set<String>();
        
        for(Contact con :conNewList){
            if(con.Email != null || con.Phone != null){
                emailSet.add(con.Email);
                phoneSet.add(con.Phone);
            }
        }
       List<Contact> conList =[select Id, Phone, Email from Contact where Phone 
                                                       In:phoneSet OR Email IN:emailSet]; 
        for(Contact con:conNewList){
            if(conList.size()>0){
               con.addError('this phone or email alredy presnt'); 
            }
        }
    }
    
    Public static void avoidDuplicateCon2(List<Contact> conNeList){
        
        Map<String, Contact> conMap = new Map<string, Contact>();
        
        for(Contact con : [select Email from Contact where Email != null]){
            if(con.Email != null){
                conMap.put(con.Email, con);
            }
        }
        for(contact con :conNeList){
            if(con.Email != null && conMap.containsKey(con.Email)){
                con.addError('this Email presnt');
            }else{
               conMap.put(con.Email, con); 
            }
        }
    }

}