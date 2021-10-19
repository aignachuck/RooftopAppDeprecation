trigger RooftopNotesTrigger on Real_Estate_Portfolio__c (before insert, before update) {

/*
-Get currently selected Portfolio Id
-Get list of Notes attached to that Portfolio
-Read through list of Notes attached to Portfolio, looking for Category = Current Category
-If found, throw an error
-If not found, allow the insert/update
*/

Id accountId = trigger.new[0].Real_Estate_Portfolio_Notes__c;
system.debug('Retrived Account Id: ' + accountId);

Id noteRecordTypeId = Schema.Sobjecttype.Real_Estate_Portfolio__c.getRecordTypeInfosByDeveloperName().get('Portfolio_Notes').getRecordTypeId();
system.debug('Portfolio Notes RecordTypeId is: ' + noteRecordTypeId);

String noteCategory = trigger.new[0].Note_Category__c;
system.debug('Note Category is: ' + noteCategory);

List <Real_Estate_Portfolio__c> notesList = new List<Real_Estate_Portfolio__c>();

notesList = [SELECT Id, 
                    Name, 
                    Portfolio_Note_Text__c, 
                    Note_Category__c, 
                    Real_Estate_Portfolio_Notes__r.Id, 
                    RecordTypeId 
            FROM 
                    Real_Estate_Portfolio__c 
            WHERE 
                    Real_Estate_Portfolio_Notes__r.Id = :accountId 
            AND 
                    RecordTypeId = :noteRecordTypeId
            AND
                    Note_Category__c = :noteCategory];


system.debug('List of Notes: ' + notesList);

try {
        if(notesList.size() > 0){

        }
} catch (Exception e) {
        system.debug('Caught exception: ' + e);
        
}

for (Real_Estate_Portfolio__c note : notesList) {
    if (note.Note_Category__c == noteCategory) {
        try {
                Real_Estate_Portfolio__c newNote = trigger.newMap.get(note.Id);
                newNote.addError('A note of this category already exists on this Portfolio. Please update the existing note or select a different category.');  
                
        } catch (Exception e) {
                system.debug('Caught exception: ' + e);                
        }              
    } else {
            system.debug('Insert Successful!');
    }
}


/*

new Real_Estate_Portfolio__c portfolio;
new Short initTermMonths = Initial_Term_Months__c;
new Date commencement = Commencement_Date__c;
new Date today = Today();
new Short numRenewals = Number_of_Renewals__c;
new Short renewalMonths = Renewal_Term__c;
new Date initTermEnd = commencement.addMonths(initTermMonths);
new Short renewalTerm;
new Short totalMonths;
new Date currentTermEnd;

If(today < initTermEnd){
        currentTermEnd = initTermEnd;
} else {
        for(i=0; today > currentTermEnd; i++){
                loop through each term, evalute if today is < end of term, exit when true
                renewalTerm = i;
                totalMonths = (renewalTerm * renewalMonths);
                currentTermEnd = initTermEnd.addMonths(totalMonths);
                i = i+1;

        }
}

portfolio.Date_Current_Term_Ends__c = currentTermEnd;

update portfolio;



*/


}