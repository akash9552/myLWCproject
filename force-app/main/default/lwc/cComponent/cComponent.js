import { LightningElement, api } from 'lwc';

export default class CComponent extends LightningElement {

    inputValue;

    handleChange(event) {
        this.inputValue = parseInt(event.target.value);
    }

    handleAdd() {
        const myEvent = new CustomEvent('add', {
            detail: this.inputValue
        });
        this.dispatchEvent(myEvent);
    }

    handleSubtract() {
        const myEvent = new CustomEvent('subtract', {
            detail: this.inputValue
        });
        this.dispatchEvent(myEvent);
    }

    
}