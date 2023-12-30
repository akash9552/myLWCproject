import { LightningElement,api } from 'lwc';

export default class SpinnerComp extends LightningElement {
    @api isLoaded = false;

    handleClick(){
        this.isLoaded =! this.isLoaded;
    }
}