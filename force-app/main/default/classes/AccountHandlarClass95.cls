public class AccountHandlarClass95 {
    
    /* Create tow check box on Account object with name create opportunity and create contact  
Write a Trigger on Account such that when new record is create on Account with if create opportunity 
check box true create new opportunity and if create contact check box is true create one Contact to that Account.
*/
    /*
    public static void createChildofAccount(List<Account>accNewList){
        
        List<opportunity>oppCreateList = new List<opportunity>();
        
        List<Contact>conCreateList = new List<Contact>();
        
        for(Account acc : accNewList){
            
            if(acc.Create_Opportunity__c==True){
                Opportunity opp= new Opportunity();
                opp.AccountId = acc.Id;
                opp.Name = 'test opp on account trigger fitre';
                opp.StageName ='Closed Won';
                opp.CloseDate = System.today();
                
                oppCreateList.add(opp);                
            }
            if(acc.Create_Contact__c == True){
                Contact con = new Contact();
                con.AccountId = acc.Id;
                con.LastName = 'test opp on account trigger fitre';
                
                conCreateList.add(con);
            }
        }
        if(!oppCreateList.isEmpty()){
            Insert oppCreateList;
        }
        
        if(!conCreateList.isEmpty()){
            Insert conCreateList;
        }
    }
    */
    Public static void updateContact(List<Account> accNewList, Map<Id, Account> accOldMap){
        
        List<Account> parentToChild = [SELECT Id, Phone, (SELECT ID, Phone FROM Contacts) FROM Account WHERE ID IN :accNewList];
        
        List<Contact> conToUpdate = new List<Contact>();
        
        for(Account acc: parentToChild){
            if(acc.Phone != accOldMap.get(acc.Id).Phone){
                for(Contact con : acc.Contacts){
                    con.Phone = acc.Phone;
                    conToUpdate.add(con);
                }
            }
        }
        
        if(!conToUpdate.isEmpty()){
            update conToUpdate;
        }
    }
}