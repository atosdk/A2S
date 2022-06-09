public with sharing class A2S_FieldSelectionHandler {
  @AuraEnabled(cacheable=true)
  public static List<String> getFields(String objectname) {
    String objectId;

    String query = 'SELECT FIELDS(STANDARD) FROM ';
    query += objectname;
    query += ' WHERE Name = \'test\'';
    SObject objectType = Database.query(query);

    Map<String, Object> apiNameObjectMap = objectType.getPopulatedFieldsAsMap();
    return new List<String>(apiNameObjectMap.keySet());
  }

  @AuraEnabled //(cacheable=true)
  public static void anonymiseFields(
    String objectname,
    List<String> selectedfields
  ) {
    // Pass original object as well

    List<String> fieldsSelected = new List<String>{ 'Phone' };

    if (objectname == 'Account') {
      updateAccounts(selectedfields);
    } else {
      //updateAccounts(se);
    }

    //return updateAccounts(fieldsSelected);
  }

  private static List<Account> updateAccounts(List<String> fieldsSelected) {
    String query = 'SELECT FIELDS(STANDARD) FROM Account WHERE Name = \'test\'';
    List<Account> account = Database.query(query);

    Map<String, Object> apiNameObjectMap = account[0].getPopulatedFieldsAsMap();
    List<String> filled = new List<String>(apiNameObjectMap.keySet());

    List<Account> updatedAccounts = new List<Account>();

    String Phone,
      Name,
      Type,
      ParentId,
      BillingStreet,
      BillingCity,
      BillingState,
      BillingCountry,
      BillingAddress,
      ShippingStreet,
      ShippingCity,
      ShippingState,
      ShippingPostalCode,
      ShippingCountry,
      ShippingAddress,
      Fax,
      Website,
      Industry,
      AnnualRevenue,
      NumberOfEmployees,
      Description,
      OwnerId,
      CreatedDate,
      CreatedById;

    for (Account acc : account) {
      if (fieldsSelected.contains('Phone')) {
        Phone = encryptField('random');
      } else if (filled.contains('Phone')) {
        Phone = acc.Phone;
      } else {
        Phone = '';
      }

      if (fieldsSelected.contains('Name')) {
        Name = encryptField('random');
      } else if (filled.contains('Name')) {
        Name = acc.Name;
      } else {
        Name = '';
      }

      if (fieldsSelected.contains('Type')) {
        Type = encryptField('random');
      } else if (filled.contains('Type')) {
        Type = acc.Type;
      } else {
        Type = '';
      }

      if (fieldsSelected.contains('BillingStreet')) {
        BillingStreet = encryptField('random');
      } else if (filled.contains('BillingStreet')) {
        BillingStreet = acc.BillingStreet;
      } else {
        BillingStreet = '';
      }

      if (fieldsSelected.contains('BillingCity')) {
        BillingCity = encryptField('random');
      } else if (filled.contains('BillingCity')) {
        BillingCity = acc.BillingCity;
      } else {
        BillingCity = '';
      }

      if (fieldsSelected.contains('Fax')) {
        Fax = encryptField('random');
      } else if (filled.contains('Fax')) {
        Fax = acc.Fax;
      } else {
        Fax = '';
      }

      updatedAccounts.add(
        new Account(
          Id = acc.Id,
          Name = Name,
          Phone = Phone,
          Type = Type,
          BillingStreet = BillingStreet,
          BillingCity = BillingCity,
          Fax = Fax
        )
      );
    }

    update updatedAccounts;

    return account;
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

// String allfieldsquery = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
// list<FieldDefinition> lstObject = Database.query(allfieldsquery);

// List<String> allFields = new List<String>();

// for (FieldDefinition def : lstObject) {
//   allFields.add(def.DeveloperName);
// }

// String temp = allFields[0];
// allFields.remove(0);

// String query = 'SELECT ';

// for (String field : allFields) {
//   query += field + ',';
// }

// query += temp;
// query += ' FROM ';
// query += objectname;
// query += ' WHERE Name = \'test\' WITH SECURITY_ENFORCED LIMIT 1';

// List<Account> accounts = Database.query(query);

// String query = 'SELECT ';

// for (String field : fields) {
//     query += field + ',';
// }

// query += 'Id';
// query += ' FROM Account WHERE Name = \'test\' WITH SECURITY_ENFORCED LIMIT 1';

