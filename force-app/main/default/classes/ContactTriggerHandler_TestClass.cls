@isTest
public class ContactTriggerHandler_TestClass {
    
    @testSetUp
    
    Public static void testSetupMethod(){
        
        List<Contact> conList = new List<Contact>();
        
        for(integer i=0; i==200; i++){
            Contact con= new Contact();
            con.LastName= 'Akash Test'+i;
            conList.add(con);
        }
        test.startTest();
        insert conList;
        test.stopTest();
    }
    
    @isTest
    Public static void preventConDeletion(){
        
        user u = [select Id, Profile.Name from User where  Profile.Name !='System Administrator' AND isActive = true LIMIT 1];
        system.runAs(u){
            test.startTest();
        try{
            List<Contact> conList =[select Id, Name from Contact];
            delete conList;
        }catch(Exception e){
            system.debug(e);
        }
        test.stopTest();
    }
        }
        
}