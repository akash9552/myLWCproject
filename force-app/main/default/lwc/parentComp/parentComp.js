import { LightningElement } from 'lwc';

export default class ParentComp extends LightningElement {
    Count = 0;
    addMethod(event){
        this.Count = this.count + event.detail;
    }
    subtractMethod(event){
        this.Count = this.count - event.detail;
    }
}