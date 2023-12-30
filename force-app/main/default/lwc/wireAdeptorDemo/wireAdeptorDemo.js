import { LightningElement, wire, api} from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';

//import NAME_FIELD from '@salesforce/schema/Account.Website';
//import PHONE_FIELD from '@salesforce/schema/Account.Phone';


export default class WireAdeptorDemo extends LightningElement {
    @api recordId;

    @wire(getRecord, {recordId:'$recordId', fields :['Account.Name', 'Account.Phone']})
    record;

    get name(){
        //return this.record.data ? getFieldValue(This.record.data,'Account.Name'): '';
        return this.record.data.fields.Name.value;
     }
    get phone(){
        //return this.record.data ? getFieldValue(This.record.data,'Account.name'): '';
        return this.record.data.fields.Phone.value;
    }
}