public inherited sharing class PortfolioSiteController {    
    

    //Used to pull Sites associated with a Portfolio
    @AuraEnabled(cacheable=true)
    public static List<Site__c> getSites(String portfolioId){                           
                                                                           
        return [SELECT  Id, 
                        Name, 
                        Tower_Name__c, 
                        Tower_Class__c, 
                        Real_Estate_Portfolio__r.Id,                                                        
                        Ownership_Change_in_Process__c,
                        Negotiations_in_Progress__c,
                        Do_Not_Contact_LL_REAM__c, 
                        CreatedDate 
                FROM 
                        Site__c 
                WHERE 
                        Real_Estate_Portfolio__c = :portfolioId                                     
                WITH 
                        SECURITY_ENFORCED
                ORDER BY
                        Name ASC];
    }
   
    //Used with the defunct Search feature to search for an entered String
    @AuraEnabled(cacheable=true)    
    public static List<Site__c> searchedSites(String portfolioId, String searchKey){
        system.debug('Portfolio Id is: ' + portfolioId);
        system.debug('Search input is: ' + searchKey);
        String searchKeyword = '%' + searchKey + '%';        
        
        List<Site__c> returnedSites = new List<Site__c>();
        system.debug('Search Keyword is: ' + searchKeyword);

        for(Site__c siteObj: [SELECT Id, Name, Tower_Name__c, Tower_Class__c, Real_Estate_Portfolio__r.Id, Ownership_Change_in_Process__c
                            FROM Site__c
                            WHERE Name LIKE :searchKeyword
                            AND Real_Estate_Portfolio__c = :portfolioId]){
                                returnedSites.add(siteObj);
                            }

        if(returnedSites.size() == 0){
            throw new AuraHandledException('No Record Found...');
        }

        system.debug('Returned Sites equals: ' + returnedSites);

        return returnedSites;
    }
    
    //Used with Save function to update the Sites that were edited in the list
    @AuraEnabled
    public static string updateSites(Object data) {
        List<Site__c> sitesForUpdate = (List<Site__c>) JSON.deserialize(
            JSON.serialize(data),
            List<Site__c>.class
        );
        try {
            update sitesForUpdate;
            return 'Success: Sites updated successfully';
        }
        catch (Exception e) {
            return 'The following exception has occurred: ' + e.getMessage();
        }
    }
        
}
    