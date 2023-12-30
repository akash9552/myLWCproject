public class VFpageController {

    public Account acc{get;set;}
    
    public VFpageController() {
        
        Id accId = ApexPages.currentPage().getParameters().get('Id');
        
        acc =[select Id, Name from Account where Id =:accId];
    }
}