public class methodoverloadingDemo {
    
    public static void addition(Integer num1,Integer num2){
        Integer result = num1+num2;
        System.debug('Result is:  '+result);
    }
    public static void addition(Decimal num1,Decimal num2){
        Decimal result = num1+num2;
        System.debug('Result is:  '+result);
    }
}