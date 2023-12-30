import { LightningElement, wire } from 'lwc';
import contactRecord from '@salesforce/apex/ContactController.getContacts'
import updateAccounts from '@salesforce/apex/ContactController.updateAccounts';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class DataTableInlineediting extends LightningElement {

    conData;
    draftValues ;

    columns=[{
        label: 'Contact name',
            fieldName: 'LastName',
            type: 'text',
            sortable: true,
            editable:true
    },
    {
        label: 'Email',
            fieldName: 'Email',
            type: 'text',
            sortable: true,
            editable:true
    },
    {
        label: 'Phone',
            fieldName: 'Phone',
            type: 'text',
            sortable: true,
            editable:true
    }
   ];

    @wire(contactRecord)
    wiredContact({error,data}){
        if(data){
            this.conData=data;
        }else if(error){
            console.log(error);
        }
    }
    handleSave( event ) {
        const updatedFields = event.detail.draftValues;
        updateAccounts( { data: updatedFields } )
        .then( result => {
        this.dispatchEvent(
        new ShowToastEvent({
        title: 'Success',
        message: 'Accounts updated',
        variant: 'success'
            })
        );
        }).catch( error => {
        this.dispatchEvent(
        new ShowToastEvent({
        title: 'Error updating records',
        message: error,
        variant: 'error'
        })
        );
        });
    }

}