import { LightningElement } from 'lwc';

export default class ParentComponent extends LightningElement {

    parentFunction(){
       //console.log('parent function called');
       alert('parent function called');
        this.template.querySelector('c-child-component').childFunction();
    }
}