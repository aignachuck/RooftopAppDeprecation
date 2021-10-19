public with sharing class RooftopPortfolioCloneController {
    
    public Real_Estate_Portfolio__c portfolio {get; set;}

    private ApexPages.StandardController ctrl;

    public RooftopPortfolioCloneController(ApexPages.StandardController controller) {
        ctrl = controller;       

    }

    public PageReference PortfolioClone() {

        Id portfolioId = ctrl.getId();

        Id noteRecordTypeId = Schema.Sobjecttype.Real_Estate_Portfolio__c.getRecordTypeInfosByDeveloperName().get('Portfolio_Notes').getRecordTypeId();
        system.debug('Portfolio Notes RecordTypeId is: ' + noteRecordTypeId);

        List<Real_Estate_Portfolio__c> notesList = new List<Real_Estate_Portfolio__c>();        

        Real_Estate_Portfolio__c vREP = [SELECT Id, 
                                                Name, 
                                                Relationship_Name__c, 
                                                Portfolio_Name__c,
                                                Agreement_Rights__c,
                                                Portfolio_Status__c,
                                                Owner_Entity__c,
                                                Commencement_Date__c,
                                                Exclusive_Marketing_Rights__c,
                                                Manage_Pre_Existing__c,
                                                Form_Asset_Lease__c,
                                                Form_Tenant_Lease__c,
                                                Revenue_Share_to_LL_for_New_License__c,
                                                Revenue_Share_to_LL_for_Existing_License__c,
                                                Revenue_Share_Qualifier_Information__c,
                                                Does_ATC_Hold_Tenant_s_Security_Deposit__c,
                                                Does_Owner_Hold_ATC_s_Security_Deposit__c,
                                                Procurement_Fee_Needed_for_New_Leases__c,
                                                Procurement_Fee_Needed_for_Amendments__c,
                                                Procurement_Fee_Needed_for_AMD_on_P_E__c,
                                                Number_of_Renewals__c,
                                                Is_Agreement_Month_to_Month__c,
                                                Unlimited_Renewals__c,
                                                Cancellation_Effective_Date__c,
                                                Renewal_Term__c,
                                                Renewal_Term_Variable__c,
                                                Type_of_Renewal__c,
                                                Last_Renewal_Notification_Date__c,
                                                Date_Current_Term_Ends__c,
                                                Initial_Terms_Months__c,
                                                Fixed_Final_Expiration_Date__c,
                                                Number_of_Days_for_Prior_Renewal_Notice__c,
                                                Termination_by_Owner_LL_for_Cause__c,
                                                Termination_by_Owner_LL_for_Convenience__c,
                                                Termination_by_Owner_LL_Due_to_Sale__c,
                                                Early_Termination_Rights_Manager_Tenant__c,
                                                Early_Termination_Notice_Manager_Tenant__c,
                                                Termination_Fee_Formula__c,
                                                Performance_Test__c,
                                                Performance_Test_Date__c,
                                                Revenue_Targets__c,
                                                If_Revenue_Targets_Amount_Per_Year__c,
                                                Right_to_Residual_Fees__c,
                                                Is_the_Residual_Percentage_Variable__c,
                                                Residual_Rights__c,
                                                Residual_Percentage__c,
                                                Approved_Tenant_License_Template__c,
                                                Special_Arrangements__c,
                                                Approved_Asset_License_Template__c,
                                                Service_Type__c,
                                                ATC_Required_to_Inspect_the_Rooftop__c,
                                                Pre_Existing_Services_Type__c,
                                                DAS_Services__c,
                                                Does_ATC_Collect_the_Rent__c,
                                                Remittance_Requirement__c,
                                                ATC_Right_to_Assign__c,
                                                Post_Termination_Language__c,
                                                Changing_Revenue_Share__c,
                                                Annual_Analysis__c,
                                                Budget__c,
                                                Leasing_Overview__c,
                                                Rent_Roll__c,
                                                True_Up__c,
                                                Remittance_Report__c,
                                                Method_of_Remit_Being_Sent__c,
                                                Special_Report_Comments_and_Contacts__c,
                                                Bill_Owner__c                                                
                                                FROM Real_Estate_Portfolio__c WHERE Id = :portfolioId];       

        notesList = [SELECT Id, 
                            Name, 
                            Portfolio_Note_Text__c, 
                            Note_Category__c, 
                            Real_Estate_Portfolio_Notes__r.Id, 
                            RecordTypeId FROM Real_Estate_Portfolio__c WHERE Real_Estate_Portfolio_Notes__r.Id = :vREP.Id AND  RecordTypeId = :noteRecordTypeId];

        Real_Estate_Portfolio__c clonedREP = vREP.clone(false, false, false, false); 
        insert clonedREP; 
        
        Real_Estate_Portfolio__c newREP = [SELECT Id, 
                                                  Name, 
                                                  Relationship_Name__c, 
                                                  Portfolio_Name__c, 
                                                  Agreement_Rights__c,
                                                  Portfolio_Status__c,
                                                  Owner_Entity__c,
                                                  Commencement_Date__c,
                                                  Exclusive_Marketing_Rights__c,
                                                  Manage_Pre_Existing__c,
                                                  Form_Asset_Lease__c,
                                                  Form_Tenant_Lease__c,
                                                  Revenue_Share_to_LL_for_New_License__c,
                                                  Revenue_Share_to_LL_for_Existing_License__c,
                                                  Revenue_Share_Qualifier_Information__c,
                                                  Does_ATC_Hold_Tenant_s_Security_Deposit__c,
                                                  Does_Owner_Hold_ATC_s_Security_Deposit__c,
                                                  Procurement_Fee_Needed_for_New_Leases__c,
                                                  Procurement_Fee_Needed_for_Amendments__c,
                                                  Procurement_Fee_Needed_for_AMD_on_P_E__c,
                                                  Number_of_Renewals__c,
                                                  Is_Agreement_Month_to_Month__c,
                                                  Unlimited_Renewals__c,
                                                  Cancellation_Effective_Date__c,
                                                  Renewal_Term__c,
                                                  Renewal_Term_Variable__c,
                                                  Type_of_Renewal__c,
                                                  Last_Renewal_Notification_Date__c,
                                                  Date_Current_Term_Ends__c,
                                                  Fixed_Final_Expiration_Date__c,
                                                  Number_of_Days_for_Prior_Renewal_Notice__c,
                                                  Termination_by_Owner_LL_for_Cause__c,
                                                  Termination_by_Owner_LL_for_Convenience__c,
                                                  Termination_by_Owner_LL_Due_to_Sale__c,
                                                  Early_Termination_Rights_Manager_Tenant__c,
                                                  Early_Termination_Notice_Manager_Tenant__c,
                                                  Termination_Fee_Formula__c,
                                                  Performance_Test__c,
                                                  Performance_Test_Date__c,
                                                  Revenue_Targets__c,
                                                  If_Revenue_Targets_Amount_Per_Year__c,
                                                  Right_to_Residual_Fees__c,
                                                  Is_the_Residual_Percentage_Variable__c,
                                                  Residual_Rights__c,
                                                  Residual_Percentage__c,
                                                  Approved_Tenant_License_Template__c,
                                                  Special_Arrangements__c,
                                                  Approved_Asset_License_Template__c,
                                                  Service_Type__c,
                                                  ATC_Required_to_Inspect_the_Rooftop__c,
                                                  Pre_Existing_Services_Type__c,
                                                  DAS_Services__c,
                                                  Does_ATC_Collect_the_Rent__c,
                                                  Remittance_Requirement__c,
                                                  ATC_Right_to_Assign__c,
                                                  Post_Termination_Language__c,
                                                  Changing_Revenue_Share__c,
                                                  Annual_Analysis__c,
                                                  Budget__c,
                                                  Leasing_Overview__c,
                                                  Rent_Roll__c,
                                                  True_Up__c,
                                                  Remittance_Report__c,
                                                  Method_of_Remit_Being_Sent__c,
                                                  Special_Report_Comments_and_Contacts__c,
                                                  Bill_Owner__c
                                                  FROM Real_Estate_Portfolio__c WHERE Id = :clonedREP.Id];

        List<Real_Estate_Portfolio__c> clonedNotes = new List<Real_Estate_Portfolio__c>(); 
        
        for (Real_Estate_Portfolio__c vNote : notesList) {
            Real_Estate_Portfolio__c clonedNote = vNote.clone(false, false, false, false);
            clonedNote.Real_Estate_Portfolio_Notes__c = newREP.Id;
            clonedNotes.add(clonedNote);
        }

        insert clonedNotes;
        return new PageReference('/' + clonedREP.Id);
    }
}
