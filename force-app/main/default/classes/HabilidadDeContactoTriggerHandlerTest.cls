@isTest
public class HabilidadDeContactoTriggerHandlerTest {
    @testSetup
    static void makeData(){
        list<Habilidad__c> habilidades = new list<habilidad__c>();
        for(integer i = 0 ; i < 5; i++){
            habilidad__c habilidad = new habilidad__c(name= 'Habilidad numero'+i);
            habilidades.add(habilidad);
        }
        insert habilidades;
        list<habilidad__c> habilidadesitas = [select id from habilidad__c];
        
        Lead candidatoSf = new Lead(FirstName = 'Prueba ', LastName= 'Sf', RecordTypeId= '012Dn0000005rYgIAI', Email = 'pruebasfs@mail.com',
                                    Actualmente_est_estudiando__c = 'No', Ciudad_de_residencia2__c= 'Bello', Company= 'E-volution', Departamento__c= 'Antioquia',
                                    Fecha_de_nacimiento__c =  Date.newInstance(1999, 02, 02), Institucion_Educativa__c= 'Juan Pio', Nivel_de_ingl_s__c = 'B1', 
                                    Numero_de_Identificacion__c= '5674574' , Phone='0985745', Status='Contratación', Tiene_experiencia_laboral__c= 'No',
                                    Tipo_de_Identificacion__c= 'Cédula de Ciudadanía', Titulo_adquirido__c='Bachiller',  Nivel_de_escolaridad__c = 'Técnico',
                                    Carne_de_vacunas_COVID_19__c= true, Certificados_academicos__c= true, Certificados_personas_a_cargo__c = true, Certificado_AFP__c = true,
                                    Certificado_bancario__c= true, Certificado_contraloria__c= true, Certificado_EPS__c =true, Certificado_policia__c= true, 
                                    Certificado_procuraduria__c = true, Documento_de_identidad__c= true, Examen_medico__c = true, Hoja_de_vida__c=true);
        insert candidatoSf;
        
        contact contactoSf = new contact(FirstName = 'prueba ', LastName = 'de Habilidades');
        insert contactoSf;
        
        List< Habilidad_del_contacto__c> habilidadesContactYCandi = new list< Habilidad_del_contacto__c >();
        
        for(habilidad__c habilidad: habilidadesitas){
            Habilidad_del_contacto__c habiliContacto = new Habilidad_del_contacto__c(Candidato__c = candidatoSf.Id , Habilidad__c = habilidad.Id);
            habilidadesContactYCandi.add(habiliContacto);
            Habilidad_del_contacto__c habiliCandidato = new Habilidad_del_contacto__c(Contacto__c  = contactoSf.Id , Habilidad__c = habilidad.Id);
            habilidadesContactYCandi.add(habiliCandidato);
        }
        
        insert habilidadesContactYCandi;
            
    }
    
    @isTest
    public static void errorHabiliCandidato(){
        habilidad__c habilidadRepetida = [select id from habilidad__c limit 1];
        lead candidato = [select id from lead limit 1];
        try{
            Habilidad_del_contacto__c habiliCandidato = new Habilidad_del_contacto__c(Candidato__c = candidato.Id, habilidad__c = habilidadRepetida.Id);
            insert habiliCandidato;
        }catch(exception e){
            system.assert(e.getMessage().contains('Esta habilidad ya ha sido agregada al Candidato.'));
        }
    }
    
    @isTest
    public static void errorHabiliContacto(){
        habilidad__c habilidadRepetida = [select id from habilidad__c limit 1];
        contact contacto = [select id from contact limit 1];
        try{
            Habilidad_del_contacto__c habiliCandidato = new Habilidad_del_contacto__c(contacto__c = contacto.Id, habilidad__c = habilidadRepetida.Id);
            insert habiliCandidato;
        }catch(exception e){
            system.assert(e.getMessage().contains('Esta habilidad ya ha sido agregada al Contacto.'));
        }
    }
    
    @isTest
    public static void actulizarHabiliContacto(){
        contact contactoSf = new contact(FirstName = 'contacto nuevo', LastName = 'para update');
        insert contactoSf;
        
        Habilidad_del_contacto__c habilidadConContact = [select id, Contacto__c from Habilidad_del_contacto__c limit 1];
        
        try{
            habilidadConContact.Contacto__c = contactoSf.id;
            update habilidadConContact;
        }catch(exception e){
            
        }
        list<Habilidad_del_contacto__c> habilidadConNuevoContacto = [select id, Contacto__c from Habilidad_del_contacto__c where contacto__c =: contactoSf.Id];
        system.assertEquals(1, habilidadConNuevoContacto.size());
    }
    
    @isTest
    public static void delHabiliContact(){
        
        Habilidad_del_contacto__c habiliModificable = [select id, habilidad__c from Habilidad_del_contacto__c limit 1];
        delete habiliModificable;
        
        list<Habilidad_del_contacto__c> habiliActualizado = [select id from Habilidad_del_contacto__c];
        system.assertEquals(9, habiliActualizado.size());
    }
    
    @isTest
    public static void undelHabiliContact(){
        
        Habilidad_del_contacto__c habiliModificable = [select id, habilidad__c from Habilidad_del_contacto__c limit 1];
        Habilidad_del_contacto__c idhabili = new Habilidad_del_contacto__c(Id = habiliModificable.Id);
        delete habiliModificable;
        
        list<Habilidad_del_contacto__c> habiliActualizado = [select id from Habilidad_del_contacto__c];
        system.assertEquals(9, habiliActualizado.size());
        
        undelete idhabili;
        list<Habilidad_del_contacto__c> habiliUndeleteado = [select id from Habilidad_del_contacto__c];
        system.assertEquals(10, habiliUndeleteado.size());
    }
}