public with sharing class A2S_UserSearch {
    @AuraEnabled(cacheable = true)
    public static List<User> getUsers(string searchKey){
        return [SELECT Id, Name from USER WHERE Name LIKE: '%' + searchKey + '%'];
    }
}
