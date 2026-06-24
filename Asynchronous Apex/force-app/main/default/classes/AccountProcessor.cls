public with sharing class AccountProcessor {
    
    @future
    public static void countContacts(List<Id> accIds) {
        
        List<Account> updtAccs = new List<Account>();

        List<Account> accs = [Select ID,
                                (Select Id from Contacts)
                                from Account WHERE ID in :accIds];
        
        for(Account a: accs){

            a.Number_Of_Contacts__c = a.Contacts.size();
            updtAccs.add(a);
        }

        if(!updtAccs.isEmpty()){
            upsert updtAccs;
        }
    }
}