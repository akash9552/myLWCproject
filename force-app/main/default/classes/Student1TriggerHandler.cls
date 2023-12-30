public class Student1TriggerHandler {
    /* on creation of student record, check contact email id if it is prasent then create student record related to contact
      if not prasent, then create contact record and relate student record to that contact.
		send mail by using student email id to infornm the joining date and courses.
     */
    /*
    on creation of contact record check account email if it is prasent then create contact record related to Account
     if not prasent then create account record and relate contact record to that Account.
    
    */
    
    Public static void createParent(List<Student1__c>NewStdList){
        
        List<Student1__c>stdList = [SELECT Id, Email__c FROM Student1__c WHERE ID =:NewStdList AND Contact__c != null];
        
        for(Student1__c std :stdList){
       
        }
        
        
    }
     Public Static Void Mymethod(List<Student1__c>studlist){
        
        // Map of Email and Student records.
        Map<string,Student1__c> studentmap = new Map<string,Student1__c>();
        for(Student1__c stu : studlist) {
            studentmap.put(stu.Email__c,stu);
        }
        // Query existing contacts based on email address
        List<Contact> existingContacts = [SELECT Id, Email FROM Contact WHERE Email IN:studentmap.keyset() LIMIT 200];
         
        Map<String, Contact> emailContactMap = new Map<String, Contact>();
         
        for(Contact con : existingContacts) {
            emailContactMap.put(con.Email, con); 
        }
        List<Student1__c> studentNotContainsEmail = new list<Student1__c>();
         
        List<Student1__c> studentList = new List<Student1__c>();
        List<Contact> contactList = new List<Contact>();
         
        list<messaging.Email>emailmessage = new List<messaging.Email>();
        set<string> NewContactEmail_Set = new set<string>();
        for(Student1__c stu : studlist) {
            // Check if contact email already exists
            if(emailContactMap.containsKey(stu.Email__c)) {
                stu.Contact__c = emailContactMap.get(stu.Email__c).Id;
            }
            // Create new contact if email doesn't exist
            else {
                Contact newCon = new Contact();
                newCon.Email = stu.Email__c;
                newCon.FirstName = stu.Name__c+'testcon';
                newCon.LastName = stu.Name__c+'test';
                contactList.add(newCon);
                NewContactEmail_Set.add(newCon.Email);
                studentNotContainsEmail.add(stu);
            }
        }
        if(!contactList.isEmpty()) {
            insert contactList;
        }
        if(NewContactEmail_Set.size() > 0 ){ 
            list<student__c> studentListinsert = new list<student__c>();
        list<contact> getNewContact = [SELECT Id,Email,Name FROM contact WHERE Email IN: NewContactEmail_Set];
           
            for(integer i =0 ; i <studentNotContainsEmail.size() ; i++){
               studentNotContainsEmail[i].Contact__c = getNewContact[i].Id;
            } 
        }
         for(string Email : studentmap.keyset()){
             list<string> EmailList = new list<string>();
             EmailList.add(Email);
             if(!EmailList.isEmpty()){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                mail.setToAddresses(EmailList);
                mail.setSubject('Your student record has been created..!');
                // Specify the text content of the email.
                mail.setPlainTextBody('Your student record has been created. Your related contact name is '+EmailList +'your joining date is'+ studentmap.get(Email).Joining_date_c__c +'and course is'+ studentmap.get(Email).Courses_c__c);
                // Send the email you have created.
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] { mail });
            } 
         }
    }
}