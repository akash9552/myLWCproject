public class CollectionpracticeClass {
    public static void myMethod1(){      
        list<string>cityName = New list<string>();
        cityName.add('pune');
        cityName.add('Latur');
        cityName.add('Nanded');
        system.debug(cityName);
        for(string str : cityName){
            system.debug('Name of city:'+str);
        }
        
        for(integer i=0; i<= cityName.size()-1; i++){
             system.debug('Name of city:'+cityName[i]);
        }
    }
    public static void myMethod2(){
        list<string>cityName = New list<string>{'pune','Latur','Nanded'};
            cityName.add(2,'Nagpur');                                    //add values on particular index
        system.debug('listof city names are:='+cityName);
    }
    public static void myMethod3(){
        list<integer>intlist = New list<integer>{12,13,14,15,16,17};
            system.debug(intlist);
        list<string>strlist = New string[5];                         //give size to list
        strlist.add(4,'India');
        system.debug(strlist);
    }
    public static void myMethod4(){
        list<string>strlist = New list<string>{'india','uk','USA'};    //add one list to another list 1st way
            system.debug(strlist);
        list<string>copylist = New list<string>(strlist);
        copylist.add('Canada');
        system.debug(copylist);
    }
    public static void myMethod5(){
        list<string>strlist = New list<string>{'india','uk','USA'};    //add one list to another list 2nd way
            system.debug(strlist);
        list<string>copylist = New list<string>();
        copylist =strlist.clone();
        system.debug(copylist);
    }
    public static void myMethod6(){
        integer i=0;
        list<integer>numlist = New list<integer>{74,15,58,78,14,25,9,28};
            numlist.sort();
        system.debug(numlist);
        for(i=1 ; i<=numlist.size()-1 ; i--){
            system.debug(numlist[i]);
        }
        list<string>charlist = New list<string>{'Rohit','Akash','Krishna','Mohan','Vikas','Kiran','Prannali','Zakas'};
            charlist.sort();
        system.debug(charlist);        
    }
    public static void myMethod7(){
        list<integer>intlist1 = New list<integer>{25,35,15,20,50};	    //equal method
            list<integer>intlist2 = New list<integer>{25,35,15,20};
                if(intlist1.equals(intlist2)){
                    system.debug('list are equals');       //in list index position also consider but in set they only check valus
                }
        else{
            system.debug('list are not equal');
        }
        if(intlist1.contains(30)){
            system.debug('element is presnt');
        }
        else{
            system.debug('element is not present');
        }
    }
    public static void myMethod8(){
        list<string>strlist = New list<string>{'Tuljapur','Kolhapur','Mahur Nanded','Vani Nasik'};
            system.debug(strlist);
        system.debug(strlist.get(2));
        system.debug(strlist.indexof('Kolhapur'));
        strlist.remove(0);
        system.debug('Elements are: '+strlist);
        if(strlist.isEmpty()){
            system.debug('List is empty');
        }
        else{
            system.debug('List is not empty');
        }
    }
    public static void myMethod9(){
        List<String> cityNames = new List<String>{'Pune', 'Nasik', 'Mumbai', 'Banglore','Astamod'};
        for(Integer i=0; i<=cityNames.size()-1; i++) {
            System.debug('Values are ===>  '+cityNames[i]);
            cityNames.set(4,'Latur');
            system.debug(cityNames);
        }  
    }
    public static void myMethod10(){   
        List<Integer> integerList = new List<Integer>{12,24,26,10,48};
        //integerList.sort();    
        String listString = integerList.toString();
        System.debug('String List : '+listString);
    }
	public static void myMethod11(){
        Set<string>strset = New Set<string>{'Priyanka','Alia','Rushmika','kirti suresh','pooja','Manushi','Rameshwari'};
            strset.add('Akash');                               //adding values to set
        system.debug('values in set is: '+strset);
        for(string ittset : strset){
            system.debug('Iterating over a Set:-'+ittset);                 //Iterating over a Set:-          
        }
    }
    public static void myMethod12(){
        list<integer>intlist = New list<integer>{1,2,5,41,54,85,88,78,5};        //Copying List to a Set
            Set<integer>intset = new Set<integer>(intlist);
        system.debug(intset);
    }
    public static void setMethod13(){
        set<integer>firstlist = New set<integer>{95,52,22,98,22};          
            set<integer>secondlist = New set<integer>{22,98,22,52,95};    
                system.debug(firstlist.containsAll(secondlist));           //containsAll method This
        system.debug(firstlist.equals(secondlist));                        //Comparing two sets
         secondlist.remove(98);
        system.debug(secondlist);                               //Removing an element from a set
		 firstlist.removeAll(secondlist);                       //Use of removeAll method
        system.debug(firstlist);
    }
    public static void setMethod14() {
        
        Set<Integer> setElements1 = new Set<Integer>{10,20,30};
            Set<Integer> setElements2 = new Set<Integer>{20,30,40};
                
                setElements1.removeAll(setElements2);        
        
        System.debug(setElements1);
        
        Set<Integer> setElements3 = new Set<Integer>{10,20,30,40,50,60,70};
            Set<Integer> setElements4 = new Set<Integer>{20,30,40,80,90};
                
                setElements3.retainAll(setElements4);        
        
        System.debug(setElements1);
    }
    public static void clearMethod(){
        list<integer>intlist = new list<integer>{10,12,11,15,25};
            system.debug(intlist);
        //intlist.clear();
        intlist.remove(1);
        
        system.debug(intlist);
    }
    public static void setMethod15(){
        set<integer>intlist1 = new set<integer>{10,20,30,40,50,60,70};
            set<integer>intlist2 = new set<integer>{10,20,30,40};
              intlist1.retainAll(intlist2);             //this statement will only keep common elements between two sets.

        system.debug(intlist1);
            
    }
    public static void mapMethod16(){
        
        map<integer,string>mapcollectinon = new map<integer,string>();
        mapcollectinon.put(07,'Dhoni');
        mapcollectinon.put(18,'Virat');
        mapcollectinon.put(45,'Rohit');
        mapcollectinon.put(03,'Mithali');
        mapcollectinon.put(180,'Mandhana');
        mapcollectinon.put(69,'Priya');
        
       // System.debug('Map elements are : '+mapcollectinon);
        
        Set<integer> mapKeys = mapcollectinon.keyset();            //Assigning keySet() result to a Set
       // System.debug('Map keys are : '+mapcollectinon.keySet());   //Use of .keySet() method

                                                                     //Iterating keySet() result
        for(integer jn :mapcollectinon.keyset()){
            system.debug(jn);
        }                                                        
        List<String> mapValues = mapcollectinon.values();     //Assigning values to list      
        //System.debug('List values are : '+mapValues);        //Use of values() method     
        
        for(string pn:mapcollectinon.values()){
            system.debug(pn);
        }
        
        
        
        map<integer,string>mapcollectinon2 = new map<integer,string>{07=>'Dhoni', 18=>'Virat', 45=>'Rohit', 03=>'Mithali',69=>'Priya'};
            
           // System.debug('Map elements are : '+mapcollectinon2);
        
         if(mapcollectinon2.containsKey(07)) {
            System.debug('Value is present');
        } else {
            System.debug('Value is not present');
        }
		System.debug(mapcollectinon2.get(18));

        
        map<integer,string>clonemap = mapcollectinon2.clone();      //clone()==>Used to make a duplicate copy of a map
			 clonemap.clear();

       system.debug(clonemap);
        
        
        
    }
    Public static void mapListCombination(){
        
        Map<String, List<String>>mapList = new Map<String, List<String>>();
        
        mapList.put('akash', new List<string>{'a','k','a','s','h'});
        mapList.put('swati', new List<string>{'s','w','a','t','i'});
          system.debug(mapList);
        for(string str1:mapList.keySet()){
            
            system.debug(str1);
        }
       List<List<string>> valueList = mapList.Values();
        
       
        
    }

}