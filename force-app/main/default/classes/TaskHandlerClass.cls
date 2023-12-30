public class TaskHandlerClass {
    
   
    //Write a trigger, only system admin user should be able to delete the task.
    Public static void onlysystemAdminCandeleteTask(List<Task> taskOldList){
        /*
        User currentProfileName = [select Profile.Name, Name from User where Id =: userinfo.getUserId() LIMIT 1];
        // using this we can get current profile name 
         system.debug(currentProfileName.Profile.Name);
        
        for(Task tk:taskOldList){
            if(currentProfileName.Profile.Name != 'System Administrator'){
                tk.addError('only system administrator can delete this task');
            }
        }
        */
        Profile curentProfileName = [select Name from profile where Id =:Userinfo.getProfileId() limit 1];
       // using this we can get current profile name 
         system.debug(curentProfileName.Name);
        for(Task tk:taskOldList){
            if(curentProfileName.Name !='System Administrator'){
                 tk.addError('only system administrator can delete this task'); 
            }
        }
       
    }
}