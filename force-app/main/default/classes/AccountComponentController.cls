public with sharing class AccountComponentController {

    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(String accId) {
        return [
            SELECT AccountId, Id, FirstName, LastName, Title, Phone, Email
            FROM Contact
            WHERE AccountId = :accId
            WITH SECURITY_ENFORCED
        ];
    }
}