@isTest
public class AccountHandlerClass_2_TestClass {

    @testSetup
    public static void setupTestData() {
        Account acc = new Account();
        acc.Name = 'Test Record Account';
        insert acc;
        
        Account accRec = [SELECT Id, Rating FROM Account];
        System.assert(accRec.Rating == 'Cold');
        System.assertEquals('Cold', accRec.Rating);
        System.assertNotEquals('Hot', accRec.Rating);

    }
    
    @isTest
    public static void beforeUpdateRating() {
        
    }

}