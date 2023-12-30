trigger TaskTrigger on Task (before delete) {
    
    if(Trigger.isBefore) {
        if(Trigger.isDelete){
            TaskHandlerClass.onlysystemAdminCandeleteTask(Trigger.old);
        }
    }
}