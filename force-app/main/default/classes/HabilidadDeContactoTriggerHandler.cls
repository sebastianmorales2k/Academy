public class HabilidadDeContactoTriggerHandler implements TriggerHandler{
    private boolean triggerIsExecuting;
    private integer triggerSize;
    public HabilidadDeContactoTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
    }
    
    public void beforeInsert(List<Habilidad_del_contacto__c> newRecords) {
        noRepetirHabilidad(newRecords);
    }
    public void beforeUpdate(List<Habilidad_del_contacto__c> oldRecords, List<Habilidad_del_contacto__c> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap){
        //
    }
    public void beforeDelete(List<Habilidad_del_contacto__c> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask5();
        // helper.doTask1();
    }
    public void afterInsert(List<Habilidad_del_contacto__c> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask2();
        // helper.doTask3();
    }
    public void afterUpdate(List<Habilidad_del_contacto__c> oldRecords, List<Habilidad_del_contacto__c> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap) {
        
    }
    public void afterDelete(List<Habilidad_del_contacto__c> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask3();
        // helper.doTask1();
    }
    public void afterUndelete(List<Habilidad_del_contacto__c> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask4();
        // helper.doTask2();
    }
    
    public static void noRepetirHabilidad(list<Habilidad_del_contacto__c> habilidadesContacto){
        set<id> idsContactos = new set<id>();
        set<id> idsCandidatos = new set<id>();
        for(Habilidad_del_contacto__c habiliContacto : habilidadesContacto){
            idsContactos.add(habiliContacto.contacto__c);
            idsCandidatos.add(habiliContacto.candidato__c);
        }
        list<Habilidad_del_contacto__c> allHabilidadesConContactos = [select id, Habilidad__c ,contacto__c,candidato__c  from Habilidad_del_contacto__c where contacto__c IN: idsContactos ];
        list<Habilidad_del_contacto__c> allHabilidadesConCandidatos = [select id, Habilidad__c ,contacto__c,candidato__c  from Habilidad_del_contacto__c where candidato__c IN: idsCandidatos];
        
        for(Habilidad_del_contacto__c habiliNueva: habilidadesContacto){
            if(habiliNueva.Contacto__c != null){
                for(Habilidad_del_contacto__c habiliContacto: allHabilidadesConContactos){
                    if(habiliNueva.Contacto__c == habiliContacto.Contacto__c && habiliNueva.Habilidad__c == habiliContacto.Habilidad__c){
                        habiliNueva.addError('Esta habilidad ya ha sido agregada al Contacto.');
                    } 
                }
            }else{
                for(Habilidad_del_contacto__c habiliCandidato: allHabilidadesConCandidatos){
                    if(habiliNueva.Contacto__c == habiliCandidato.Contacto__c && habiliNueva.Habilidad__c == habiliCandidato.Habilidad__c){
                        habiliNueva.addError('Esta habilidad ya ha sido agregada al Candidato.');
                    } 
                }
            }
        }
    }
}