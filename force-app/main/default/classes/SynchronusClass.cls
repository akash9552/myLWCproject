public class SynchronusClass {
    
    public static void synchMethod(){
        
        Opportunity opp = new Opportunity();
        opp.Name = 'Test opportunity2022';
        opp.StageName = 'Closed Won';
        opp.CloseDate = system.today();
        insert opp ;
        
        AsynchronusClass.asyncMethod();
        
       
    }
}