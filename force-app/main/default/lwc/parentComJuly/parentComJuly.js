import { getDataConnectorSourceFields } from 'lightning/analyticsWaveApi';
import { LightningElement } from 'lwc';

export default class ParentComJuly extends LightningElement {


    handleButtonClick(){
        this.template.querySelector('c-child-comp-july').childMethod("Message pass on Button clicked",25);
    }

    handleDataFromChild(event){
    
        this.messageFromChild = event.detail;
        console.log(messageFromChild);
    }
}