public with sharing class DeleteContact {
    public DeleteContact() {

    }
    Public static void deleteContact(){
        List<Contact> conDelet =new List<Contact>();
        
        for(Contact con : [select Id from Contact where Phone ='1000000000']){
            conDelet.add(con);
        }
        system.debug(conDelet);
        if(!conDelet.isEmpty()){
            delete conDelet;
        }
}