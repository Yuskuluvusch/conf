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

CONFIGURATOR.ELEMENTS.CHOICE.ChoiceMultipleTexture = function(step, parent){
    
    var Super = Object.getPrototypeOf(this);

    /**
     * Tricky way to do multiple inheritances. Used in order to avoid
     * duplicate methods with choiceSimpleTexture
     */
    var simpleTexture = new CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimpleTexture;
    
    this.bind = function() {
        Super.bind.call(this);

        // Condition for 2D Viewer with dropzone
        var step = $(this.getHTMLElement()).closest('.step_group');
        if (!$(step).hasClass('dmviewer2d-step-dropzone')) {
            this.getHTMLElement().bind('click', $.proxy(simpleTexture.redirectClick, this));
        }
    };

    this.unbind = function() {
        Super.unbind.call(this);
        this.getHTMLElement().unbind('click', $.proxy(simpleTexture.redirectClick, this));
    };

    if (step) {
        this.init(step, parent);  
    }
};


CONFIGURATOR.ELEMENTS.dispatch.registerObject('choice_multiple_texture', CONFIGURATOR.ELEMENTS.CHOICE.ChoiceMultipleTexture);
CONFIGURATOR.ELEMENTS.CHOICE.ChoiceMultipleTexture.prototype = new CONFIGURATOR.ELEMENTS.CHOICE.ChoiceMultiple;
