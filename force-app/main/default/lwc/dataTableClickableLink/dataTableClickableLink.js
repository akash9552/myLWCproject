import { LightningElement,wire } from 'lwc';
import contactRecords from '@salesforce/apex/ContactControllerClass.conList';
export default class DataTableClickableLink extends LightningElement {

    fetchedContact;

    columns = [
        {
            label: 'Contact',
            fieldName: 'conLink',
            type: 'url',
            typeAttributes: { label: { fieldName: 'Name' }, target: '_blank' }
        }, {
            label: 'Email',
            fieldName: 'Email',
            type: 'url',
           // typeAttributes: { label: { fieldName: 'Email' }, target: '_blank' }
        }
    ];

    @wire(contactRecords)
    wiredContact({data,error}){
        if (data) {
            data = JSON.parse(JSON.stringify(data));
            data.forEach(res => {
                res.conLink = '/' + res.Id;
            });
            this.fetchedContact = data;
            this.error = undefined;
        } else if (error) {
            this.error = error;
        }
    }
}