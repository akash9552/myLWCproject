public class oppLineIteamProduct {
	/*
    Write a trigger on Opportunity, when an Opportunity will be insert an
    Opportunity Line Item should be insert by default with any of the Product
    associated with Opportunity. Ask me if you need help ?
*/
    Public static void insertOppLineItome(List<Opportunity> oppNewList){
        
        List<OpportunityLineItem> oppLineItemInsert = new List<OpportunityLineItem>();
        
        //map<Id,PricebookEntry > PricebookEntrymap = new Map<Id,PricebookEntry>([SELECT Id FROM PricebookEntry limit 1]);
        //map<Id,Product2> Product2map = new Map<Id,Product2>([SELECT Id FROM Product2 limit 1]);
        
        for(Opportunity opp :oppNewList){
            OpportunityLineItem opplit = new OpportunityLineItem();
            opplit.OpportunityId = opp.Id;
            opplit.Product2Id='01t5i000002GVv2AAG';
            opplit.Quantity=1;
            opplit.PricebookEntryId='01u5i000002RaUkAAK';
            opplit.TotalPrice=50000;
            oppLineItemInsert.add(opplit);
        }
        
        if(!oppLineItemInsert.isEmpty()){
            insert oppLineItemInsert;
        }
    }
}