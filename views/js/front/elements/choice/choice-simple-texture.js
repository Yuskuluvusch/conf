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
CONFIGURATOR.ELEMENTS = CONFIGURATOR.ELEMENTS || {};
CONFIGURATOR.ELEMENTS.CHOICE = CONFIGURATOR.ELEMENTS.CHOICE || {};

CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimpleTexture = function(step, parent){
    
    var Super = Object.getPrototypeOf(this);

    /**
     * "Zoom" element displayed on custom textures in order to zoom on it
     * (pop up like).
     */
    this.zoom_class = 'configurator-zoom';

    /**
     * Allows to catch click on textures and redirect it to the input
     * 'this' MUST be binded to the current object (using $.proxy for example)
     * @param {jQuery.Event} event Click event
     */
    this.redirectClick = function(event) {
        var target = $(event.target);
        // check if click originated from zoom element
        // if so cancel current action
        if (target.hasClass(this.zoom_class) || 
            target.parent().hasClass(this.zoom_class)) {
            return true;
        }
        
        if (!target.is('input')) {
            event.preventDefault();
            this.targetEvent.trigger('click');
        }
    };
    
    this.bind = function() {
        Super.bind.call(this);
        this.getHTMLElement().bind('click', $.proxy(this.redirectClick, this));
    };

    this.unbind = function() {
        Super.unbind.call(this);
        this.getHTMLElement().unbind('click', $.proxy(this.redirectClick, this));
    };

    if (step) {
        this.init(step, parent);  
    }
};


CONFIGURATOR.ELEMENTS.dispatch.registerObject('choice_simple_texture', CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimpleTexture);
CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimpleTexture.prototype = new CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimple;
