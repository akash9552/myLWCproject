import { LightningElement, wire } from 'lwc';
import accountRecords from '@salesforce/apex/LWC_ComponentClass2.accountRecords';

export default class LightningDatatableComponent extends LightningElement {

    fetchedAccounts;
    
    columns = [{
            label: 'Account name',
            fieldName: 'Name',
            type: 'text',
            sortable: true
        },
        {
            label: 'Phone',
            fieldName: 'Phone',
            type: 'phone',
            sortable: true
        }
    ];

    @wire(accountRecords)
    wiredAccounts({ error, data }) {
        if (data) {
            this.fetchedAccounts = data;
        } else if (error) {
            console.log(error);
        }
    }
}