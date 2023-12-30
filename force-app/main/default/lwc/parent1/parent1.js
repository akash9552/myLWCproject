import { LightningElement } from 'lwc';

export default class Parent1 extends LightningElement {
    parentFunction1(){
        this.template.querySelector('c-child1').childFunction1();
    }
    parentFunction2(){
        this.template.querySelector('c-child1').childFunction2();
    }
}