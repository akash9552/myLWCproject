import { LightningElement } from 'lwc';

export default class RenderingListForEach extends LightningElement {
    contacts = [
        {
            Id:1,
            Name:'Akash Gutte',
            title:'founder of svcc'
        },
        {
            Id:2,
            Name:'Kiran Mhase',
            title:'ceo of svcc'
        },
        {
            Id:3,
            Name:'Arjun Gutte',
            title:'Adviser of svcc'
        }
        
    ];
}