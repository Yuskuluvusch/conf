/**
 * 2023 DMConcept
 *
 * NOTICE OF LICENSE
 *
 * This file is licenced under the Software License Agreement.
 * With the purchase or the installation of the software in your application
 * you accept the licence agreement
 *
 * @author    DMConcept <support@dmconcept.fr>
 * @copyright 2023 DMConcept
 * @license   Commercial license (You can not resell or redistribute this software.)
 *
 */
var CONFIGURATOR = CONFIGURATOR || {};
/**
 * ScrollFix - Permet de rentre des éléments fixed au scroll
 * @requires jQuery
 * @requires jquery-scrolltofixed
 */
CONFIGURATOR.ScrollFix = function($){
	// Private
	var element;
	var event_namespace = 'scrollToFixed';
	var plugin_options = {};
	
	function isPluginLoaded() {
		return $.ScrollToFixed !== undefined;
	}
	
	// Public
    var self = {};
	self.init = function(el, pluginOptions) {
		element = el;
		plugin_options = pluginOptions;
	};
	
	self.start = function() {
		if(isPluginLoaded()) {
			$(element).scrollToFixed(plugin_options);
		}
	};
	
	self.stop = function() {
		if(isPluginLoaded()) {
			var j_element = $(element);
			var isInstantiated  = !! $.data(j_element.get(0));
			if (isInstantiated) {
				$.removeData(j_element.get(0));
				j_element.off(event_namespace);
				j_element.unbind('.' + event_namespace);
			}
		}
	};
	
	// return Public properties and method
    return self;
};