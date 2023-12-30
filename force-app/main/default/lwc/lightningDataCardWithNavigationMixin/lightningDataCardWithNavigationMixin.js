import { LightningElement, wire } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import accountRecords from '@salesforce/apex/LWC_ComponentClass2.accountRecords';
import { deleteRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { refreshApex } from '@salesforce/apex';

export default class LightningDatatableComponent extends NavigationMixin(LightningElement) {

    fetchedAccounts;    //accountList
    wiredAccountList;
    actions = [
        {label: 'View', name: 'view'},
        {label: 'Edit', name: 'edit'},
        {label: 'Delete', name: 'delete'}
    ];

    columns = [{
            label: 'Account name',
            fieldName: 'Name',
            type: 'text'
        },
        {
            label: 'Type',
            fieldName: 'Type',
            type: 'text'
        },
        {
            label: 'Annual Revenue',
            fieldName: 'AnnualRevenue',
            type: 'Currency'
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone'
        },
        {
            label: 'Website',
            fieldName: 'Website',
            type: 'url'
        },
        {
            label: 'Rating',
            fieldName: 'Rating',
            type: 'text'
        },
        {
            label: 'Email',
            fieldName: 'Email__c',
            type: 'Email'
        },
        {
            type: 'action',
            typeAttributes: { rowActions: this.actions },
        }
    ];

    @wire(accountRecords) accList(result) {
        this.wiredAccountList = result;

        if (result.data) {
            this.fetchedAccounts = result.data;
            this.error = undefined;
        } else if (result.error) {
            this.error = result.error;
            this.fetchedAccounts = [];
        }
    }

    handleRowAction(event) {
        console.log('Handle Row Method ran');
        console.log('Clicked row record Id ==> '+event.detail.row.Id);

        if(event.detail.action.name === 'view') {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.row.Id,
                    objectApiName: 'Account',
                    actionName: 'view'
                },
            });
        } else if(event.detail.action.name === 'edit') {
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: event.detail.row.Id,
                    objectApiName: 'Account',
                    actionName: 'edit'
                },
            });
            console.log('Component is ready to get refreshed');
            return refreshApex(this.wiredAccountList);
        } else if(event.detail.action.name === 'delete') {
            deleteRecord(event.detail.row.Id)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Record deleted',
                        variant: 'success'
                    })
                );
                return refreshApex(this.wiredAccountList);
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error deleting record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
        }
    }
}