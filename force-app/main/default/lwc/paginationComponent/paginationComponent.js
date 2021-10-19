import { LightningElement, api} from 'lwc';

//Pagination component used to parse out the number of records shown in the screen at a time. It does this by slicing the total number of records
//and displaying the correct slice based on the current page of the UI.
export default class PaginationComponent extends LightningElement {

    currentPage = 1;
    totalRecords;
    @api recordSize = 5;    
    totalPage;

    get records(){
        return this.visibleRecords;
    }

    @api
    set records(data){
        if(data){
            console.log(data);
            this.totalRecords = data;
            this.recordSize = Number(this.recordSize);
            this.totalPage = Math.ceil(data.length/this.recordSize);
            this.updateRecords();
            console.log(this.totalRecords);
            console.log(this.recordSize);
            console.log(this.totalPage);
        }

    };

    get disablePrevious(){
        return this.currentPage <= 1;
    }

    get disableNext(){
        return this.currentPage >= this.totalPage;
    }
    
    get disableFirst(){
        return this.currentPage = 1;
    }

    firstHandler(){         
        this.updateRecords();          
                       
    }

    previousHandler() {
        if(this.currentPage > 1){
            this.currentPage = this.currentPage-1;
            this.updateRecords();
        }
    }    

    nextHandler() {
        if(this.currentPage < this.totalPage){
            this.currentPage = this.currentPage +1;
            this.updateRecords();
        }

    }    

    updateRecords(){
        const start = (this.currentPage-1)*this.recordSize;
        const end = this.recordSize*this.currentPage;
        this.visibleRecords = this.totalRecords.slice(start, end);
        this.dispatchEvent(new CustomEvent('update',{
            detail:{
                records:this.visibleRecords
            }
        }));
    }
}