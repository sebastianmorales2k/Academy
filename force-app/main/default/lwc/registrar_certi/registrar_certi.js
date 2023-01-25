import {api, track, LightningElement, wire } from 'lwc';

import registrar from '@salesforce/apex/Certificacion.obtenerModulo';

import TIPOC from '@salesforce/schema/Intento_de_certificacion__c.Tipo_de_certificaci_n__c';
import CERTI from '@salesforce/schema/Intento_de_certificacion__c.Certificaci_n__c';
import MIEMBRO from '@salesforce/schema/Intento_de_certificacion__c.Miembro_de_la_cohorte__c';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class Registrar_certi extends LightningElement {
    @api recordId;
    certif;
    tipocer;
    certificacion = CERTI;
    tipoCerti = TIPOC;
    miembro = MIEMBRO;
    modalTabla = false;
    modalIntento = true;
    certifId;

    @wire(registrar, {miembroId: '$recordId'})
    prueba({error, data}){
        if(data){
            console.log('resultado-->'+data.tipoCertificacion);
            this.tipocer = data.tipoCertificacion;
            console.log("ese" + data.tipoCertificacion);
            this.certif = data.certificacion;
            console.log(data.certificacion);
        }else if(error){
            console.log(error);
        }
    }

    handleSuccess(event) {
        this.certifId = event.detail.id;
        console.log('Record ID: ' + this.certifId);
        const evt = new ShowToastEvent({
            title: 'Certificación registrada',
            message: 'se ha registrado la certificación',
            variant: 'success',
        });
        this.dispatchEvent(evt);
        this.modalIntento = false;
        this.modalTabla = true
        /* this.generarSecciones(); */
    
    }
}