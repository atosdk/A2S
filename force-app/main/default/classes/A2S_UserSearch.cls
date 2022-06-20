public with sharing class A2S_UserSearch {
  @AuraEnabled(cacheable=true)
  public static List<SObject> getUsers(string searchKey, String objectname) {
    //List<SObject> lstObject = [SELECT Id, Name from User WHERE Name LIKE: '%' + searchKey + '%'];

    string query =
      'SELECT Id, Name FROM ' +
      objectname +
      ' WHERE Name LIKE \'%' +
      searchKey +
      '%\' AND Anonymised__c = false';

    list<SObject> lstObject = Database.query(query);
    return lstObject;
  }
}
