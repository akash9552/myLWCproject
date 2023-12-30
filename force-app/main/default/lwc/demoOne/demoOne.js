import { LightningElement } from 'lwc';
export default class DemoOne extends LightningElement {

    message;
    
    handleClick(event){
        this.Target.value='hello';
    }

}