public with sharing class A2S_UserSearch {
    @AuraEnabled(Cacheable = true)
    public static List<Users> getUsers(string searchKey){
        return [SELECT Id, Name from USER WHERE Name LIKE: '%' + searchKey + '%'];
    }
}
