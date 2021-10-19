public with sharing class PortfoliowNotesCloneController {

    public Real_Estate_Portfolio__c portfolio {get; set;}

    private ApexPages.StandardController ctrl;

    public PortfoliowNotesCloneController(ApexPages.StandardController controller) {
        ctrl = controller;       

    }

    public PageReference PortfolioClone(){

        Id portfolioId = ctrl.getId();

        List<Portfolio_Note__c> notesList = new List<Portfolio_Note__c>();        

        Real_Estate_Portfolio__c vREP = [SELECT Id, Name, Relationship_Name__c, Portfolio_Name__c, Portfolio_Number__c FROM Real_Estate_Portfolio__c WHERE Id = :portfolioId];       

        notesList = [SELECT Id, Name, Note_Text__c, Note_Category__c, Associated_Portfolio__r.Id FROM Portfolio_Note__c WHERE Associated_Portfolio__r.Id = :vREP.Id];

        Real_Estate_Portfolio__c clonedREP = vREP.clone(false, false, false, false); 
        insert clonedREP; 
        
        Real_Estate_Portfolio__c newREP = [SELECT Id, Name, Relationship_Name__c, Portfolio_Name__c, Portfolio_Number__c FROM Real_Estate_Portfolio__c WHERE Id = :clonedREP.Id];

        List<Portfolio_Note__c> clonedNotes = new List<Portfolio_Note__c>(); for (Portfolio_Note__c vNote : notesList) {
        Portfolio_Note__c clonedNote = vNote.clone(false, false, false, false);
        clonedNote.Associated_Portfolio__c = newREP.Id;
        clonedNotes.add(clonedNote);
        }

        insert clonedNotes;
        return new PageReference('/' + clonedREP.Id);
    }   

    
}
