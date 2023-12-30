Public class TestClass {
    
    public void myMethod(){
        list<Contact>conList = [SELECT Id, Name, Email, Phone FROM Contact WHERE Email != null AND Phone != null LIMIT 1];
        for(Contact con : conList){
            system.debug(con.Name);
        }
    }

}