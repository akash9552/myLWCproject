@isTest
public class AccHandalerClass_TestClass {

@testSetUp
Public static void testsetUpMethod(){
    List<Account> accList =new List<Account>();
    
    for(integer i=1; i<200; i++){
        Account acc = new Account();
        acc.Name = 'test acc'+i;
        accList.add(acc);
    }
    test.startTest();
    insert accList;
    test.stopTest();
}
@isTest
Public static void createContactWithAcc(){
        }
}