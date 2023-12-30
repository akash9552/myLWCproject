import { LightningElement } from 'lwc';

export default class ChildComp extends LightningElement {

    inputValue;

    handleChange(event){
        this.inputValue= parseInt(event.target.value);

    }
    addNuber(){
        const MyEvent = new CustomEvent('add', {
            detail:this.inputValue
        });
        this.dispatchEvent(MyEvent);
    }
    subtarctNumber(){
        const MyEvent = new CustomEvent('subtract', {
            detail:this.inputValue
        });
        this.dispatchEvent(MyEvent);
        
    }
}