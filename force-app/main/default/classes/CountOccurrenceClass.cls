public class CountOccurrenceClass {
    
    
    Public static void countMethod(String str) {
        
        String[] strwords = str.split(' ');
        
                           //using this we split the input string into an array of individual words.
        
        Map<String, Integer> StringIntegerMap = new Map<String, Integer>();
        
                           // here we use map of <string, Integer> because they come with key valu pair and key is unique
        
        for (String term : strwords) {            
            
            term = term.toLowerCase();        // usnig this we Convert to lowercase for case-insensitive counting
            
            if (!StringIntegerMap.containsKey(term)) { // here we check for each term so that it is uinque
                
                StringIntegerMap.put(term, 1);    
            } else {
                Integer count = StringIntegerMap.get(term); // if repeated term come they continue with else block with count rise by 1
                StringIntegerMap.put(term, count + 1);
            }
        }
        
        for (String word : StringIntegerMap.keySet()) {
            
                           // here we iterating on keySet of map and get result for unique and repetation
            
            Integer count = StringIntegerMap.get(word);
            System.debug(word + ' : ' + count);
        }
    }
}