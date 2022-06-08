public with sharing class A2S_FieldSelectionHandler {
  @AuraEnabled(cacheable=true)
  public static List<FieldDefinition> getFields(string objectname) {
    string query = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
    list<FieldDefinition> lstObject = Database.query(query);
    system.debug('lstObject==> ' + lstObject);
    return lstObject;
  }

  @AuraEnabled(cacheable=true)
  public static List<User> anonymiseFields(List<String> fields) {
    String query = 'SELECT ';

    for (String field : fields) {
      query += field + ',';
    }

    query += 'Title';
    query += ' FROM User WITH SECURITY_ENFORCED LIMIT 3';

    List<User> users = Database.query(query);

    /**************************
     
     TODO: Anonymise queried fields
     TODO: Select record by ID
     
     **************************/
    return users;
  }
}
