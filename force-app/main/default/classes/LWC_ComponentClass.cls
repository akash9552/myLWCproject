public class LWC_ComponentClass {
    
    @AuraEnabled(cacheable=true)
    
    Public static List<Account> accListMethod(string inputName){
        
        system.debug('method run successfully');
        
       string accName= '%'+inputName+'%';
        
        return [select id, Name FROM Account where Name like:accName];
    }

}