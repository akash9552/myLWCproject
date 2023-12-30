import { LightningElement } from 'lwc';

export default class PComponent extends LightningElement {
    count = 0;

    addMethod(event) {
        this.count = this.count + event.detail;
    }

    subtractMethod(event) {
        this.count = this.count - event.detail;
    }

}