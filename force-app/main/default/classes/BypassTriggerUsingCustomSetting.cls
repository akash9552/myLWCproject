public class BypassTriggerUsingCustomSetting {
    //using trigger make account number field required
    public static void bypassValidation(List<Account>accnewList){
        
        for(Account acc : accnewList){
            if( acc.AccountNumber == null){
                acc.addError(Account.AccountNumber,'AccountNumber is mandatory');
            }
        }
    }
}