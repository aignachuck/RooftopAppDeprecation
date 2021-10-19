public inherited sharing class PortfolioSiteController2 {
    
    @AuraEnabled(cacheable=true)
    public static List<Site__c> getSites(String portfolioId){
        
        return [SELECT  Id, 
                            Name, 
                            Tower_Name__c, 
                            Tower_Class__c, 
                            Real_Estate_Portfolio__r.Id,
                            //Real_Estate_Portfolio__c,
                            //Real_Estate_Portfolio__r.Name,                            
                            Ownership_Change_in_Process__c,
                            Negotiations_in_Progress__c,
                            Do_Not_Contact_LL_REAM__c, 
                            CreatedDate 
                    FROM 
                            Site__c 
                    WHERE 
                            Real_Estate_Portfolio__c = :portfolioId 
                    WITH 
                            SECURITY_ENFORCED];
    }

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
        }}
    
}
