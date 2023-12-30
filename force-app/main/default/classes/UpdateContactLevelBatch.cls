global class UpdateContactLevelBatch implements Database.Batchable<sObject>, Database.Stateful {
    global Integer totalRecordsProcessed = 0;
    global Integer totalRecordsFailed = 0;

    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator('SELECT Id, Email, Level__c FROM Contact');
    }

    global void execute(Database.BatchableContext BC, List<Contact> scope) {
        List<Contact> contactsToUpdate = new List<Contact>();
        for (Contact con : scope) {
            if (con.Email != null) {
                con.Level__c = 'Secondary';
                contactsToUpdate.add(con);
                totalRecordsProcessed++;
            }
        }
        try {
            update contactsToUpdate;
        } catch(Exception e) {
            totalRecordsFailed += contactsToUpdate.size();
        }
    }

    global void finish(Database.BatchableContext BC) {
        System.debug('Total Records Processed: ' + totalRecordsProcessed);
        System.debug('Total Records Failed: ' + totalRecordsFailed);
    }
}