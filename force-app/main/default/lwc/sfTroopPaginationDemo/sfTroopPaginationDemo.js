import { LightningElement, wire } from 'lwc';
import getContactList from '@salesforce/apex/DataController.getContactList'
import getAccountList from '@salesforce/apex/DataController.getAccountList'
export default class PaginationDemo extends LightningElement {
    totalContacts
    visibleContacts

    totalAccounts
    visibleAccounts
    @wire(getContactList)
    wiredContact({error, data}){
        if(data){ 
            this.totalContacts = data
            console.log(this.totalContacts)
        }
        if(error){
            console.error(error)
        }
    }

    @wire(getAccountList)
    wiredaccount({error, data}){
        if(data){ 
            this.totalAccounts = data
            console.log(this.totalAccounts)
        }
        if(error){
            console.error(error)
        }
    }

    updateContactHandler(event){
        this.visibleContacts=[...event.detail.records]
        console.log(event.detail.records)
    }
    updateAccountHandler(event){
        this.visibleAccounts=[...event.detail.records]
        console.log(event.detail.records)
    }
}