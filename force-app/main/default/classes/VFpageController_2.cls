public class VFpageController_2 {
    
    public Account acc{get;set;}
    
    public VFpageController_2(){
        acc =new Account();
    }
    public PageReference  save(){
        
        insert acc;
        PageReference nextPage = new PageReference ('/lightning/r/Account/'+acc.id+'/view');
        return nextPage;
    }
}