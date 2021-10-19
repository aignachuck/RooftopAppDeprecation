@isTest
public class PortfolioSiteController_Test {
    
    public static TestMethod void PortfolioSiteTest1() {

        Real_Estate_Portfolio__c testPortfolio = new Real_Estate_Portfolio__c();
        testPortfolio.RecordTypeId = '0120d000000YLLYAA4';
        testPortfolio.Name = 'Test Portfolio';

        insert testPortfolio;

        Site__c testSite = new Site__c();
        testSite.RecordTypeId = '01260000000UCVFAA4';
        testSite.Name = '123789';
        testSite.Tower_Name__c = 'Test Site';
        testSite.Tower_Class__c = 'Rooftop';        
        testSite.Ownership_Change_in_Process__c = false;
        testSite.Real_Estate_Portfolio__c = testPortfolio.Id;
        testSite.Negotiations_in_Progress__c = false;
        testSite.Do_Not_Contact_LL_REAM__c = false;        

        Insert testSite;

        Test.StartTest();        
        PortfolioSiteController.getSites(testPortfolio.Id);
        Test.StopTest();
    }

    public static TestMethod void PortfolioSiteTest2() {

        Real_Estate_Portfolio__c testPortfolio = new Real_Estate_Portfolio__c();
        testPortfolio.RecordTypeId = '0120d000000YLLYAA4';
        testPortfolio.Name = 'Test Portfolio';

        insert testPortfolio;

        Site__c testSite = new Site__c();
        testSite.RecordTypeId = '01260000000UCVFAA4';
        testSite.Name = '123789';
        testSite.Tower_Name__c = 'Test Site';
        testSite.Tower_Class__c = 'Rooftop';        
        testSite.Ownership_Change_in_Process__c = false;
        testSite.Real_Estate_Portfolio__c = testPortfolio.Id;
        testSite.Negotiations_in_Progress__c = false;
        testSite.Do_Not_Contact_LL_REAM__c = false;        

        Insert testSite;

        String searchKey = '123789';

        Test.StartTest();        
        PortfolioSiteController.searchedSites(testPortfolio.Id, searchKey);
        Test.StopTest();

    }

    public static TestMethod void PortfolioSiteTest3() {

        Real_Estate_Portfolio__c testPortfolio = new Real_Estate_Portfolio__c();
        testPortfolio.RecordTypeId = '0120d000000YLLYAA4';
        testPortfolio.Name = 'Test Portfolio';

        insert testPortfolio;

        Site__c testSite = new Site__c();
        testSite.RecordTypeId = '01260000000UCVFAA4';
        testSite.Name = '123789';
        testSite.Tower_Name__c = 'Test Site';
        testSite.Tower_Class__c = 'Rooftop';        
        testSite.Ownership_Change_in_Process__c = false;
        testSite.Real_Estate_Portfolio__c = testPortfolio.Id;
        testSite.Negotiations_in_Progress__c = false;
        testSite.Do_Not_Contact_LL_REAM__c = false;        

        Insert testSite;

        String searchKey = '456';
        AuraHandledException auraEx;

        Test.StartTest();        
        try {
            PortfolioSiteController.searchedSites(testPortfolio.Id, searchKey);
        } catch (Exception e ) {
            system.debug('Test Exception Caught!');
        }                
        Test.StopTest();
    }

    public static TestMethod void PortfolioSiteTest4() {

        Real_Estate_Portfolio__c testPortfolio = new Real_Estate_Portfolio__c();
        testPortfolio.RecordTypeId = '0120d000000YLLYAA4';
        testPortfolio.Name = 'Test Portfolio';

        insert testPortfolio;

        Site__c testSite = new Site__c();
        testSite.RecordTypeId = '01260000000UCVFAA4';
        testSite.Name = '123789';
        testSite.Tower_Name__c = 'Test Site';
        testSite.Tower_Class__c = 'Rooftop';        
        testSite.Ownership_Change_in_Process__c = false;
        testSite.Real_Estate_Portfolio__c = testPortfolio.Id;
        testSite.Negotiations_in_Progress__c = false;
        testSite.Do_Not_Contact_LL_REAM__c = false;        

        Insert testSite;
        List <Site__c> siteList = new List<Site__c>();
        siteList.add(testSite);
        Object data = siteList;

        Test.StartTest();        
        PortfolioSiteController.updateSites(data);
        Test.StopTest();
    }
}
