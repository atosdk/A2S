public with sharing class A2S_UserController {
    @AuraEnabled(cacheable=true)
    public static List<User> getBirthdays(Integer month){
        
        return [
                SELECT Id, Name, DOB__c
                FROM User
                WHERE CALENDAR_MONTH(DOB__c) = :month
                WITH SECURITY_ENFORCED
            ];
    }

    @AuraEnabled(cacheable=true)
    public static List<User> getAnniversaries(Integer month){
        
        return [
                SELECT Id, Name, Employment_Start_Date__c
                FROM User
                WHERE CALENDAR_MONTH(Employment_Start_Date__c) = :month
                WITH SECURITY_ENFORCED
            ];
    }
}