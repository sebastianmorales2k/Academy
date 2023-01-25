import { LightningElement, wire, api } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import obtenerSecciones from '@salesforce/apex/Certificacion.getSecciones';

const COLS  = [
    { label: 'Nombre de seccion', fieldName: 'nombre_de_seccion__c', editable: false },
    { label: 'Resultado', fieldName: 'Resultado__c', editable: true },
];

export default class Registrar_seccion extends LightningElement {
    @api certifId;
    columns = COLS;
    draftValues = [];

    @wire(obtenerSecciones, { certificado: '$certifId' })
    secciones;

    async handleSave(event) {
        // Convert datatable draft values into record objects
        const records = event.detail.draftValues.slice().map((draftValue) => {
            const fields = Object.assign({}, draftValue);
            return { fields };
        });

        // Clear all datatable draft values
        this.draftValues = [];

        try {
            // Update all records in parallel thanks to the UI API
            const recordUpdatePromises = records.map((record) =>
                updateRecord(record)
            );
            await Promise.all(recordUpdatePromises);

            // Report success with a toast
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Secciones Actualizadas',
                    variant: 'success'
                })
            );

            // Display fresh data in the datatable
            await refreshApex(this.secciones);
        } catch (error) {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Hubo un error actualizando los resultados',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        }
    }
}