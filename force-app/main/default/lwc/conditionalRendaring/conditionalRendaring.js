import { LightningElement } from 'lwc';

export default class ConditionalRendaring extends LightningElement {
    areDataVisible = false;

    handleChange(event){
        this.areDataVisible = event.target.checked;
    }
}