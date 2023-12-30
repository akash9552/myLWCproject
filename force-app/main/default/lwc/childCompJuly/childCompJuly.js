import { LightningElement,api,track} from 'lwc';

export default class ChildCompJuly extends LightningElement {

    @api message;
    @api pageNo;
    @track trackProp;
    dt=new Date();

    childMessage = "Messge Passed From child To Parent";

    @api
    childMethod(messageFromParent,pageNumber){
      
         this.message = messageFromParent;
         this.pageNo = pageNumber;
         this.dt=new Date();

    }
    handleButtonClick(){
         const passData = new CustomEvent("passdatatoparent",{detail:this.childMessage});
         this.dispatchEvent(passData);
    
    }
}