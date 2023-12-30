public class PracticeTestClass {
    Public static void myMethod(){
      
    
    List<Account> accList = [SELECT Id, Name FROM Account WHERE isDeleted = true ALL ROWS];
        for(Account acc :accList){
            system.debug(acc);
        }
}
}