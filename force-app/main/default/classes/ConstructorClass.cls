public class ConstructorClass {
    
     
    
    public static void  additionMethod(){
      integer num1= 55; 
    integer num2= 44;
        integer num3 = num1+num2;
        
        system.debug(num3);
      
    }
    
    public static void printNaturalNumber(){
        integer i;
        
        for(i=0; i<=10; i++){
            system.debug(i);
        }
    }
    public static void prinEvenNumber( ){
       
        integer i;
        
        for(i=0; i<=100; i++){
            if(0 == math.mod(i, 2)){
                system.debug(i);
            }
        }
    }
    
     public static void prinOddNumber( ){
       
        integer i;
        
        for(i=0; i<=100; i++){
            if(0 != math.mod(i, 2)){
                system.debug(i);
            }
        }
    }
    
     public static void printPrimeNumber( ){
         
         integer x=0;
         for(x=0;x<10;x++){
             
             integer count=0;
             integer y=0;
             for( y=x; y>=1;y--){
                 if(math.mod(x,y)==0 ){
                     count++;
                 }
             }
             if(count==2 || count==1){
                 system.debug(x);
             }                     
         }
     }
    
   
}