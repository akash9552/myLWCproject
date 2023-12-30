public class DemoCunstructor {
    
    // Two uses of this key word
    
    Public Integer intVar;
    
    Public DemoCunstructor(Integer intVar){
        This.intVar = intVar;
    }
    Public void testThisWord(){
        
        System.debug('intVar value is : '+intVar);
    }
    /* 
Public DemoCunstructor(){

System.debug('inside non Parameterized Constructor');

}
Public DemoCunstructor(Integer i){

This();

System.debug('Inside Parameterized Constructor ');
}
*/
}