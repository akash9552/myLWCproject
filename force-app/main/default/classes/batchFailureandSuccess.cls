global class batchFailureandSuccess implements Database.Batchable <sObject>, Database.Stateful{
    
    global Map<Id, String> errorSuccessMap; 
    
    global Database.QueryLocator start(Database.BatchableContext bc){ 
        
        return Database.getQueryLocator([Select Id, Name, Rating from Account where Name like '%Batch Demo Account%']);
    }
    
    global void execute(Database.BatchableContext bc, List<Account> accList){
        
        errorSuccessMap = new Map<Id, String>();
        List<Account> accountList = new List<Account>(); 
        integer count = 0;
        
        for(Account acc : accList){ 
            acc.annualrevenue = 20000; 
            count++;
            if(count == 4 || count == 5){ 
                acc.name = '';
            } 
            accountList.add(acc);
        }
        system.debug('Count of Records which will be updated in accountList ===> '+accountList.size());
        
        Database.SaveResult[] lsr = Database.update(accountList, false);
        // using this method database.saveResult we can find success and failed result
        
        List<Id> updateSuccess = new List<Id>();
        List<Id> updateErrors = new List<Id>();
        
        for(Database.SaveResult sr : lsr){ 
            if(sr.isSuccess()){ 
                updateSuccess.add(sr.getId());
                errorSuccessMap.put(sr.getId(), 'Success'); // we add Success record in map which i declear globaly 
            } else { 
                for(Database.Error err : sr.getErrors()){
                    // if record get fail to update they come here in else part 
                    updateErrors.add(sr.getId());
                    errorSuccessMap.put(sr.getId(), 'Error');   // we add failed record in map which i declear globaly 
                    
                    system.debug('Errors RecordId == > '+updateErrors);
                    system.debug('Errors Count== > '+updateErrors.size());
                    System.debug('The following error has occurred.');
                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                    System.debug('Account fields that affected this error: ' + err.getFields());
                } 
            } 
        } 
        system.debug('List of Successfull Update ==> '+updateSuccess);
        system.debug('List Count of Successfull Update ==> '+updateSuccess.size());
        System.debug('errorSuccessMap ===> '+errorSuccessMap); 
    } 
    global void finish(Database.BatchableContext bc){ 
        System.debug('Finish errorSuccessMap ===> '+errorSuccessMap);
    }
}