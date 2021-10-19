import { LightningElement, wire, api } from 'lwc';
import getSites from '@salesforce/apex/PortfolioSiteController.getSites';
import { refreshApex } from '@salesforce/apex';
import updateSites from '@salesforce/apex/PortfolioSiteController.updateSites';
import { getRecordNotifyChange } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import searchedSites from '@salesforce/apex/PortfolioSiteController.searchedSites';


//This is the list of fields that show in the Portfolio App
const COLS = [
    { label: 'Tower Number', fieldName: 'Name'},
    { label: 'Tower Name', fieldName: 'Tower_Name__c' },
    { label: 'Tower Class', fieldName: 'Tower_Class__c' },             
    { label: 'Ownership Change in Process', fieldName: 'Ownership_Change_in_Process__c', type: 'boolean', editable: true },
    { label: 'Negotiations in Progress', fieldName: 'Negotiations_in_Progress__c', type: 'boolean', editable: true },
    { label: 'Do Not Contact LL Flag', fieldName: 'Do_Not_Contact_LL_REAM__c', type: 'boolean', editable: true }
];
export default class PortfolioSiteAssignment extends LightningElement {

    @api recordId;    
    columns = COLS;
    draftValues = [];
    searchId = '';
    
    totalSites;
    visibleSites;
    searchValue = '';    

    @wire(getSites, { portfolioId: '$recordId' })
    site;  

    //wire service is used to obtain and manipulate data inside the application
    @wire(getSites, {portfolioId: '$recordId'})
    wiredSites({error, data}){
        if(data){
            this.totalSites = data;
            console.log(this.totalSites);
        }
        if(error){
            console.error(error);
        }
    }    
   
    //Used with search feature. Can be disabled.
    searchKeyword(event){
        this.searchValue = event.detail.value;        
        console.log('Search Value is: ' + this.searchValue);
        console.log('Record Id is: ' + this.recordId);
        this.searchId = this.recordId;                
    }

    //Used with Search
    handleSearchKeyword(){
        if(this.searchValue !== ''){
            console.log('Search Value line 64 is: ' + this.searchValue);
            console.log('Record Id at line 65 is: ' + this.searchId);
            searchedSites({portfolioId: this.searchId, searchKey: this.searchValue})            
            .then (result => {
                this.totalSites = result;
                console.log('Result is: ' + result);
            })
            .catch(error => {
                const event = new ShowToastEvent({
                    title: 'Error',
                    variant:'error',
                    message: error.body.message,
                });
                this.dispatchEvent(event);
                this.contactsRecord = null;
            });
        } else{
            const event = new ShowToastEvent({
                variant: 'error',
                message: 'Search text missing...',
            });
            this.dispatchEvent(event);
        }

    }
    
    //This is the heart of the app. Handles the saves, sends a toast message and refreshes the list of Sites and their values.
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
            }));

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

    updateHandler(event){
        this.visibleSites=[...event.detail.records];
        console.log(event.detail.records);
    }

    refreshPages(){
        return refreshApex(this.totalSites);
    }
}