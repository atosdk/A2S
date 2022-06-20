@IsTest
public class A2S_FieldSelectionHandlerTest {
  @IsTest
  static void getFieldsTest() {

    Account account1 = new Account(
      Name = 'Test1'
    );

    insert account1;
    String accname = 'Test1';
    String query = 'SELECT Id, Name FROM Account WHERE Name = ' + accname ;
    List<SObject> selectedObject = Database.query(query);

    List<String> real2 = A2S_FieldSelectionHandler.getFields('Account', selectedObject[0].Id);



    Test.startTest();
    System.assertEquals(true, real2.contains('Name'), 'Test1');
    Test.stopTest();
  }

  @IsTest
  static void anonymiseFieldsTest() {

    Account account1 = new Account(
      Name = 'Test2',
      Phone = '012345678'
    );

    insert account1;
    String accname = 'Test2';
    String query = 'SELECT Id FROM Account WHERE Name = ' + accname ;
    List<SObject> selectedObject = Database.query(query);
    String objId = selectedObject.Id[0];



    String real2 = A2S_FieldSelectionHandler.anonymiseFields('Account', 'phone', objId);

    String encodedPhone = real2;
    

    Test.startTest();
    System.assertNotEquals('012345678', encodedPhone, 'Anonymisation did not work');
    Test.stopTest();
  }
}

