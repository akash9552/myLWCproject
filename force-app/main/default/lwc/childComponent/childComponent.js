import { LightningElement, api } from 'lwc';

export default class ChildComponent extends LightningElement {
    @api
    childName='child value';
    @api
    childFunction(){
       // console.log('child function called');
        alert('child function called');
        this.childName=('value changed after parent call');
    }
}