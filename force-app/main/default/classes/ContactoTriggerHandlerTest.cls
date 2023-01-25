@isTest
public class ContactoTriggerHandlerTest {
    @TestSetup
    static void makeData(){
       	List<Lead> candidatosSalesforce = new List<Lead>();
        for(Integer i = 0; i < 10; i++){
            Lead candidatoSf = new Lead(FirstName = 'Prueba ', LastName= 'Sf' + i, RecordTypeId= '012Dn0000005rYgIAI', Email = 'pruebasf' + i + 's@mail.com', Actualmente_est_estudiando__c = 'No', Ciudad_de_residencia2__c= 'Bello', Company= 'E-volution', Departamento__c= 'Antioquia', Fecha_de_nacimiento__c =  Date.newInstance(1999, 02, 02), Institucion_Educativa__c= 'Juan Pio', Nivel_de_ingl_s__c = 'B1', Numero_de_Identificacion__c= '5674574'+ i , Phone='0985745' + i, Status='Contratación', Tiene_experiencia_laboral__c= 'No', Tipo_de_Identificacion__c= 'Cédula de Ciudadanía', Titulo_adquirido__c='Bachiller',  Nivel_de_escolaridad__c = 'Técnico', Carne_de_vacunas_COVID_19__c= true, Certificados_academicos__c= true, Certificados_personas_a_cargo__c = true, Certificado_AFP__c = true, Certificado_bancario__c= true, Certificado_contraloria__c= true, Certificado_EPS__c =true, Certificado_policia__c= true, Certificado_procuraduria__c = true, Documento_de_identidad__c= true, Examen_medico__c = true, Hoja_de_vida__c=true);
            candidatosSalesforce.add(candidatoSf);
        }
        insert candidatosSalesforce;
        
        List<Lead> candidatosEvolution = new List<Lead>();
        for(Integer i = 0; i < 10; i++){
            Lead candidatoEv = new Lead(FirstName = 'Prueba ', LastName= 'Ev' + i, RecordTypeId= '012Dn0000006KNBIA2', Email = 'pruebaev' + i + 's@mail.com', Actualmente_est_estudiando__c = 'No', Ciudad_de_residencia2__c= 'Bello', Company= 'E-volution', Departamento__c= 'Antioquia', Fecha_de_nacimiento__c = Date.newInstance(1999, 02, 02), Institucion_Educativa__c= 'Juan Pio', Nivel_de_ingl_s__c = 'B1', Numero_de_Identificacion__c= '5674574'+ i , Phone='0985745' + i, Status='Contratación', Tiene_experiencia_laboral__c= 'No', Tipo_de_Identificacion__c= 'Cédula de Ciudadanía', Titulo_adquirido__c='Bachiller',  Nivel_de_escolaridad__c = 'Técnico', Carne_de_vacunas_COVID_19__c= true, Certificados_academicos__c= true, Certificados_personas_a_cargo__c = true, Certificado_AFP__c = true, Certificado_bancario__c= true, Certificado_contraloria__c= true, Certificado_EPS__c =true, Certificado_policia__c= true, Certificado_procuraduria__c = true, Documento_de_identidad__c= true, Examen_medico__c = true, Hoja_de_vida__c=true);
            candidatosEvolution.add(candidatoEv);
        }
        insert candidatosEvolution;
        
        Habilidad__c habilidad = new Habilidad__c(Name = 'CSS');
        insert habilidad;
        
        List<Habilidad_del_contacto__c> habilidadesCandidatos = new List<Habilidad_del_contacto__c>();
        for(Lead candidato : candidatosEvolution){
            Habilidad_del_contacto__c habilidadCandidato = new Habilidad_del_contacto__c(Candidato__c= candidato.Id ,Habilidad__c = habilidad.Id);
            habilidadesCandidatos.add(habilidadCandidato);
        }
        insert habilidadesCandidatos;
        
        
        
    }
    
    @isTest
    public static void tipoRegistroTest(){
        List<Lead> candidatos = [SELECT Id FROM Lead];
        List<Database.LeadConvert> candidatosAConvertir = new List<Database.LeadConvert>();
        
        LeadStatus estadoCandidato = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted = true LIMIT 1];
        
        for(Lead candidato :  candidatos){
            Database.LeadConvert lc = new database.LeadConvert();
			lc.setLeadId(candidato.id);
            lc.setConvertedStatus(estadoCandidato.MasterLabel);
            candidatosAConvertir.add(lc);
        }
        
        list<Database.LeadConvertResult> lcr = Database.convertLead(candidatosAConvertir);
        for(Database.LeadConvertResult lcresult : lcr){
            System.assert(lcresult.isSuccess());
        }        
    }
    
    @isTest
    public Static void eliminarContacto(){
        Contact contacto = new Contact(LastName = 'Prueba eliminada');
        insert contacto;
        Contact contactoId = new Contact(Id = contacto.Id);
    	Contact contactoCreado = [SELECT Id, LastName FROM Contact WHERE LastName = 'Prueba eliminada' LIMIT 1];
        System.assertEquals('Prueba eliminada', contactoCreado.LastName);
        delete contacto;
        List<Contact> contactos = [SELECT Id, LastName FROM Contact];
        System.assertEquals(0, contactos.size());
        undelete contactoId;
        Contact contactoRecuperado = [SELECT Id, LastName FROM Contact WHERE LastName = 'Prueba eliminada' LIMIT 1];
        System.assertEquals('Prueba eliminada', contactoRecuperado.LastName);
        
    }
}