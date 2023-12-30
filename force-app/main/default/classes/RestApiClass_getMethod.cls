@RestResource(urlmapping='/accountCreationuseget/*')
global class RestApiClass_getMethod {

    @HttpGet
    global static string myGetMethod(){
        
        RestRequest request = RestContext.request;
        
        Map<string, string> urlmap = request.params;
        
        system.JSONGenerator js = JSON.createGenerator(true);
        js.writeStartObject();
        
        Try{
            Account acc=new Account();
            acc.Name =urlmap.get('name');
            acc.Phone =urlmap.get('phone');
            acc.Industry=urlmap.get('industry');
            insert acc;
            
            js.writeStringField('status','sucess');
              js.writeStringField('AccountId',acc.Id);
            
        }catch(exception e){
            js.writeStringField('status','failed');
              js.writeStringField('AccountId',e.getMessage());
        }
        
        js.writeEndObject();
        
        string result = js.getAsString();
        return result;
        
    }
}