public class FutureClass {
    
    @future 
    public static void futureMethod(){
        
	PermissionSet perm = new PermissionSet();
        perm.Name = 'Akash9552';
        perm.Label = 'demoPermissionSet155';
        insert perm;
        system.debug(perm);
       // SynClass.syncMethod1();
        }
       
}