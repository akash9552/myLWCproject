public class AsynchClass {
	@Future
    Public static void deleteAccRecord(Set<Id> accountiDset){
        delete[SELECT Id FROM Contact WHERE AccountId IN :accountiDset];
    }
}