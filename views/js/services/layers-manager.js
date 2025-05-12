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
 * Gestionnaire de layers pour les images
 * @requires jQuery
 */
CONFIGURATOR.LayersManager = (function($){
	/**
	 * PRIVATE
	 */
	var prefix_id = 'configurator-layer-';
	var layers = new Array();
	var element = '#image-block-viewer2d';
	
	var addLayer = function(id, zindex, image) {
		var pic_id = prefix_id+id;
		var ts = new Date().getTime();
		$(element).append($('<img />', {
			'id': pic_id,
			'src': image + '?t='+ts,
			'style' : 'max-width:100%;max-height:100%;position:absolute;top:0;left:0;z-index: '+zindex+';'
		}));
	};
	
	var removeLayer = function(id) {
		var pic_id = prefix_id+id;
		$('#'+pic_id).remove();
	};
	
	/**
	 * PUBLIC
	 */
    var self = {};

	self.getElement = function() {
		return element;
	};

	self.setElement = function(el) {
		element = el;
	};

	self.get = function() {
		return layers;
	};

	self.set = function(lyrs) {
		if (Array.isArray(lyrs)) {
			layers = lyrs;
		}
	};

	/**
	 * Applique les layers sur l'élément
	 */
	self.apply = function() {
		for(var i in layers) {
			var layer = layers[i];
			addLayer(
				layer['id'],
				layer['position'],
				layer['image']
			);
		}
	};

	/**
	 * Ajoute un layer à la liste
	 */
	self.add = function(id, position, image) {
		// Pour éviter l'ajout de couches supplémentaires
		if (self.find(id)) {
			return;
		}
		layers.push({
			'id' : id,
			'position' : position,
			'image' : image
		});
		// Add image on picture
		addLayer(id, position, image);
	};
	
	/**
	 * Retourne un boolean permettant de
	 * savoir si le layer existe déjà ou non
	 */
	self.find = function(id) {
		var index = layers.length;
		while (index--) {
			var id_layer = id;
			var layer = layers[index];
			
			if (id_layer === undefined){
				id_layer = layer.id;
			}
			
			if (id === layer.id) {
				return true;
			}
		}
		return false;
	};
	
	/**
	 * Supprime les layers de la liste.
	 * Peut être un id précis
	 */
	self.remove = function(id) {
		var index = layers.length;
		while (index--) {
			var id_layer = id;
			var layer = layers[index];
			
			if(id_layer === undefined){
				id_layer = layer.id;
			}
			
			if(id === layer.id) {
				removeLayer(id);
				layers.splice(index,1);
			}
		}
	};

	/**
	 * RETURN PUBLIC PROPERTIES AND METHODS
	 */
    return self;
})(jQuery);