trigger CaseRooftopOwnershipTrigger on Case (after insert, after update) {

    Id siteId = trigger.old[0].Site_Number__c;

    if (condition) {
        
    }

}