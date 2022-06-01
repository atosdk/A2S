@IsTest
public class A2S_UserControllerTest {
  @IsTest
  static void getBirthdaysTest() {
    User user1 = new User(
      FirstName = 'John',
      LastName = 'Smith',
      DOB__c = Date.newInstance(1995, 5, 5),
      Team__c = 'Salesforce',
      Email = 'john@test.com',
      Username = 'john125469854565654@A2Stest.com',
      CommunityNickname = 'John',
      Title = 'title',
      Alias = 'alias',
      TimeZoneSidKey = 'America/Los_Angeles',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      profileId = [
        SELECT Id
        FROM Profile
        WHERE Name = 'Standard User'
        LIMIT 1
      ][0]
      .Id
    );

    insert user1;

    List<User> real1 = A2S_UserController.getBirthdays(5, 'Salesforce');

    List<String> returnednames = new List<String>();

    for (Integer i = 0; i < real1.size(); i++) {
      returnedNames.add(real1[i].Name);
    }

    String fullName = user1.FirstName + ' ' + user1.LastName;

    Test.startTest();
    System.assertEquals(true, returnedNames.contains(fullName), 'Test');
    Test.stopTest();
  }

  @IsTest
  static void testAnniversary() {
    User user2 = new User(
      FirstName = 'Jane',
      LastName = 'Smith',
      DOB__c = Date.newInstance(1995, 5, 5),
      Employment_Start_Date__c = Date.newInstance(2005, 10, 5),
      Team__c = 'Salesforce',
      Email = 'Jane@test.com',
      Username = 'Jane@15454545A2Stest.com',
      CommunityNickname = 'Jane',
      Title = 'title',
      Alias = 'alias',
      TimeZoneSidKey = 'America/Los_Angeles',
      EmailEncodingKey = 'UTF-8',
      LanguageLocaleKey = 'en_US',
      LocaleSidKey = 'en_US',
      ProfileId = [
        SELECT Id
        FROM Profile
        WHERE Name = 'Standard User'
        LIMIT 1
      ][0]
      .Id
    );

    insert user2;

    List<User> real2 = A2S_UserController.getAnniversaries(10, 'Salesforce');

    List<String> returnedNames = new List<String>();

    for (Integer i = 0; i < real2.size(); i++) {
      returnedNames.add(real2[i].Name);
    }

    String fullName = user2.FirstName + ' ' + user2.LastName;

    Test.startTest();
    System.assertEquals(true, returnedNames.contains(fullName), 'Test');
    Test.stopTest();
  }
}
