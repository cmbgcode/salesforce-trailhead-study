@isTest
private class AccountProcessorTest {
    @TestSetup
    static void makeData(){
        Account accTest = new Account(Name = 'Testing Account');
        insert accTest;

        List<Contact> ctcs = new List<Contact>{ new Contact(LastName = 'Contact1', AccountId = accTest.id),
                                                new Contact(LastName = 'Contact2', AccountId = accTest.id)};
        insert ctcs;
        
    }

    @isTest
    static void myUnitTest() {
        
        List<Account> accResult = [Select Name,Number_Of_Contacts__c from Account WHERE Name='Testing Account'];
        Assert.areEqual(null, accResult[0].Number_Of_Contacts__c);

        Map<id,Account> accMap = new Map<id,Account>(accResult);
        List<Id> ids = new List<Id>(accMap.keySet());

        Test.startTest();
        AccountProcessor.countContacts(ids);
        Test.stopTest();

        accResult = [Select Name,Number_Of_Contacts__c from Account WHERE Name='Testing Account'];
        Assert.areEqual(2, accResult[0].Number_Of_Contacts__c);
    }
}