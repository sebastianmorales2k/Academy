public class ContactoTriggerHandler implements TriggerHandler{
    private boolean triggerIsExecuting;
    private integer triggerSize;
    
    public ContactoTriggerHandler(boolean triggerIsExecuting, integer triggerSize) {
        this.triggerIsExecuting = triggerIsExecuting;
        this.triggerSize = triggerSize;
    }
    
    public void beforeInsert(List<Contact> newRecords) {
        
    }
    
    public void beforeUpdate(List<Contact> oldRecords, List<Contact> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap){
        //
    }
    
    public void beforeDelete(List<Contact> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask5();
        // helper.doTask1();
    }
    
    public void afterInsert(List<Contact> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask2();
        // helper.doTask3();
        cambiarTipoRegistro(newRecords);
        anadirHabilidadesAEmpleado(newRecords);
    }
    
    public void afterUpdate(List<Contact> oldRecords, List<Contact> newRecords, Map<ID, sObject> oldRecordMap, Map<ID, sObject> newRecordMap) {
        
    }
    
    public void afterDelete(List<Contact> oldRecords, Map<ID, sObject> oldRecordMap) {
        // helper.doTask3();
        // helper.doTask1();
    }
    
    public void afterUndelete(List<Contact> newRecords, Map<ID, sObject> newRecordMap) {
        // helper.doTask4();
        // helper.doTask2();
    }
    
    public static void anadirHabilidadesAEmpleado(List<Contact> contactos){
        try{
            Set<Id> candidatosId = new Set<Id>();
        
            for(Contact contacto: contactos){
                if(contacto.LeadId__c != null){
                    candidatosId.add(contacto.LeadId__c);
                }
            }
        	
            if(candidatosId != null){
                List<Habilidad_del_contacto__c> habilidadesContacto = [SELECT Id, Habilidad__c, Candidato__c, Contacto__c FROM Habilidad_del_contacto__c WHERE Candidato__c IN: candidatosId];
                List<Habilidad_del_contacto__c> habilidadesActualizadas = new List<Habilidad_del_contacto__c>();
                
                for(Contact contacto : contactos){
                    for(Habilidad_del_contacto__c habilidad : habilidadesContacto){
                        if(contacto.LeadId__c == habilidad.Candidato__c){
                            Habilidad_del_contacto__c habilidadAAct = new Habilidad_del_contacto__c();
                            habilidadAAct.Contacto__c = contacto.Id;
                            habilidadAAct.Id = habilidad.Id;
                            habilidadesActualizadas.add(habilidadAAct);
                        }
                    }
                }
                update habilidadesActualizadas;
            }   
        }catch(Exception e){
            System.debug('Ocurrió un error en habilidades ' + e.getMessage());
        }
        
        
    }
    
    public static void cambiarTipoRegistro(List<Contact> contactos){
        try{
            Set<Id> candidatosId = new Set<Id>();
        
            for(Contact contacto: contactos){
                if(contacto.LeadId__c != null){
                    candidatosId.add(contacto.LeadId__c);
                }
            }
            
            
            if(candidatosId != null){
                List<Lead> candidatos = [SELECT Id, RecordType.Name FROM Lead WHERE Id IN: candidatosId];
                List<Contact> contactosActualizados = new List<Contact>();
                
                RecordType empleadoSalesforce = [SELECT Id, Name FROM RecordType WHERE Name = 'Empleado Salesforce' LIMIT 1];
                RecordType empleadoEvolution = [SELECT Id, Name FROM RecordType WHERE Name = 'Empleado E-volution' LIMIT 1];

                for(Contact contacto : contactos){
                    for(Lead candidato : candidatos){
                        Contact contactoActualizado = new Contact();
                        if(contacto.LeadId__c == candidato.Id){
                            if(candidato.RecordType.Name == 'Candidato E-Volution'){
                                contactoActualizado.Id = contacto.Id;
                                contactoActualizado.RecordTypeId = empleadoEvolution.Id;
                            }else if(candidato.RecordType.Name == 'Candidato Salesforce'){
                                contactoActualizado.Id = contacto.Id;
                                contactoActualizado.RecordTypeId = empleadoSalesforce.Id;
                                
                            }
                            contactosActualizados.add(contactoActualizado);
                        }
                    }
                }
                update contactosActualizados;
            }
        }catch(Exception e){
             System.debug('Ocurrió un error ' + e.getMessage());
        }
    }
    
}