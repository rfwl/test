

//====================================================
//http://forums.karamasoft.com/ShowPost.aspx?PostID=4398
//Create a HashTable object using the associative array functionality. 
// HashTable object have two properties: hashArr: stores key/value pairs ; length: the number of items.
// Four methods: 
// get: retrieve the value for a given key, 
// put: add a key/value pair to the hash table, 
// remove:  remove a key/value pair from the hash table,  
// has : return whether given key value exists in the hash table.
		
function HashTable(){
	this.hashArr = new Array();
	this.length = 0;
}

HashTable.prototype.get = function(key) {
	return this.hashArr[key];
};

HashTable.prototype.put = function(key, value) {
	if (typeof(this.hashArr[key]) == 'undefined') {
		this.length++;
	};

	this.hashArr[key] = value;
};

HashTable.prototype.remove = function(key) {
	if (typeof(this.hashArr[key]) != 'undefined') {
		this.length--;
		var value = this.hashArr[key];
		delete this.hashArr[key];
		return value;
	}
};

HashTable.prototype.has = function(key) {
	return (typeof(this.hashArr[key]) != 'undefined');
};
//-----------------------------------------------------
// test codes
//var phoneLookup = new HashTable();
//phoneLookup.put('Jane', '111-222-3333');
//phoneLookup.put('John', '444-555-6666');
//alert(phoneLookup.get('Jane'));
//====================================================

buildHTMLFromData: function (contextData) {
    var str = '';
	if(!this.validateData(contextData)) return str;
    str = this.htmlTemplate;
    str = str.replace(/{ELEMENT_ID}/g, 'tagItem' + contextData.id.toString());
    str = str.replace(/{INSTANCE_NAME}/g, this.instanceName);
    str = str.replace(/{TAG_ID}/g, dataContext.id);
    str = str.replace(/{TAG_TEXT}/g, dataContext.text);
    str = str.replace(/{TAG_DESCRIPTION}/g, dataContext.description);       
    return this.addInstanceIdPrefix(str);
},	

buildHTML : function() { 
	var str='';
	if(!this.validateData(this.dataContext)) return str;	
	str=buildHTMLFromData(this.dataContext);
	return str;
},

//====================================================
// Generic View Builder
var GenericViewBuilder = {
		//=================================================================================================
	    // Data must have a string id as the host elements.
		// Item VB will produce HTML only, not set-up HTML element into the document.
		// Parent VB and IdPrefix chain passed into the children VB.
		// Better to have DataContext Type Name like TagItem so we can generate more codes in generic VB.
		//
		//
		//=================================================================================================
	    // Instance  
	    instanceName: 'GenericViewBuilder',	  	 
		instanceIdPrefix: '',	
		//=================================================================================================
	    // Init Host Elements
	    hostHTMLElement : null,    
	    
	    initHTMLTemplate : '',
		
	    initHTML : function() {
			return this.initHTMLTemplate;
		},
		
		init : function() {
		 	if(!this.hostHTMLElement) return;
	    	this.hostHTMLElement.outerHTML = this.initHTML();   	
		},
		
	    initOnHost : function(hostElement) {
	    	if(!hostElement) return;
	    	this.hostHTMLElement=hostElement;
			this.init();
		},
		
		show : function() {
			if(!this.hostHTMLElement) return;
			this.hostHTMLElement.style.display='block';
		},
		
		hide : function(){
			if(!this.hostHTMLElement) return;
			this.hostHTMLElement.style.display='none';
		},
			
	    //=================================================================================================
	    // Layout Children
	    layoutChildren : function() {
			
		},
	    //=================================================================================================
	    // Render Data Context
		dataContext: null,    
		

		buildHTMLFromData: function (dataObject) {
	        var str = '';
			if(!this.validateData(dataObject)) return str;
			
	        return this.addInstanceIdPrefix(str);
	    },	
	    
		buildHTML : function() { 
			var str='';
			if(!this.validateData(this.dataContext)) return str;	
			str=buildHTMLFromData(this.dataContext);
			return str;
		},
		
	    render: function () {
	    	if(!this.hostHTMLElement) return;
			if(!this.dataContext) return;
			this.hostHTMLElement.outerText = this.buildHTML();
	    },
			
		renderOnHost: function (hostElement) {    	
			this.hostHTMLElement=hostElement;		
			this.render();
	    },	

		renderData: function (dataObject) {
			this.dataContext=dataObject;
	    	this.render();
	    },	
		
		renderDataOnHost: function (dataObject,hostElement) {    	
			this.hostHTMLElement=hostElement;		
			this.dataContext=dataObject;    	
			this.render();
	    },
		
		validateData: function (dataObject) { // Check if the object is valid to deliver its functions.
	        if (!dataObject) return false;
	        //if (dataObject instanceof dataObject == false) return false;
	        return true;
	    },
		
		addInstanceIdPrefix: function(str) {
	    	 if(this.instanceIdPrefix &&	this.instanceIdPrefix.length>0)
	         	str = str.replace(/ id=\'/g, ' id=\'' + this.instancePrefixId);
	    	return str;
	    },

	    //=================================================================================================
	    // Identify View and Data 
	    getHostId: function (dataId) { 
			if(!dataId) return '';
	        return '';
	    },
	    
	    getDataId: function (hostId) { 
			if(!hostId) return '';
			return '';
	    },
	    
	    getHost: function (dataId) {        
	        return document.getElementById(this.getHostId(dataId));
	    },
	    
	    getData: function (hostId) {        
	        return TagItemLibrary.getItemById(this.getDataId(hostId)); 
	    },
	    
	    //=================================================================================================
	    // Event Listeners.
	   
	    //=================================================================================================
	    // Message Handlers    
	    registerMessages : function() {
	    	
	    }, 
	    //=================================================================================================
	    // Data Change Responders

	    //=================================================================================================
	    // Helpers  

	    //=================================================================================================
	    // Other 
	    
	    
	} // end of GenericViewBuilder


//====================================================
// Function Running Session: Might be in mature desing later. 
var FunctionRunningSession = {
	instance : null;
	operation : null;
	arguments : [];
	returnValue : null;

} // end of FunctionRunningSession


var FunctionBinder={
		
		


} // end of FunctionBinder


//============================================================================================
//FWL20150203
var FunctionInvoker = function (instance, functionDef, argsArray) {
 this.thisInstance = instance;
 this.functionDefinition = functionDef;
 this.argumentsArray = argsArray;
 this.invoke = function () {
     // The next two lines were disabled for allowing function being called without this instance, i.e. window will be the this instance.
     //if (!this.thisInstance) return;
     //if (this.thisInstance instanceof Function) return;
     if (!this.functionDefinition) return;
     if (!this.functionDefinition instanceof Function) return;
     this.functionDefinition.apply(this.thisInstance, this.argumentsArray);
 }
}

//====================================================
// Single central management for matching Host Element ID and Data Context ID
var IDPair=	{
	objHostToData : {};
	objDataToHost : {};
	
	addDataOnHost : function(dataId,hstId) {
		this.objHostToData[hstId]=dataId;
		this.objDataToHost[dataId]=hostId;
	}
	
	getHostId : function (dataId) {
		return this.objDataToHost[dataId];
	}
	
	getDataId : function (hostId) {
		return this.objHostToData[hstId];
	}
	
	removeHostId : function (dataId) {
		delete this.objDataToHost[dataId];
	}
	
	removeDataId : function (hostId) {
		delete this.objHostToData[hstId];
	}
};
//====================================================
// Tag Library Use Cases:
1> Initialize UI



2> Get All Tags into Tag List View
Host web page:
TagItemLibrary.getAllTags()

Messager
TagListViewBuilder.



3> Move Tags in the Tag List 
3.1> Move forward,backward, before the first, before the last 
3.2> Move to after the last
4> Create New Tag
5> Edit Tag
6> Delete Tag
7> Drag Tag to the Note_Tag List View.


//====================================================
// Note Library Use Cases:
1> Initialize UI

2> Get All Notes into Note List View

3> Create a Note

4> Edit a Note

5> Delete a Note

6> Search Notes 

6.1> Select Note and put its Tags into Search Note_Tag List View  

6.2> Find matching notes and load them into Note List View



7> Receive Tags by droppng it into Note_Tag List Views.

8> Move Tags in the Note_Tag List Views:
8.1> Move forward,backward, before the first, before the last 
8.2> Move to after the last	


	
//====================================================


//====================================================