public class LWC_ComponentClass2 {
    
      @AuraEnabled(cacheable=true)
    public static List<Account> accountRecords() {
        return [SELECT Id, Name, Phone, Email__c, Type, Website, Rating, AnnualRevenue FROM Account where Phone != null AND Email__c !=null AND Rating !=Null];
    }


}