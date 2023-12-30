public class CollectionClass{
    public static void mapCollection(){
        Map<Integer,string>mapExample = new Map<Integer,string>();
        mapExample.put(18,'Virat');
        mapExample.put(07,'Dhoni');
        mapExample.put(45,'Rohit');
        mapExample.put(01,'Rahul');
        mapExample.put(15,'Virat');
        for(string str:mapExample.values()){
            system.debug(+str);
        }
    }
    
    /*
Create a list of 1 to 100 integers (add these numbers using for loop). Print only the numbers which are divisible by 5. 
Hint:- You’ll need to use 2 for loops here (1st normal for loop for adding 1 to 100 numbers. 2nd forEach loop for printing).
   */
    Public static void collectionMethod(){
        
        List<Integer> intList = new List<Integer>();
      
        for(integer i=0; i<=100; i++){
            intList.add(i);
        }
            system.debug(intList);
        system.debug('list size is :'+intList.size());
        for(integer intvar :intList){
            
            if(Math.mod(intvar,5)==0){
                system.debug(intvar);
            }
        }
    } 
    
    /*
     Create a Integer list, name it as “randomNumbers” add (50,90,80,60,20,30,40,70,10,100)
random shuffled numbers to it. Create another Integer list, name that list as “descendingOrderList” add
all the numbers from “randomNumbers” list to this new list in descending order. (100, 90, 80, 70, 60, 50, 40, 30, 20, 10)
Hint:- You’ll need to use our normal for loop here once. And run that for loop in reverse manner 
(Reverse manner means start it from list.size()-1 rather than starting it from 0).
     */
    Public static void myMethod(){
        
        List<Integer> randomNumber = new List<Integer>{50,90,60,80,20,30,40,70,10,100};
            
            List<Integer> decendingList = new List<Integer>();
        randomNumber.sort();
        
        for(integer i=randomNumber.size()-1 ; i>=0; i-- ){
            decendingList.add(randomNumber[i]);
        }
        system.debug(decendingList);
    }
    
    // map always take uniqe key and one value which is updated
    Public static void myMapMethod(){
        
        Map<String, string> newmap = new Map<String, string>();
        
        newmap.put('key1','Akash');
        newmap.put('key1','Akash Gutte');
        newmap.put('key2','Radhika');
         newmap.put('key3','Akash');
        
        system.debug(newmap);
    }
    
    // keySet() always give key value
    public static void keyMethod(){
        
        
        
        Map<Id, Account> accMap = new Map<Id, Account>([select Id, Name from Account]);
        
        List<Account> accList =accMap.Values();
        set<Id> accId =accMap.keyset();
        
        system.debug('the Account id set is :'+accMap.keySet());
        system.debug('the value of Acc Map is:'+accMap.values());
        
        for(Id str :accMap.keySet()){
            system.debug(str);
        }
         for(Account acc :accMap.Values()){
            system.debug(acc.Name);
        }
    }
}