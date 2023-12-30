public class CollectionClass12 {

    public static void setCollection() {

        Set<Integer> setElements1 = new Set<Integer>();
        Set<Integer> setElements2 = new Set<Integer>();
        
        setElements1.add(10);
        setElements1.add(20);
        setElements1.add(30);
        
        setElements2.add(20);
        setElements2.add(30);
        setElements2.add(40);
        
        setElements1.removeAll(setElements2);        
        
        System.debug(setElements1);
    }
}