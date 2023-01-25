public with sharing class Certificacion {

    @AuraEnabled(cacheable = true)
    public static certiWrapper obtenerModulo(string miembroId) {
        Miembro_de_la_cohorte__c miembro = [SELECT id, Name, Cohorte__c FROM Miembro_de_la_cohorte__c WHERE Id =:miembroId LIMIT 1];
        Cohorte__c cohorte = [SELECT Id, Name, Modulo__c FROM Cohorte__c WHERE id =:miembro.Cohorte__c LIMIT 1];
        M_dulo__c modulo = [SELECT id, Name, Certificaci_n__c, Tipo_de_certificaci_n__c FROM M_dulo__c WHERE id =:cohorte.Modulo__c LIMIT 1];
        certiWrapper resultado = new certiWrapper(modulo.Tipo_de_certificaci_n__c, modulo.Certificaci_n__c);
        return resultado;
    }

    @AuraEnabled(cacheable = true)
    public static List<resultadoSeccion> obtenerResultadoSecc(string certificado){
        try {
            List<Resultado_de_secci_n__c> seccionesNuevaCerti = [SELECT id, Certificaci_n__c, Secciones_de_certificaci_n__r.Name, Resultado__c 
                                                                FROM Resultado_de_secci_n__c 
                                                                WHERE Certificaci_n__c =: certificado];
            List<resultadoSeccion> listaSecciones = new list<resultadoSeccion>();
            for(Resultado_de_secci_n__c secc:seccionesNuevaCerti){
                resultadoSeccion res = new resultadoSeccion((string)secc.id, secc.Secciones_de_certificaci_n__r.Name,secc.Resultado__c);
                listaSecciones.add(res);
            }
            return listaSecciones;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled(cacheable = true)
    public static List<Resultado_de_secci_n__c> getSecciones(string certificado){
        return [
            SELECT id, Certificaci_n__c, nombre_de_seccion__c, Resultado__c
            FROM Resultado_de_secci_n__c
            WHERE Certificaci_n__c =: certificado
        ];
    }

    @AuraEnabled(cacheable = true)
    public static List<RecordType> getRecordType(string recordTypeName){
        return [
            SELECT id, Name
            FROM RecordType
            WHERE name =: recordTypeName
        ];
    }

    public class certiWrapper{
        @AuraEnabled
        public string tipoCertificacion;
        @AuraEnabled
        public string certificacion;

        public certiWrapper(string tipoCertifi, string certifi){
            this.tipoCertificacion = tipoCertifi;
            this.certificacion = certifi;
        }
    }

    public class resultadoSeccion 
    {
        @AuraEnabled 
        public string idsecc {get;set;} 
        @AuraEnabled 
        public string nombresecc {get;set;}
        @AuraEnabled 
        public decimal Resultadosecc {get;set;}

        public resultadoSeccion(string id,string nombre, decimal result){
            idsecc = id;
            nombresecc = nombre;
            Resultadosecc = result;
        }
    }
}