public class SchedulableClass18 implements Schedulable {
    
     /*
     i have thousand records on opportunity i want to delete all the 'closed Lost' opportunity at the end of every month.
     */
    Public void execute (SchedulableContext ts){
        
        List<Opportunity>opplist =[SELECT ID, StageName FROM Opportunity WHERE StageName = 'Closed Lost'];
        
        delete opplist;
    }

}