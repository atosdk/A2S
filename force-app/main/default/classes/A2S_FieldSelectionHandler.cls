public with sharing class A2S_FieldSelectionHandler {
  @AuraEnabled(cacheable=true)
  public static List<String> getFields(String objectname, String objectid) {
    String editString = '';

    Map<String, Schema.SObjectField> allFields = Schema.getGlobalDescribe()
      .get(objectname)
      .getDescribe()
      .fields.getMap();

    List<String> editableFields = new List<String>();

    List<String> excludedFields = new List<String>{
      //User
      'Username',
      'Alias',
      'TimeZoneSidKey',
      'LocaleSidKey',
      'EmailEncodingKey',
      'LanguageLocaleKey',
      'DigestFrequency',
      'DefaultGroupNotificationFrequency',
      'Id',
      //Account
      'IndustryTest__c'
    };

    for (Schema.SObjectField editfieds : allFields.values()) {
      Schema.DescribeFieldResult fieldResult = editfieds.getDescribe();

      if (
        fieldResult.isUpdateable() &&
        fieldResult.getType() != Schema.DisplayType.Boolean &&
        fieldResult.getType() != Schema.DisplayType.REFERENCE
      ) {
        editableFields.add(fieldResult.getName());
        editString += ' ' + fieldResult.getName() + ',';
      }
    }

    editString = editString.removeEnd(',');

    String query =
      'SELECT' +
      editString +
      ' FROM ' +
      objectname +
      ' WHERE Id = \'' +
      objectid +
      '\'';
    SObject objectType = Database.query(query);

    Map<String, Object> apiNameObjectMap = objectType.getPopulatedFieldsAsMap();

    List<String> returnedFields = new List<String>(apiNameObjectMap.keySet());
    List<String> displayedFields = new List<String>();

    for (String field : returnedFields) {
      if (excludedFields.contains(field) == false) {
        displayedFields.add(field);
      }
    }

    return displayedFields;
  }

  @AuraEnabled
  public static void anonymiseFields(
    String objectname,
    List<String> selectedfields,
    String objectid
  ) {
    selectedfields.add('Anonymised__c');

    String query = 'SELECT  ';
    for (String field : selectedfields) {
      query += field + ',';
    }

    query = query.removeEnd(',');
    query += ' FROM ' + objectname + ' WHERE Id = \'' + objectid + '\'';
    SObject selectedObject = Database.query(query);

    for (String field : selectedfields) {
      Schema.DisplayType fieldType = Schema.getGlobalDescribe()
        .get(objectname)
        .getDescribe()
        .fields
        .getMap()
        .get(field)
        .getDescribe()
        .getType();

      if (
        fieldType == Schema.DisplayType.INTEGER ||
        fieldType == Schema.DisplayType.DOUBLE ||
        fieldType == Schema.DisplayType.CURRENCY
      ) {
        Object oldField = (Object) selectedObject.put(field, 0);
      } else if (fieldType == Schema.DisplayType.DATE) {
        Object oldField = (Object) selectedObject.put(
          field,
          Date.newInstance(2033, 1, 1)
        );
      } else if (fieldType == Schema.DisplayType.EMAIL) {
        Object oldField = (Object) selectedObject.put(field, 'email@email.com');
      } else if (field == 'Anonymised__c') {
        Object oldField = (Object) selectedObject.put(field, true);
      } else {
        Object oldField = (Object) selectedObject.put(
          field,
          encryptField('random')
        );
      }
    }

    if (objectname == 'User') {
      Object oldField = (Object) selectedObject.put(
        'AboutMe',
        'Data anonymized on: ' + Datetime.now().format('dd/MM/y h:mm a')
      );
    } else {
      Object oldField = (Object) selectedObject.put(
        'Description',
        'Data anonymized on: ' + Datetime.now().format('dd/MM/y h:mm a')
      );
    }

    /*
     *
     * Check for related contacts on account and anonymise them.
     *
     */

    if (objectname == 'Account') {
      List<Contact> relContacts = [
        SELECT Id, Name
        FROM Contact
        WHERE AccountId = :objectid
      ];
      if (relContacts.size() != 0) {
        for (Contact con : relContacts) {
          List<String> stdFields = new List<String>{
            'FirstName',
            'LastName',
            'Phone',
            'Email'
          };
          anonymiseFields('Contact', stdFields, con.Id);
        }
      }
    }

    update selectedObject;

    if (objectname == 'User') {
      UserManagement.obfuscateUser((Id) objectid);
    }
  }

  private static String encryptField(String fieldValue) {
    Blob exampleIv = Blob.valueOf('Example of IV123');
    Blob key = Crypto.generateAesKey(128);
    Blob data = Blob.valueOf(fieldValue);
    Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

    String value = EncodingUtil.base64Encode(encrypted);
    return value.mid(0, 5);
  }
}
