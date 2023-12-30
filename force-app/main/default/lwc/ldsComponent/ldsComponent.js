import { LightningElement, api } from 'lwc';
import NAME_FIELD from '@salesforce/schema/Account.Name';
import PHONE_FIELD from '@salesforce/schema/Account.Phone';
import REVENUE_FIELD from '@salesforce/schema/Account.AnnualRevenue';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
export default class LdsComponent extends LightningElement {


@api objectApiName;

fields = [NAME_FIELD, PHONE_FIELD, REVENUE_FIELD, INDUSTRY_FIELD];
handleSubmit(event){
//you can change values from here
//const fields = event.detail.fields;
//fields.Name = 'My Custom  Name'; // modify a field
console.log('Account detail : ',event.detail.fields);
console.log('Account name : ',event.detail.fields.Name);
    }
}