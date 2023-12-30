@isTest
public class FutureClass_TestClass {
    
    @testSetup
    Public static void mySetupMethod2(){
        PermissionSet perm = new PermissionSet();
        perm.Name='Akash955222';
        perm.Label='demoPermissionSet22155';
        insert perm;
        
        User thisUser = [SELECT Id FROM User WHERE Id =: UserInfo.getUserId() LIMIT 1];
        System.runAs(thisUser){
            Account acc=new Account();
            acc.Name='Test Acc from asych552285';
            insert acc;
        }
    }
    @isTest
    public static void synMethod(){
        
    }
    
    
}