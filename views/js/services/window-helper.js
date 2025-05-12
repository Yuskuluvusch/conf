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
 * Helper pour les manipulations par rapport à l'écran
 */
CONFIGURATOR.WindowHelper = (function(){
	// Private
	var mobile_breakpoint = 768;
	var tablet_breakpoint = 992;
	
	// Public
    var self = {};
    self.getWidth = function(){
		return (navigator.userAgent.indexOf('Macintosh') > -1 && navigator.userAgent.indexOf('Safari/') > -1 ? $(window).width() : window.innerWidth);
    };
	
	self.isMobile = function() {
		return self.getWidth() < mobile_breakpoint;
	};
	
	self.isTablet = function() {
		var width = self.getWidth();
		return width >= mobile_breakpoint && width < tablet_breakpoint;
	};
	
	self.isDesktop = function() {
		var width = self.getWidth();
		return width >= tablet_breakpoint;
	};
	
	// return Public properties and method
    return self;
})();