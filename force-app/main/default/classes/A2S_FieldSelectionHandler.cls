public with sharing class A2S_FieldSelectionHandler {
  @AuraEnabled(cacheable=true)
  public static List<FieldDefinition> getFields(string objectname) {
    string query = 'select DeveloperName,QualifiedApiName from FieldDefinition where EntityDefinition.QualifiedApiName = :objectname ORDER BY DeveloperName ASC';
    list<FieldDefinition> lstObject = Database.query(query);
    system.debug('lstObject==> ' + lstObject);
    return lstObject;
  }
}
