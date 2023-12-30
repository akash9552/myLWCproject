import { LightningElement, wire } from 'lwc';
import { CurrentPageReference } from 'lightning/navigation';
import { registerListener } from 'c/pubsubComponenet';

export default class Subscriber extends LightningElement {
    receivedValue;

    @wire(CurrentPageReference) pageRef;

    connectedCallback() {
        registerListener('parentPublisher', this.handlePublisherMethod, this);
    }

    handlePublisherMethod(data) {
        this.receivedValue = data;
    }

}