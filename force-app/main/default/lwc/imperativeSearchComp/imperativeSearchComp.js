import { LightningElement,track,wire } from 'lwc';
import accountRecords from '@salesforce/apex/LWC_ComponentClass.accListMethod';
export default class ImperativeSearchComp extends LightningElement {

    showTable = false;
    @track
    fetchedAccounts;
    handleInput(event){

    accountRecords({inputName:event.target.value}).then(result => {
        this.showTable= true;
        this.fetchedAccounts =result;
    }).catch(error => {
        console.log(error);
    })
}
}