public with sharing class A2S_FieldSelectionHandler {
  @AuraEnabled(cacheable=true)
  public static List<FieldDefinition> getFields(string objectname) {
    string query = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
    list<FieldDefinition> lstObject = Database.query(query);
    system.debug('lstObject==> ' + lstObject);
    return lstObject;
  }

  @AuraEnabled //(cacheable=true)
  public static Account anonymiseFields() {
    //List<String> fields) {
    // Pass original object as well

    List<String> fields = new List<String>{ 'Phone', 'Name' };

    String query = 'SELECT ';

    for (String field : fields) {
      query += field + ',';
    }

    List<String> fieldsSelected = new List<String>{ 'Phone', 'Name' };
    query += 'Id';
    query += ' FROM Account WHERE Name = \'test\' WITH SECURITY_ENFORCED LIMIT 1';

    List<Account> accounts = Database.query(query);
    String phone;
    String name;

    Account currAcc = accounts[0];

    if (fieldsSelected.contains('Phone')) {
      phone = '000';
    } else {
      phone = currAcc.Phone;
    }

    Account updated = new Account(
      Id = accounts[0].Id,
      Name = 'Test',
      Phone = phone
    );

    update updated;

    return accounts[0];
  }
}

//Map<String, Object> queriedFields = users.getPopulatedFieldsAsMap();
//       List<Account> updatedAccounts = new List<Account>();

//       Set<String> allFields = new Set<String>();
//       allFields.addAll(fields);

//       for (Account acc : accounts) {
//         Account temp = new Account(Name = 'Test', Phone = '0000000000');

//         if (allFields.contains('Phone')) {
//           Blob exampleIv = Blob.valueOf('Example of IV123');
//           Blob key = Crypto.generateAesKey(128);
//           Blob data = Blob.valueOf(acc.Phone);
//           Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

//           String value = EncodingUtil.base64Encode(encrypted);

//           temp.Phone = value;
//         }
//         updatedAccounts.add(temp);
//       }
//       // for (Account usr : Accounts) {
//       //   for (String field : fields) {
//       //     Blob exampleIv = Blob.valueOf('Example of IV123');
//       //     Blob key = Crypto.generateAesKey(128);
//       //     Blob data = Blob.valueOf(usr.field);
//       //     Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

//       //     usr.field = encrypted;
//       //   }
//       //   updatedUsers.add(usr);
//       // }

//       // Blob exampleIv = Blob.valueOf('Example of IV123');
//       // Blob key = Crypto.generateAesKey(128);
//       // Blob data = Blob.valueOf('Data to be encrypted');
//       // Blob encrypted = Crypto.encrypt('AES128', key, exampleIv, data);

//       /**************************

//        TODO: Anonymise queried fields
//        TODO: Select record by ID

//        **************************/
//       // String value = EncodingUtil.base64Encode(encrypted);

//       return updatedAccounts;
//     }
//   }

