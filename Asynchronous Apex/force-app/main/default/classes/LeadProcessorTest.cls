@isTest
private class LeadProcessorTest {

    @TestSetup
    static void insertLeads(){
        List<Lead> leads = new List<Lead>();
        for(Integer i=0; i<200; i++){
            Lead l = new Lead(LastName='Lead'+i,Status='Open - Not Contacted',Company='Acme'+0);
            leads.add(l);
        }

        insert leads;
        
    }

    @isTest
    static void testingLeadProcessor() {
        Test.startTest();
        LeadProcessor leadProcessor = new LeadProcessor();
        Id batchId = Database.executeBatch(leadProcessor);
        Test.stopTest();

        Assert.areEqual(200,[SELECT COUNT() FROM Lead WHERE LeadSource='Dreamforce']);
    }
}