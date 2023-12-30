public class OpliItemTriggerHandler {
    //Create an asset when creating an OpportunityLineItem with associated Account.

    Public static void createAsset(List<OpportunityLineItem> oppliNewList){
        List<Asset> asetInsert = new List<Asset>();
        
        for(OpportunityLineItem oppli :oppliNewList){
            if(oppli.OpportunityId != null &&  oppli.Opportunity.AccountId != null){ 
                // Check if the OpportunityLineItem has an associated Account
                Asset newast = new Asset();
                newast.Name = oppli.Name;
                newast.Id = oppli.Opportunity.AccountId;
                asetInsert.add(newast);
            }
        }
        if(!asetInsert.isEmpty()){
            insert asetInsert;
        }
    }

}