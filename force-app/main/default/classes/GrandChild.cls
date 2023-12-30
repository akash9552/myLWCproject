public class GrandChild extends childClass{
	 public GrandChild(){
        System.debug('Inside GrandChild non parameterised constructor');
    }
    public GrandChild(Integer i){
        Super(4);
        System.debug('Inside GrandChild  parameterised constructor');
    }	
}