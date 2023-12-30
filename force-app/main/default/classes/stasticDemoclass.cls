public class stasticDemoclass{
    
    public Integer normalVar = 0;
    public Static Integer staticVar = 0;
    public void myMetod(){
        normalVar = normalVar+10;
        staticVar = staticVar+10;
        
        System.debug('normal variable is : '+normalVar);
        System.debug('static variable is : '+staticVar);
    }
    
}