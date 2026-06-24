public with sharing class LeadProcessor implements Database.Batchable<SObject>{
    
    public Database.QueryLocator start(Database.BatchableContext bc){
        return Database.getQueryLocator('SELECT ID FROM Lead');

    }

    public void execute(Database.BatchableContext bc, List<Lead> leads){
        
        List<Lead> updtLeads = new List<Lead>();

        for(Lead l : leads){
            l.LeadSource = 'Dreamforce';
            updtLeads.add(l);
        }

        if(!updtLeads.isEmpty()){
            update as user updtLeads;
        }

    }

    public void finish(Database.BatchableContext bc){

    }
}