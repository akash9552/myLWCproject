public class DMLClass {
    public static void insertDML1(){
        Account acc = new Account();
        acc.Name = 'Redevalopment project2';
        acc.Budget__c = 2500000;
        acc.AccountNumber = '123456';
        insert acc;
        
        Contact con = new Contact();
        con.LastName = 'test contact';
        insert con;
        system.debug(acc);
        system.debug(con);
    }
    public static void insertDML2(){
        list<Account>acclist =new list<Account>();
        
        Account acc = new Account();
        acc.Name = 'Redevalopment project6';
        acc.Budget__c = 2600000;
        acc.AccountNumber = '9552229822';
        acclist.add(acc);
               
        Account acc1 = new Account();
        acc1.Name = 'Redevalopment project7';
        acc1.Budget__c = 2700000;
        acc1.AccountNumber = '9689065663';
        acclist.add(acc1);
        
 		Account acc2 = new Account();       
        acc2.Name = 'Redevalopment project8';
        acc2.Budget__c = 2800000;
        acc2.AccountNumber = '7020273492';
        acclist.add(acc2);
        
        if(!acclist.isEmpty()){
            insert acclist;
        }
          for(Account accObj : acclist) {
            System.debug(accObj.Id);
        }

        system.debug(acclist);
    }
    public static void insertDML3(){
         delete [SELECT Id FROM Account WHERE AccountNumber = '123456'];

    }
    public static void insertDML4(){
        Account acc = new Account();
        acc.Id = '0015i00000QzbuxAAB';
        delete acc;
        system.debug(acc);
    }
    public static void insertDML5(){
        position__c pos = new position__c();
        pos.Id = 'a005i000007VW9rAAG';
        pos.Max_pay__c = 47000;
        update pos;
        system.debug(pos);
    }
    public static void insertDML6(){
        List<Account> accountToUpdate = new List<Account>(); 
        for(Account acc : [SELECT Id, Name, Phone FROM Account WHERE CreatedDate = TODAY]) {           
            acc.Phone = '9552229822';
            accountToUpdate.add(acc); 
             system.debug(acc); 
        }
        if(!accountToUpdate.isEmpty()) {
            update accountToUpdate;
        }
    }
    public static void insertDML7(){
        Account acc = new Account();
        acc.Name = 'R.K.foundation 1';
        acc.Budget__c = 5000000;
        acc.AccountNumber ='9552229822';
        insert acc;
        system.debug('ID of R.K.foundation 1 Account is :  '+acc.Id);
        
        Contact con = new Contact();
        con.LastName = 'Akash1';
        con.AccountId = acc.Id;
        insert con;
        system.debug(con);
    }
    public static void insertDML8(){
        list<Account>accList = new list<Account>();
        Account acc = new Account();
        acc.Name = 'R.K.F';
        accList.add(acc);
        
        Account acc1 = new Account();
        acc1.Name = 'R.K.F 1';
        accList.add(acc1);
        
        if(!accList.isEmpty()){
            insert accList;
        }
        for(Account accobj:acclist){
            system.debug(accobj.Id);
        }
    }
    public static void updatetDML8(){
        Account acc = new Account();
        acc.Id = '0015i00000R0EAbAAN';
        acc.Name = 'R.K. foundation';
        update acc;
    }
    public static void upsertDML9(){
        position__c pos = new position__c();
        pos.Name = 'R.K.foundation 5';
        pos.External_ID__c ='95522298';
        pos.status__c = 'New position';
        upsert pos External_ID__c;
    }
    public static void undeleteDML10(){
        undelete[SELECT Id FROM Account WHERE isDeleted = true AND name ='R.K.F'ALL ROWS];
    }
    public static void upsertDML11(){
      /*  position__c pos = New position__c();
        pos.Name = 'Pushpa';
        pos.Max_pay__c = 355000;
        upsert pos Name;
     */   
        Account acc = New Account();
        acc.Name = 'R.K.foundation 6 ';
        acc.AccountNumber = '550000045';
        acc.External_id__c = '952852';
        upsert acc External_id__c;
    }
    public static void mergeDML12(){
        Account acc1 = [SELECT Id FROM ACcount WHERE NAme = 'Account1'];
		Account acc2 = [SELECT Id FROM ACcount WHERE NAme = 'Account2'];
		merge acc1 acc2;

    }
    public static void mergeDML13(){
        Account acc1 = [SELECT Id FROM ACcount WHERE NAme = 'Account1'];
        list<Account>acc2acc3 = [SELECT Id FROM Account WHERE Name = 'Account2' OR Name ='Account3'];
        
        merge acc1 acc2acc3;       
    }
    public static void partialDML14(){
       system.debug('before insert');
        
        list<Opportunity>opplist = New list<Opportunity>();
        
        Opportunity opp1 = new Opportunity();
        opp1.Name = 'created during partia dml 1';
        opp1.CloseDate = system.today();
        opplist.add(opp1);
        
        Opportunity opp2 = new Opportunity();
        opp2.Name = 'created during partia dml 2';
        opp2.CloseDate = system.today();
        opp2.StageName = 'Closed Lost';                      //insert opplist;
        opplist.add(opp2);                                  // Insert failed first error: REQUIRED_FIELD_MISSIN
        
        if(!opplist.isEmpty()){
            Database.insert(opplist,false);
        }
        system.debug('after insert');
    }
   
    
}