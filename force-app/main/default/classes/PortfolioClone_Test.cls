@isTest
public class PortfolioClone_Test {

    public static TestMethod void PortfolioClone_Test() {

        Id noteRecordTypeId = Schema.Sobjecttype.Real_Estate_Portfolio__c.getRecordTypeInfosByDeveloperName().get('Portfolio_Notes').getRecordTypeId();

        Real_Estate_Portfolio__c testPortfolio = new Real_Estate_Portfolio__c();
        testPortfolio.RecordTypeId = '0120d000000YLLYAA4';
        testPortfolio.Name = 'Test Portfolio';

        Insert testPortfolio;

        Real_Estate_Portfolio__c portfolioNote1 = new Real_Estate_Portfolio__c();
        portfolioNote1.RecordTypeId = noteRecordTypeId;
        portfolioNote1.Note_Category__c = 'Amendment';
        portfolioNote1.Name = 'Test Note 1';
        portfolioNote1.Real_Estate_Portfolio_Notes__c = testPortfolio.Id;
        portfolioNote1.Portfolio_Note_Text__c = 'Testing';

        Insert portfolioNote1;
        ApexPages.StandardController controller = new ApexPages.StandardController(testPortfolio);

        PageReference pageRef = new ApexPages.StandardController(testPortfolio).view();

        //RooftopPortfolioCloneController ctrl = new RooftopPortfolioCloneController(new ApexPages.StandardController(Real_Estate_Portfolio__c));
        //RooftopPortfolioCloneController ctrl = new RooftopPortfolioCloneController.RooftopPortfolioCloneController(controller);
        RooftopPortfolioCloneController ctrl = new RooftopPortfolioCloneController(controller);

        Test.startTest();
        
        Test.setCurrentPage(pageRef);
        ctrl.PortfolioClone();

        Test.stopTest();

    }
}
