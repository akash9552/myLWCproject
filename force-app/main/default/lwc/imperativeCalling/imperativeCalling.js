import { LightningElement, track } from 'lwc';
import accountRecords from '@salesforce/apex/LWC_ComponentClass.accListMethod';

export default class ImperativeCalling extends LightningElement {
    
    showTable = false;
    @track
    fetchedAccounts;

    handleClick(){
        accountRecords().then(result =>{
            this.showTable =true;
            this.fetchedAccounts =result;
        }).catch(error =>{
            console.log(error);
        });
    }
}