public with sharing class A2S_UserController {
  @AuraEnabled(cacheable=true)
  public static List<User> getBirthdays(Integer month, String team) {
    //test pass args in get birthday
    return [
      SELECT Id, Name, DOB__c, Team__c
      FROM User
      WHERE CALENDAR_MONTH(DOB__c) = :month AND Team__c = :team
      WITH SECURITY_ENFORCED
    ];
  }

  @AuraEnabled(cacheable=true)
  public static List<User> getAnniversaries(Integer month, String team) {
    return [
      SELECT Id, Name, Employment_Start_Date__c, Team__c
      FROM User
      WHERE
        CALENDAR_MONTH(Employment_Start_Date__c) = :month
        AND Team__c = :team
      WITH SECURITY_ENFORCED
    ];
  }

  // @AuraEnabled(cacheable=true)
  // public static List<User> getTeam(String team){

  //     return [
  //             SELECT Id, Name, Team__c
  //             FROM User
  //             WHERE Team__c = :team
  //             WITH SECURITY_ENFORCED
  //         ];
  // }

  // @AuraEnabled (cacheable=true)
  // public static List<UserRole> getUserRoles(){
  //     return [SELECT Id, Name
  //             FROM UserRole
  //             WITH SECURITY_ENFORCED
  //         ];
  // }
}
