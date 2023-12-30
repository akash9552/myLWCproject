import { LightningElement } from 'lwc';

export default class RenderComp extends LightningElement {
    Name='defpult Name';

    renderedCallback(){
       //this.Name='Name from render';
    }

    handleClick(){
        this.Name= 'name from button';
    }
}