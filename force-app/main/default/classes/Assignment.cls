public virtual class Assignment{ 
    public static void countriesCollection(){
        set<String>countries1 = new Set<String>{'India','Australia','United States','Indonesia','Canada'};
            
            set<String>countries2 = new Set<String>{'Mexcio','United Kingdom','India','Australia','Italy'};
                 countries1.addAll(countries2);
                List<String>finalCountries = new List<String>(countries1);
        			finalCountries.sort();
        System.debug('The unique countries are: '+finalCountries);
    }
}