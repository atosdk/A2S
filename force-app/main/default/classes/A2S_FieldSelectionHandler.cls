public with sharing class A2S_FieldSelectionHandler {
  @AuraEnabled(cacheable=true)
  public static List<FieldDefinition> getFields(string objectname) {
    string query = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
    list<FieldDefinition> lstObject = Database.query(query);
    system.debug('lstObject==> ' + lstObject);
    return lstObject;
  }

  @AuraEnabled(cacheable=true)
  public static List<Account> anonymiseFields(List<String> fields) {
    String query = 'SELECT ';

    for (String field : fields) {
      query += field + ',';
    }

    query += 'Name';
    query += ' FROM Account WITH SECURITY_ENFORCED LIMIT 3';

    List<Account> accounts = Database.query(query);

    //Map<String, Object> queriedFields = users.getPopulatedFieldsAsMap();
    List<Account> updatedAccounts = new List<Account>();

    Set<String> allFields = new Set<String>();
    allFields.addAll(fields);

    for (Account acc : accounts) {
      Account temp = new Account(Name = 'Test', Phone = '0000000000');

      if (allFields.contains('Phone')) {
        Blob exampleIv = Blob.valueOf('Example of IV123');
        Blob key = Crypto.generateAesKey(128);
        Blob data = Blob.valueOf(acc.Phone);
        Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

        String value = EncodingUtil.base64Encode(encrypted);

        temp.Phone = value;
      }
      updatedAccounts.add(temp);
    }
    // for (Account usr : Accounts) {
    //   for (String field : fields) {
    //     Blob exampleIv = Blob.valueOf('Example of IV123');
    //     Blob key = Crypto.generateAesKey(128);
    //     Blob data = Blob.valueOf(usr.field);
    //     Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

    //     usr.field = encrypted;
    //   }
    //   updatedUsers.add(usr);
    // }

    // Blob exampleIv = Blob.valueOf('Example of IV123');
    // Blob key = Crypto.generateAesKey(128);
    // Blob data = Blob.valueOf('Data to be encrypted');
    // Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

    /**************************
     
     TODO: Anonymise queried fields
     TODO: Select record by ID
     
     **************************/
    // String value = EncodingUtil.base64Encode(encrypted);

    return updatedAccounts;
  }
}
