@IsTest
public class A2S_UserSearchTest {
  @IsTest
  static void getUsersTest() {
    User user1 = new User(
      FirstName = 'John',
      LastName = 'Smith',
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

    List<User> real1 = A2S_UserSearch.getUsers('John', 'User');

    List<String> returnednames = new List<String>();

    for (Integer i = 0; i < real1.size(); i++) {
      returnedNames.add(real1[i].Name);
    }

    String fullName = user1.FirstName + ' ' + user1.LastName;

    Test.startTest();
    System.assertEquals(true, returnedNames.contains(fullName), 'Test');
    Test.stopTest();
  }
}

