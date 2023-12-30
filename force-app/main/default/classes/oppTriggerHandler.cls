public class oppTriggerHandler {
    
    /*  Write a trigger on Opportunity, when an Opportunity will be insert an
Opportunity Line Item should be insert by default with any of the Product
associated with Opportunity.
*/
    public static void oppLineItemInsert(List<Opportunity>oppNewList){
        
        Product2 prodt = [SELECT Id FROM Product2 LIMIT 1];
        
        PricebookEntry pBE = [SELECT Id FROM PricebookEntry LIMIT 1];
        
        List<OpportunityLineItem>oppProdToInsert = new List<OpportunityLineItem>();
        
        for(Opportunity opp : oppNewList){
            
            OpportunityLineItem oppLI = new OpportunityLineItem();
            
            oppLI.Product2Id = prodt.Id;
            oppLI.PricebookEntryId = pBE.Id;
            oppLI.Quantity = 1;
            oppLI.OpportunityId = opp.Id;
            oppLI.TotalPrice = 50000;
            oppProdToInsert.add(oppLI);
        }
        if(!oppProdToInsert.isEmpty()){
            insert oppProdToInsert;
        }
    }
}
/*An opportunity Line item is nothing but the product which we added to a particular opportunity.
An opportunity line item is the junction object. When we add a product to Opportunity
it is called Opportunity Line Item which you use during your sales.
*/