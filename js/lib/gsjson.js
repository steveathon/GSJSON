/**
 * jQuery GSJSON - jQuery plug-in
 * https://github.com/steveathon/GSJSON
 **/
$(function($) { 
	$.GSJSON = function(e,o){
		var d = {
			search_appliance: null,
			site: 'default_frontend',
			client: 'default_collection',
			oneboxCallback: function () {},
			resultCallback: function () {}
		};
		
		// Reference current instance of the object
		var gsjson = this;
		
		// Merge d and user-provided options
		gsjson.settings = {};
		var start = function () {
			gsjson.settings = $.extend({},d,o);
			gsjson.e = e;
		}
		
		start();
	}
})(jQuery);
