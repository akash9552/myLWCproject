public class DemoClass{
    public static void myMethod1(){      
        List<Opportunity>oppList = [SELECT Id, Name ,amount from opportunity order by amount desc limit 1 offset 4];
        for(Opportunity opl:oppList){
            System.debug(opl);
        }        
    }   
	 public static void myMethod2(){
         List<Account>accList = [SELECT Id, Name,(SELECT Id,CaseNumber,Origin FROM Cases) FROM Account];
         for(Account acc:accList){
             for(Case cas:acc.cases){
                 system.debug(cas);
             }
         } // 'Case Id ==>'+cas.Id + ' Case Number ==>'+cas.CaseNumber +  ' Case Origin ==>' +cas.Origin
         
	}
}