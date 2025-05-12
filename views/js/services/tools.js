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
 * Package de méthodes utilitaires
 */
CONFIGURATOR.Tools = (function(){
	/**
	 * PRIVATE
	 */
	
	/**
	 * PUBLIC
	 */
    var self = {};

	// Redéfinition de parseInt de ecmascript
	self.parseInt = function(number, default_number) {
		var base = 10;
		default_number = parseInt(default_number,base) || 0;
		return parseInt(number,base) || default_number;
	};

	// Permet de mettre le 1er caractère en majuscule
	self.ucfirst = function(string) {
		return string.charAt(0).toUpperCase() + string.slice(1);
	};

	/**
	 * RETURN PUBLIC PROPERTIES AND METHODS
	 */
    return self;
})();