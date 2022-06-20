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
    String query = 'SELECT ';
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
      } else {
        Object oldField = (Object) selectedObject.put(
          field,
          encryptField('random')
        );
      }
    }

    Object oldField = (Object) selectedObject.put(
      'Description',
      'Data anonymized on: ' + Datetime.now().format('dd/mm/y h:mm a')
    );

    update selectedObject;
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
