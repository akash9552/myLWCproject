public class MergClass {
    
    Public static void mergAccount(){
        Account acc = [SELECT Id, Name FROM Account WHERE Name ='Akash 01'];
        Account acc1 = [SELECT Id, Name FROM Account WHERE Name = 'Akash 02'];
        merge acc acc1;
    }

}