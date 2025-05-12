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
CONFIGURATOR.ELEMENTS.INPUT = CONFIGURATOR.ELEMENTS.INPUT || {};

/**
 * Handles input with type='number' and data-type=slider
 * @param {type} step
 * @param {type} parent
 */
CONFIGURATOR.ELEMENTS.INPUT.NumberInputSlider = function(step, parent) {
    
    var Super = Object.getPrototypeOf(this);
    
    // Avoid problem for updateInternal
    this.initDone = false;
    
    this.init = function(step, parent) {
        Super.init.call(this, step, parent);
        this.initDone = true;
        
        var initValue = parseInt(this.step.params.value, this.numberBase);
        
        this.targetEvent.slider({
            value: initValue,
            min: this.targetEvent.data('min'),
            max: this.targetEvent.data('max'),
            step: this.targetEvent.data('slider-step'),
            slide: $.proxy(this.onSlide, this)
        });
        
        this.changeInformationWithValue(initValue);
    };
    
    this.changeInformationWithValue = function (value) {
        $("#slider_information_"+this.targetEvent.prop('id')+" span").text(value);
    };
    
    this.onSlide = function (event, ui) {
        this.changeInformationWithValue(ui.value);
    };
    
    this.onChange = function(event, ui) {
        this.changeInformationWithValue(ui.value);
        
        // Eviter que si le client clique uniquement sur le slide cela fasse partir la requête
        if(parseInt(this.step.params.value, 10) !== parseInt(ui.value, 10)) {
            this.step.params.value = ui.value;
            this.onInteract();
        }
    };
    
    this.onInteract = function() {
        var currentState = this.state;
        
        // Change value in operation
        this.operations[0].value = this.step.params.value; 

        /**
         * Lance l'envoie AJAX ver le controller
         */
        this.parent.notify(this.getID(), this.STATE.ACTIVE);
    };
    
    this.bind = function() {
        Super.bind.call(this);
        this.targetEvent.slider('option','change', $.proxy(this.onChange, this));
    };

    this.unbind = function() {
        Super.unbind.call(this);
        this.targetEvent.slider('option','change', $.proxy(this.onChange, this));
    };
    
    this.initDOMLinks = function(step, parent) {
        Super.initDOMLinks.call(this, step, parent);
        this.targetEvent = this.getHTMLElement().find('div[data-type=slider]');
    };       
    
    this.updateInternal = function(data) {
        Super.updateInternal.call(this, data);
        
        // Assure que si en backoffice une valeur est saisie elle remonte sur le front
        if (data.params.value && this.initDone) {
            this.targetEvent.slider('option', 'value', parseInt(data.params.value, 10));
        }
    };
    
    
    if (step) {
        this.init(step, parent);
    }
    
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('slider_input', CONFIGURATOR.ELEMENTS.INPUT.NumberInputSlider);
CONFIGURATOR.ELEMENTS.INPUT.NumberInputSlider.prototype = new CONFIGURATOR.ELEMENTS.INPUT.BaseInput;
