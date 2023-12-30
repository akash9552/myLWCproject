public class AsynchronusClass {
    
    @future
    
    public static void asyncMethod(){
        
        PermissionSet perset = new PermissionSet();
        perset.Label = 'Apex class test 2000';
        perset.Name = 'Apexclasstest1';
        insert perset;
    }
}