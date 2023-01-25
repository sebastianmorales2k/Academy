public with sharing class CertificacionTriggerHandler implements TriggerHandler{
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public CertificacionTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
    }

    public void beforeInsert(List<Certificaci_n__c> newRecords) {

    }
    public void beforeUpdate(List<Certificaci_n__c> oldRecords, List<Certificaci_n__c> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap){
    
    }
    public void beforeDelete(List<Certificaci_n__c> oldRecords, Map<ID, sObject> oldRecordMap) {

    }
    public void afterInsert(List<Certificaci_n__c> newRecords, Map<ID, sObject> newRecordMap) {

    }
    public void afterUpdate(List<Certificaci_n__c> oldRecords, List<Certificaci_n__c> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap) {
        
    }
    public void afterDelete(List<Certificaci_n__c> oldRecords, Map<ID, sObject> oldRecordMap) {

    }
    public void afterUndelete(List<Certificaci_n__c> newRecords, Map<ID, sObject> newRecordMap) {

    }
}