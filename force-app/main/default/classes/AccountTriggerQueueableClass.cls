public class AccountTriggerQueueableClass implements Queueable {
    
    List<Account>accNewList = new List<Account>();
    
    public AccountTriggerQueueableClass(List<Account>accNewList){
        
        this.accNewList = accNewList;
    }
    
    public void execute(QueueableContext qc) {
        
         List<Contact>insrtContact = new List<Contact>();
        
        for(Account acc : accNewList){
            
            Contact con = new Contact();
            con.LastName = 'New contact for acc';
            con.AccountId = acc.Id;
            insrtContact.add(con);
            
        }
        
        if(!insrtContact.isEmpty()){
            insert insrtContact;
        }

    }

}