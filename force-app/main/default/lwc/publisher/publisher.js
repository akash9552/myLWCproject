import { LightningElement,wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { fireEvent } from 'c/pubsubComponenet';


export default class Publisher extends LightningElement {
    inputValue;

    @wire(CurrentPageReference) pageRef;

    handleChange(event) {
        this.inputValue = event.target.value;
    }

    publishData() {
        fireEvent(this.pageRef, 'parentPublisher', this.inputValue);
    }

}