// TODO: complete this object/class // The constructor takes in an array of items and a integer indicating how many // items fit within a single page
function PaginationHelper(collection, itemsPerPage) {
	var instance = this;
	Object.defineProperties(this, {
		__proto__: null,
     	defaultType: {
          value: "web",
          writable: false
      	},
      	load: {
          value: function(type) {
              console.log("LOADED##");
          },
          enumerable: false
      	}
  	});
  	Object.defineProperty(this, "itemsPerPage", { value :itemsPerPage,writable : false });
  	Object.defineProperty(this, "collection", { value :collection,writable : false });
  	var parseArray = new Array();
  	parseArray = collection.slice(0,collection.length);
  	var newCollectArray = new Array();
  	while(parseArray.length>4){
  		var page = parseArray.splice(0,4);
  		newCollectArray.push(page)
  	}
  	newCollectArray.push(parseArray);
  	Object.defineProperty(this, "pages", { value :newCollectArray,writable : false });
}  
// returns the number of items within the entire collection 
PaginationHelper.prototype.itemCount = function() {
	console.log(this.collection.length,"#itemCount#");
	return this.collection.length;
} 
PaginationHelper.prototype.pageCount = function() {  
	console.log(this.pages.length,"#pages#")
	return this.pages.length;
} 
PaginationHelper.prototype.pageItemCount = function(value) { 
	if((value>=this.pages.length) || (value<0)){
		console.log(-1,"#pageItemCount#")
		return -1;
	}
	console.log(this.pages[value].length,"#pageItemCount#")
	return this.pages[value].length;
}
PaginationHelper.prototype.pageIndex = function(value) {
	if((value>=this.collection.length) || (value<0)){
		console.log(-1,"#pageIndex#")
		return -1;
	}
	var valuePage = Math.ceil(value/this.itemsPerPage)-1;
	console.log(valuePage,"#pageIndex#")
	return valuePage;
}


var helper = new PaginationHelper(['a','b','c','d','e','f'], 4);
helper.pageCount(); //should == 2
helper.itemCount(); //should == 6
helper.pageItemCount(0); //should == 4
helper.pageItemCount(1); // last page - should == 2 
helper.pageItemCount(2); // should == -1 since the page is invalid  
// pageIndex takes an item index and returns the page that it belongs on 
helper.pageIndex(5); //should == 1 (zero based index)
helper.pageIndex(2); //should == 0
helper.pageIndex(20); //should == -1
helper.pageIndex(-10); //should == -1   