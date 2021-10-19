import { LightningElement, wire, api } from 'lwc';
import getSites from '@salesforce/apex/PortfolioSiteController2.getSites';
import { refreshApex } from '@salesforce/apex';
import updateSites from '@salesforce/apex/PortfolioSiteController2.updateSites';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';


const COLS = [
    { label: 'Tower Number', fieldName: 'Name'},
    { label: 'Tower Name', fieldName: 'Tower_Name__c' },
    { label: 'Tower Class', fieldName: 'Tower_Class__c' },    
    /*{ label: 'Do Not Contact LL', fieldName: 'Do_Not_Contact_LL_Picklist__c', type: 'picklist', typeAttributes: {
        placeholder: 'Choose Option', options: [
                { label: 'Do Not Contact LL - Legal Issue', value: 'Do Not Contact LL - Legal Issue'},
                { label: 'Do Not Contact LL - Business Issue', value: 'Do Not Contact LL - Business Issue'},
                { label: 'Do Not Contact LL - ATC No Longer Has Rights to the Site', value: 'Do Not Contact LL - ATC No Longer Has Rights to the Site'}]
        }, editable: true,
        value: {fieldName: 'Do_Not_Contact_LL_Picklist__c'},
        context: {fieldName: 'Name'}
        },*/
    /*{ label: 'Real Estate Portfolio', fieldName: 'Real_Estate_Portfolio__c', type: 'lookup', editable: true, typeAttributes:{
            placeholder: 'Select Portfolio',
            uniqueId: {fieldName: 'Real_Estate_Portfolio__c'}, //pass Id of current record to lookup for context
            object: "Real_Estate_Portfolio__c",
            icon: "standard:account",
            label: "Real Estate Portfolio",
            displayFields: "Name, Real_Estate_Portfolio_Number__c",
            displayFormat: "Name (Real_Estate_Portfolio_Number__c)",
            filters: "",
            valueId: {fieldName: 'Real_Estate_Portfolio__c'} //binding parent ID of current item in row to autopopulate value on load
        } 
    },*/         
    { label: 'Ownership Change in Process', fieldName: 'Ownership_Change_in_Process__c', type: 'boolean', editable: true },
    { label: 'Negotiations in Progress', fieldName: 'Negotiations_in_Progress__c', type: 'boolean', editable: true },
    { label: 'Do Not Contact LL Flag', fieldName: 'Do_Not_Contact_LL_REAM__c', type: 'boolean', editable: true }
];
export default class PortfolioSiteAssignment2 extends LightningElement {

    @api recordId;
    columns = COLS;
    draftValues = [];

    @wire(getSites, { portfolioId: '$recordId' })
    site;

    async handleSave(event) {

        const updatedFields = event.detail.draftValues;

        // Prepare the record IDs for getRecordNotifyChange()
        const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });
       

        // Pass edited fields to the updateContacts Apex controller
        await updateSites({data: updatedFields})
        .then(result => {
            console.log(JSON.stringify("Apex update result: "+ result));
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success!',
                    message: 'Site updated!',
                    variant: 'success'
            })
        );

            // Refresh LDS cache and wires
            getRecordNotifyChange(notifyChangeIds);

            // Display fresh data in the datatable
            return refreshApex(this.site).then(() => {
                // Clear all draft values in the datatable
                this.draftValues = [];
            });

        }).catch(error => {
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Error updating or refreshing record',
                    message: error.body.message,
                    variant: 'error'
                })
            );
        });
    }
}