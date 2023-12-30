public class AssignmentClass {

    public static void listCollection(){
        List<Integer>num = new List<Integer>();
        for(Integer i=1; i<=100; i++){
            num.add(i);
        }
        System.debug(num);
        for(Integer k : num){
            Integer j = math.mod(k,5);
            if(j == 0){
                system.debug('Number divisible by 5 is: '+k);
            }
        }
    }
}