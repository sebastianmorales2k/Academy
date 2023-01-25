@isTest
public class PrerrequisitoTriggerHandlerTest {
    
    @TestSetup
    static void makeData(){
        list<Habilidad__c> habilidades = new list<habilidad__c>();
        for(integer i = 0 ; i < 5; i++){
            habilidad__c habilidad = new habilidad__c(name= 'Habilidad numero'+i);
            habilidades.add(habilidad);
        }
        insert habilidades;
        list<habilidad__c> habilidadesitas = [select id from habilidad__c];
        
        m_dulo__c modulo = new m_dulo__c(Name='Modulo de administracion',Tipo_de_certificaci_n__c = 'Administrator',Certificaci_n__c ='Administrator');
        insert modulo;
        m_dulo__c modulito = [select id from m_dulo__c limit 1];
        
        List<Prerrequisito__c> prerrequisitos = new list<Prerrequisito__c>();
        for(habilidad__c habilidad: habilidadesitas){
            Prerrequisito__c prerre = new Prerrequisito__c(modulo__c = modulito.id , habilidad__c = habilidad.Id);
            prerrequisitos.add(prerre);
            
        }
        insert prerrequisitos;
    }
    
    @isTest
    public static void errorPrerre(){
        habilidad__c habilidadRepetida = [select id from habilidad__c limit 1];
        m_dulo__c modulito = [select id from m_dulo__c limit 1];
        try{
            prerrequisito__c prerrequi = new prerrequisito__c(modulo__c = modulito.id, habilidad__c = habilidadRepetida.Id);
            insert prerrequi;
        }catch(exception e){
            system.assert(e.getMessage().contains('Esta habilidad ya ha sido establecida como prerrequisito del módulo.'));
        }
    }
    
    @isTest
    public static void prerrequiCorrecto(){
        habilidad__c newHabilidad = new habilidad__c(name= 'Habilidad nueva pro');
        insert newHabilidad;
        
        m_dulo__c modulito = [select id from m_dulo__c limit 1];
        try{
            prerrequisito__c prerrequi = new prerrequisito__c(modulo__c = modulito.id, habilidad__c = newHabilidad.Id);
            insert prerrequi;
        }catch(exception e){
            system.assert(e.getMessage().contains('Esta habilidad ya ha sido establecida como prerrequisito del módulo.'));
        }
        prerrequisito__c prerreNuevo = [select id from prerrequisito__c where habilidad__c =: newHabilidad.Id];
        
    }
    
    @isTest
    public static void delPrerrequi(){
        
        prerrequisito__c prerrequiModificable = [select id, habilidad__c from Prerrequisito__c limit 1];
        delete prerrequiModificable;
        
        list<prerrequisito__c> prerreActualizado = [select id from prerrequisito__c];
        system.assertEquals(4, prerreActualizado.size());
    }
    
    @isTest
    public static void undelPrerrequi(){
        
        prerrequisito__c prerrequiModificable = [select id, habilidad__c from Prerrequisito__c limit 1];
        prerrequisito__c idprerre = new prerrequisito__c(Id = prerrequiModificable.Id);
        delete prerrequiModificable;
        
        list<prerrequisito__c> prerreActualizado = [select id from prerrequisito__c];
        system.assertEquals(4, prerreActualizado.size());
        
        undelete idprerre;
        list<prerrequisito__c> prerreUndeleteado = [select id from prerrequisito__c];
        system.assertEquals(5, prerreUndeleteado.size());
    }
}