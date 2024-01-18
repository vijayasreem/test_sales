Here's an example of a Salesforce trigger code that fulfills the user story you described:

```apex
trigger AccountHistoryTrigger on Account (after update) {
    public static List<Map<String, Object>> getAccountHistory(String accountNumber) {
        List<Map<String, Object>> transactionHistory = new List<Map<String, Object>>();
        
        Account account = [SELECT Id, Name, AccountNumber FROM Account WHERE AccountNumber = :accountNumber];
        
        if (account != null) {
            List<Transaction__c> transactions = [SELECT Id, Name, Amount, Date FROM Transaction__c WHERE Account__c = :account.Id];
            
            for (Transaction__c transaction : transactions) {
                Map<String, Object> transactionDetails = new Map<String, Object>();
                transactionDetails.put('Id', transaction.Id);
                transactionDetails.put('Name', transaction.Name);
                transactionDetails.put('Amount', transaction.Amount);
                transactionDetails.put('Date', transaction.Date);
                
                transactionHistory.add(transactionDetails);
            }
        }
        
        return transactionHistory;
    }
}

// Usage example:
List<Map<String, Object>> history = AccountHistoryTrigger.getAccountHistory('1234567890');
System.debug(history);
