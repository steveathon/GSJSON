/**
 * jQuery GSJSON - jQuery plug-in
 * https://github.com/steveathon/GSJSON
 **/
;(function($) { 
	$.fn.GSJSON = function (o) {
		var s = {
			uri:null,
			collection:'default_collection',
			frontend:'default_frontend',
			query:null,
			callback: function (e) { return $('<div>'+e.T+'</div>'); }
		};
		
		var gsjson = this;
		gsjson.settings = $.extend({},s,o);
		$.getJSON(gsjson.settings.uri+'/search?q='+gsjson.settings.query+'&client='+gsjson.settings.frontend+'&site='+gsjson.settings.collection+'&output=xml_no_dtd&proxystylesheet=json_frontend&proxyreload=1&callback=?',function(data){
			$.each(data.GSP.RES.R,function (key,val) {
				if(gsjson.settings.callback)
					$(gsjson.settings.callback(val)).appendTo($(gsjson));
			})
		});
	}
})(jQuery);
