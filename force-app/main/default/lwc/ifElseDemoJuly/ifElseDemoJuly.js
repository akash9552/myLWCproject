import { LightningElement } from 'lwc';

export default class IfElseDemoJuly extends LightningElement {

    isText1 = true;

    Text1 ='you click on Text 1';
    Text2 ='you click on Text 2';
    DisplayText1(){
        this.isText1 = true;
    }
    DisplayText2(){
        this.isText1 = false;
    }
}