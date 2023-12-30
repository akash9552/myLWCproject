import { LightningElement, api, wire} from 'lwc';
import ccountRecord from '@salesforce/apex/LWC_ComponentClass2.accListMethod';

export default class WireApexDemo extends LightningElement {

    @wire(ccountRecord)
    fetchAccounts;
    
    }