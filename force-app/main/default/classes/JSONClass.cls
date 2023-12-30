public class JSONClass {

    public static void handleResponse() {
        // ye json ke form me data hai hai hum ise salesforce ke form me convert karte hai
        String JsonBody = '{"firstName" : "Velocity","lastName"  : "Salesforce"}';
        
        // using below line we convert data in map for this we have to do forcasting 
        Map<String, Object> JsonMap = (Map<String, Object>)JSON.deserializeUntyped(JsonBody);
        
        System.debug('Json Map : '+JsonMap);
        
        String fName = (String)JsonMap.get('firstName');
        String lName = (String)JsonMap.get('lastName');
        
        System.debug('First Name : '+fName);
        System.debug('Last Name : '+lName);
    }
}