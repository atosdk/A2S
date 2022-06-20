@IsTest
public class A2S_FieldSelectionHandlerTest {
  @IsTest
  static void getFieldsTest() {
    Account account1 = new Account(
      Name = 'Test1'
    );

    insert account1;

    String query = 'SELECT Id FROM Account WHERE Name = Test1';
    String selectedObject = Database.query(query);
    String accName = selectedObject;

    List<String> real2 = A2S_FieldSelectionHandler.getFields('Account', selectedObject);

    

    Test.startTest();
    System.assertEquals(true, real2.contains(accName), 'Test1');
    Test.stopTest();
  }
}