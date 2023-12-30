public class PartianAndNormalDML {
    
 // Naormal dml
    Public static void createContactRecord1(){
        
        List<Contact>conList = new List<Contact>();
        
        Contact con1 = new Contact();
        con1.LastName ='mg1';
        con1.Email = 'mg1@gmail.com';
        conList.add(con1);
        
        Contact con2 = new Contact();
       //con2.LastName ='mg2';
        con2.Email = 'mg2@gmail.com';
        conList.add(con2);
        
        if(!conList.isEmpty()){
            insert conList;
        }
    }
    
    //Partial DML 
    Public static void createContactRecord2(){
        
        List<Contact>conList2 = new List<Contact>();
        
        Contact con = new Contact();
        con.LastName = 'mg3';
        con.Email = 'mg3@gmail.com';
        conList2.add(con);
        
         Contact con1 = new Contact();
        //con1.LastName = 'mg4';
        con1.Email = 'mg4@gmail.com';
        conList2.add(con1);
        
        if(!conList2.isEmpty()){
            Database.insert(conList2, false);
        }
    }
    
}