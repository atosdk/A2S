public with sharing class A2S_FieldSelectionHandler {
  @AuraEnabled(cacheable=true)
  public static List<String> getFields(String objectname) {
    String query = 'SELECT FIELDS(STANDARD) FROM ';
    query += objectname;
    query += ' WHERE Name = \'test\'';
    SObject objectType = Database.query(query);

    Map<String, Object> apiNameObjectMap = objectType.getPopulatedFieldsAsMap();
    return new List<String>(apiNameObjectMap.keySet());
  }

  // TODO: Pass ID & select by ID
  @AuraEnabled
  public static void anonymiseFields(
    String objectname,
    List<String> selectedfields
  ) {
    String query = 'SELECT FIELDS(STANDARD) FROM ';
    query += objectname;
    query += ' WHERE Name = \'test\'';
    SObject selectedObject = Database.query(query);

    for (String field : selectedfields) {
      Object oldField = (Object) selectedObject.put(
        field,
        encryptField('random')
      );
    }

    update selectedObject;
  }

  private static String encryptField(String fieldValue) {
    Blob exampleIv = Blob.valueOf('Example of IV123');
    Blob key = Crypto.generateAesKey(128);
    Blob data = Blob.valueOf(fieldValue);
    Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

    String value = EncodingUtil.base64Encode(encrypted);
    return value;
  }
}
