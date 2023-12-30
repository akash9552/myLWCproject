public class sObjectClass {
    public static void myMethod(){
        Account accObj = new Account();
        accObj.ID = '0015i00000PJFcbAAH';
        accObj.Rating = 'Worm';
        accObj.Name = 'Account created using Apex class';
		accObj.Phone = '9552229822';
		accObj.Site = 'www.acc.com';
        accObj.ShippingCity = 'pune';
        accObj.ShippingPostalCode = '411043';
        accObj.ShippingState = 'MH';
        accObj.ShippingCountry = 'IND';
        accObj.ShippingStreet = 'Satara highway';
            
       // accObj.ShippingAddress = 'pune';
        insert accObj;
       system.debug(accObj);
    }
}