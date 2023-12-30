import { LightningElement } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class PracticeLwcComp extends LightningElement {

    infoButton(){
        const event = new ShowToastEvent({
            title: 'Info Toast title',
            message: 'info Toast Message',
            variant: 'Info',
            mode: 'dismissable'
        });
        this.dispatchEvent(event);
    }
    successButton(){
        const event = new ShowToastEvent({
            title: 'Success Toast title',
            message: 'Success Toast Message',
            variant: 'Success',
             mode: 'pester'
        });
        this.dispatchEvent(event);
    }
    warningButton(){
        const event = new ShowToastEvent({
            title: 'Warning Toast title',
            message: 'Warning Toast Message',
            variant: 'Warning',
            mode: 'Sticky'
        });
        this.dispatchEvent(event);
    }
    errorButton(){
        const event = new ShowToastEvent({
            title: 'Error Toast title',
            message: 'Error Toast Message',
            variant: 'Error',
            
        });
        this.dispatchEvent(event);
    }

}