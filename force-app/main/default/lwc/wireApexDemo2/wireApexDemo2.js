import { LightningElement, wire, track} from 'lwc';
import accountRecords from '@salesforce/apex/LWC_ComponentClass.accListMethod';


export default class WireApexDemo2 extends LightningElement {
    @track
    fetchedAccounts;

    @wire(accountRecords)
    wiredAccount({error, data}){
        if(data){
            this.fetchedAccounts = data;
        }
        else if(error){
            conole.log(error);
        }
    }
   

}