public class PrerrequisitoTriggerHandler implements TriggerHandler{
	private boolean triggerIsExecuting;
    private integer triggerSize;
    public PrerrequisitoTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
    }
    
    public void beforeInsert(List<prerrequisito__c> newRecords) {
        noRepetirPrerrequisito(newRecords);
    }
    public void beforeUpdate(List<prerrequisito__c> oldRecords, List<prerrequisito__c> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap){
        //
    }
    public void beforeDelete(List<prerrequisito__c> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask5();
        // helper.doTask1();
    }
    public void afterInsert(List<prerrequisito__c> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask2();
        // helper.doTask3();
    }
    public void afterUpdate(List<prerrequisito__c> oldRecords, List<prerrequisito__c> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap) {
        
    }
    public void afterDelete(List<prerrequisito__c> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask3();
        // helper.doTask1();
    }
    public void afterUndelete(List<prerrequisito__c> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask4();
        // helper.doTask2();
    }
    
    public static void noRepetirPrerrequisito(list<prerrequisito__c> prerrequisitos){
        set<id> idsModulos = new set<id>();
        for(prerrequisito__c prerreque : prerrequisitos){
            idsModulos.add(prerreque.Modulo__c);
        }
        list<prerrequisito__c> allPrerrequisitos = [select id, Habilidad__c ,Modulo__c  from prerrequisito__c where Modulo__c IN: idsModulos];
        
        for(prerrequisito__c prerrequi : prerrequisitos){
            for(prerrequisito__c listprerre : allPrerrequisitos){
                if(prerrequi.Modulo__c == listprerre.Modulo__c && prerrequi.Habilidad__c == listprerre.Habilidad__c){
                    system.debug('Es una copia del prerrequisito!!!! no agregarla!!!!');
                    prerrequi.addError('Esta habilidad ya ha sido establecida como prerrequisito del módulo.');
                }
            }
        }
    }
}