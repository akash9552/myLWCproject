public class SynchronousApexClass {

    public static void callQueueable() {
        System.enqueueJob(new QueueableClass1());
        System.enqueueJob(new QueueableClass2());
        
        System.debug('Total queueable called are : '+Limits.getQueueableJobs());
    }
}