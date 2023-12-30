import { LightningElement } from 'lwc';

export default class DataBindingUsingQuerySelector extends LightningElement {

    greeting='Akash';

    handelClick(event){
        this.greeting = this.template.querySelector("lightning-input").value;
    }
}