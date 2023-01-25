public with sharing class CandidatoTriggerHandler implements TriggerHandler{
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public CandidatoTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
    }
    
    public void beforeInsert(List<Lead> newRecords) {
        documentosFaltantes(newRecords);
    }
    public void beforeUpdate(List<Lead> oldRecords, List<Lead> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap){
        documentosFaltantes(newRecords);
    }
    public void beforeDelete(List<Lead> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask5();
        // helper.doTask1();
    }
    public void afterInsert(List<Lead> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask2();
        // helper.doTask3();
    }
    public void afterUpdate(List<Lead> oldRecords, List<Lead> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap) {
        
    }
    public void afterDelete(List<Lead> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask3();
        // helper.doTask1();
    }
    public void afterUndelete(List<Lead> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask4();
        // helper.doTask2();
    }
    
    public static void documentosFaltantes(List<Lead> candidatos){
        for(Lead c : candidatos){
            c.Documentos_faltantes1__c = '';
            If(c.Hoja_de_vida__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Hoja de vida';
            }
            If(c.Documento_de_identidad__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Documento de identidad';
            }
            If(c.Certificado_contraloria__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado de contraloría';
            }
            If(c.Certificado_procuraduria__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado de procuraduría';
            }
            If(c.Certificado_EPS__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado de EPS';
            }
            If(c.Certificado_bancario__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado bancario';
            }
            If(c.Certificado_AFP__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado de AFP';
            }
            If(c.Certificados_personas_a_cargo__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado de personas a cargo';
            }
            If(c.Certificados_academicos__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado académico';
            }
            If(c.Examen_medico__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Examen médico';
            }
            If(c.Certificado_policia__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado policía';
            }
            If(c.Carne_de_vacunas_COVID_19__c == false){
                c.Documentos_faltantes1__c = c.Documentos_faltantes1__c  +'\n Certificado de vacuna COVID 19';
            }
        }
    }
    
}