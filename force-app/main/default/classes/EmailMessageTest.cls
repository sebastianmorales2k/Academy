@istest
public with sharing class EmailMessageTest {

    @TestSetup
    static void makeData(){
        Lead candidato = new Lead(FirstName = 'Prueba', LastName='1', company = 'E-volution', email = 'kristiano1120@hotmail.com');
        insert candidato;

        /* EmailServicesFunction esf = new EmailServicesFunction(FunctionName = 'Test Email service function', IsActive = true, ApexClassId = '01pDn00000IUSoKIAX');
        insert esf;
        EmailServicesAddress esa = new EmailServicesAddress(LocalPart = 'Test Email service address', IsActive = true);
        insert esa; */

        /*EmailTemplate template = new EmailTemplate(Name = 'Test template', DeveloperName = 'Test_template', 
                                           FolderId = '00lDn000000hi4kIAA', TemplateType= 'custom');
        Insert template;*/

        

    }

    @istest
    static void sendEmailWithAtt() {        
        Lead can = [SELECT id, Name, Email FROM Lead limit 1];

        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();
        Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.binaryAttachments;
        email.subject = 'Test Attachment';
        email.fromAddress = can.Email;
        email.plainTextBody = 'Hola ' + can.Name + ', esto es un mensaje de prueba';
        Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'Hoja de vida.pdf';
        attachment.mimeTypeSubType = 'application/pdf';
        email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

        EmailMessage em = new EmailMessage();
        em.handleInboundEmail(email, env);
        
        System.assertEquals('Hoja de vida.pdf', attachment.fileName);
                
    }

    @istest
    static void sendEmailWithouthAtt() {        
        Lead can = [SELECT id, Name, Email FROM Lead limit 1];

        Messaging.InboundEmail email = new Messaging.InboundEmail();
        Messaging.InboundEnvelope env    = new Messaging.InboundEnvelope();
        Messaging.InboundEmail.BinaryAttachment[] bAttachments = email.binaryAttachments;
        email.subject = 'Test Attachment';
        email.fromAddress = can.Email;
        email.plainTextBody = 'Hola ' + can.Name + ', esto es un mensaje de prueba';
        /* Messaging.InboundEmail.BinaryAttachment attachment = new Messaging.InboundEmail.BinaryAttachment();
        attachment.body = blob.valueOf('my attachment text');
        attachment.fileName = 'Hoja de vida.pdf';
        attachment.mimeTypeSubType = 'application/pdf'; */
        //email.binaryAttachments = new Messaging.inboundEmail.BinaryAttachment[] { attachment };

        EmailMessage em = new EmailMessage();
        em.handleInboundEmail(email, env);
        
        System.assertEquals(null, email.binaryAttachments);
                
    }
}