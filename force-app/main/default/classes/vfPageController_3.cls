public class vfPageController_3 {

    public List<Account> accList{get; set;}
    
    public vfPageController_3(){
        accList=[select Id, Name, Rating, Email__c from Account where Rating != null AND Email__c != null];
    }
}