@RestResource(urlmapping='/accountCreation/*')
Global class RestApiClass_inbondIntegration {
    
    @HttpPost
    Global static string callmeMethod(string name, string phone, string industry){
        JSONGenerator jsGen = JSON.createGenerator(true);
        jsGen.writeStartObject();  
        try{
            Account acc =new Account();
            acc.Name = name;
            acc.Phone = phone;
            acc.Industry =industry;
            insert acc;
            jsGen.writeStringfield('status','sucess');
            jsGen.writeStringfield('AccountId','acc.Id');
            
        }catch(Exception e){
            
            jsGen.writeStringfield('status','faild'); 
            jsGen.writeStringfield('Account Id',e.getMessage());
        }
        
        jsGen.writeEndObject();
        string result =jsGen.getAsString();
        return result;
        
    }
    
}