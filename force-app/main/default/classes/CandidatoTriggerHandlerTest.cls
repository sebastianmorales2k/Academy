@isTest
public with sharing class CandidatoTriggerHandlerTest {

    //Se genera un candidato con todos los certificados marcados
    @TestSetup
    static void makeData(){
        Lead candidato = new lead(LastName = 'Ayala', FirstName = 'Camilo', Company = 'E-volution', Hoja_de_vida__c = true, Documento_de_identidad__c = true, Certificado_contraloria__c = true, Certificado_procuraduria__c = true, Certificado_EPS__c = true, 
        Certificado_bancario__c = true, Certificado_AFP__c = true, Certificados_personas_a_cargo__c = true, Certificados_academicos__c = true, Examen_medico__c = true , Certificado_policia__c = true,
        Carne_de_vacunas_COVID_19__c = true);
        insert candidato;
    }
	
    //Se verifica que el campo de documentos faltantes esté nulo, ya que todas las casillas están marcadas
    @isTest
    public static void documentacionCompleta(){
        Lead candidato = [SELECT Id, Name, Company, Hoja_de_vida__c, Documento_de_identidad__c, Certificado_contraloria__c, Certificado_procuraduria__c, Certificado_EPS__c, 
                            Certificado_bancario__c, Certificado_AFP__c, Certificados_personas_a_cargo__c, Certificados_academicos__c, Examen_medico__c, Certificado_policia__c,
                            Carne_de_vacunas_COVID_19__c, Documentos_faltantes1__c FROM Lead LIMIT 1];

        System.assertEquals(null, candidato.Documentos_faltantes1__c);

    }
	
    //Se verifica que el campo de documentos faltnates contenga unicamente el archivo de la casilla que no está marcada
    @isTest
    public static void unDocumento(){
        Lead candidato = [SELECT Id, Name, Company, Hoja_de_vida__c, Documento_de_identidad__c, Certificado_contraloria__c, Certificado_procuraduria__c, Certificado_EPS__c, 
                            Certificado_bancario__c, Certificado_AFP__c, Certificados_personas_a_cargo__c, Certificados_academicos__c, Examen_medico__c, Certificado_policia__c,
                            Carne_de_vacunas_COVID_19__c, Documentos_faltantes1__c FROM Lead LIMIT 1];

        candidato.Certificados_personas_a_cargo__c = false;
        update candidato;

        candidato = [SELECT Id, Name, Company, Hoja_de_vida__c, Documento_de_identidad__c, Certificado_contraloria__c, Certificado_procuraduria__c, Certificado_EPS__c, 
                            Certificado_bancario__c, Certificado_AFP__c, Certificados_personas_a_cargo__c, Certificados_academicos__c, Examen_medico__c, Certificado_policia__c,
                            Carne_de_vacunas_COVID_19__c, Documentos_faltantes1__c FROM Lead LIMIT 1];

        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado de personas a cargo'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Examen médico'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Hoja de vida'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Documento de identidad'));

        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado de contraloría'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado de procuraduría'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado de EPS'));

        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado bancario'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado de AFP'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado académico'));

        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado policía'));
        
        System.assert(!candidato.Documentos_faltantes1__c.contains('Certificado de vacuna COVID 19'));
		
    }
	
    //Se verifica que todas las casillas no marcadas de los documentos estén en el campo de los documentos faltntes
    @isTest
    public static void sinDocumentacion(){
        Lead candidato = new lead(LastName = 'Ayala2', FirstName = 'Camilo', Company = 'E-volution', Hoja_de_vida__c = false, Documento_de_identidad__c = false, Certificado_contraloria__c = false, Certificado_procuraduria__c = false, Certificado_EPS__c = false, 
        Certificado_bancario__c = false, Certificado_AFP__c = false, Certificados_personas_a_cargo__c = false, Certificados_academicos__c = false, Examen_medico__c = false , Certificado_policia__c = false,
        Carne_de_vacunas_COVID_19__c = false);
        insert candidato;

        candidato = [SELECT Id, Name, Company, Hoja_de_vida__c, Documento_de_identidad__c, Certificado_contraloria__c, Certificado_procuraduria__c, Certificado_EPS__c, 
                            Certificado_bancario__c, Certificado_AFP__c, Certificados_personas_a_cargo__c, Certificados_academicos__c, Examen_medico__c, Certificado_policia__c,
                            Carne_de_vacunas_COVID_19__c, Documentos_faltantes1__c FROM Lead WHERE LastName = 'Ayala2' LIMIT 1];

        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado de personas a cargo'));

        System.assert(candidato.Documentos_faltantes1__c.contains('Examen médico'));
        
        System.assert(candidato.Documentos_faltantes1__c.contains('Hoja de vida'));
        
        System.assert(candidato.Documentos_faltantes1__c.contains('Documento de identidad'));

        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado de contraloría'));
        
        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado de procuraduría'));
        
        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado de EPS'));

        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado bancario'));
        
        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado de AFP'));
        
        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado académico'));

        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado policía'));
        
        System.assert(candidato.Documentos_faltantes1__c.contains('Certificado de vacuna COVID 19'));
        
        delete candidato;
        undelete candidato;

    }




}