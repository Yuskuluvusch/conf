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

/*********************************
 * *******************************
 *		SERVICE LOOPER :
 *		Permet de boucler jusqu'à
 *		une certaine condition
 * *******************************
 ********************************/
var CONFIGURATOR = CONFIGURATOR || {};
CONFIGURATOR.Looper = (function(){
	/**
	 * PRIVATE
	 */
	var looper;
	var current_loop = 0;
	var nb_max_loop = 30;
	var stopinterval = false;
	
	/**
	 * PUBLIC
	 */
    var self = {};

	self.exec = function(callback, ms) {
		looper = setInterval(function(){
			if (current_loop === nb_max_loop || stopinterval) {
				clearInterval(looper);
				current_loop = 0;
				stopinterval = false;
				return;
			}
			
			if (typeof callback === 'function') {
				stopinterval = callback();
			}
			
			current_loop++;
		}, ms);
	};
	
	/**
	 * RETURN PUBLIC PROPERTIES AND METHODS
	 */
    return self;
})();

/**************************************
 * ************************************
 *		OVERRIDE AUTOCOMPLETE.JS
 * ************************************
 *************************************/
CONFIGURATOR.OldAutocompleterSelect = function(){};
CONFIGURATOR.AutocompleterSelect = function (options, input, select, config) {
	
	/**
	 * PRIVE
	 */
	var cache;
	var parent = CONFIGURATOR.OldAutocompleterSelect(options, input, select, config);
	
	var limitNumberOfItems = function(available) {
		return options.max && options.max < available
			? options.max
			: available;
	};
	
	/**
	 * Vérification ajax que le produit est un produit fictif
	 */
	var getIdsProductDuplicated = function() {
		
		var results;
		
		$.ajax({
			url: window.location.href.split('/').slice(0, -2).join('/')+'/modules/configurator/ajax.php?getidsproductduplicated',
			type: "GET",
			async: false, // Mode synchrone
			success: function(data){
				results = JSON.parse(data);
			}
		});
		
		// Mise en cache pour ne pas avoir à refaire l'ajax
		cache = results;
		
		return results;
	};
	
	/**
	 * Fitlre les données de l'autocomplete
	 */
	var filterData = function(d, full) {
		full = full || false;
		var data = new Array();
		var ids_product_duplicated = cache || getIdsProductDuplicated();
		
		for (var i in d) {
			var id_product = 0;
			if (full) {
				id_product = parseInt(d[i].data.id_product);
			} else {
				id_product = parseInt(d[i].data[1]);
			}
			// Verifiy if duplicated product
			if (ids_product_duplicated.indexOf(id_product) < 0) {
				data.push(d[i]);
			}
		}
		
		return data;
	};
	
	/**
	 * PUBLIC
	 */
	var methods = {
		display: function(d, q){
			if (options.url !== 'undefined' && options.url.indexOf('ajax_products_list.php') >= 0) {
				d = filterData(d);
			} else if (options.extraParams !== 'undefined' && options.extraParams.action === 'searchProducts') {
				d = filterData(d, true);
			}

			parent.display(d, q);
		}
	};
	var self = {};
	$.extend(self, parent, methods);
	
	return self;
};

/**
 * On boucle jusqu'à ce que autocomplete.js soit chargé
 */
CONFIGURATOR.Looper.exec(function(){
	
	if (typeof $.Autocompleter === 'function' && typeof $.Autocompleter.Select === 'function') {
		CONFIGURATOR.OldAutocompleterSelect = $.Autocompleter.Select;
		$.Autocompleter.Select = CONFIGURATOR.AutocompleterSelect;
		return true;
	}
	
	return false;
}, 100);