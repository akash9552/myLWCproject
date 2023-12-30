public class ListAndSetClass {
    public static void duplicationMethod(){
        set<string> countries1 = new set<string>{'India','Australia','United States','Indonesia','Canada'};
            
            set<string>countries2 = new set<string>{'Mexico','United Kingdom','India','Australia','Italy'} ;
                
                countries1.addAll(countries2);
        List<string>finalCountries = new List<string>(countries1);
        system.debug('Values from set1 and set2 are:'+finalCountries);
                
}
    }