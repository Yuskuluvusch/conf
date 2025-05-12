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

CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimple = function(step, parent){
    
    var Super = Object.getPrototypeOf(this);
    
    this.updateStateFromHtml = function() {
        var nextState = (this.targetEvent.prop('checked')) ? this.STATE.ACTIVE : this.STATE.INACTIVE;
        
        // sync operation with current state
        this.resetOperations();
        if (nextState === this.STATE.ACTIVE) {
            var op = this.createOperation(this.OPERATION_NAME.ADD);
            this.addOperations(op);
        }
        this.syncHTMLState(nextState);
    };
    
    /**
     *  As input's state changes, sync before rendering operation
     */
    this.getOperations = function() {
        var nextState = (this.targetEvent.prop('checked')) ? this.STATE.ACTIVE : this.STATE.INACTIVE;
        if (nextState !== this.state && nextState === this.STATE.INACTIVE) {
            // 
            // As the current system requires to have every elements up to date
            // and as radio buttons change their state automatically
            // == clic on second choice deselect first one
            // We need to remove ADD operation if it does not match
            // html state
            //
            if (this.operations[0].action === this.OPERATION_NAME.ADD) {
                return [];
            }
        }
        
        return Super.getOperations.call(this);
    };
    

    /**
     * Allows to catch click on already selected input
     * If state is ACTIVE, deselect and trigger onchange event in order to
     * start normal behavior
     * 'this' MUST be binded to the current object (using $.proxy for example)
     * @param {jQuery.Event} event Click event
     */
    this.onClick = function(event) {
        if (this.state === this.STATE.ACTIVE) {
            // prevent double 'on change' for texture
            // manuel trigger on input causes two onchange when deselecting
            event.preventDefault();

            this.targetEvent.prop('checked', false);
            this.targetEvent.trigger('change');  
        }
    };
    
    this.bind = function() {
        Super.bind.call(this);
        this.targetEvent.bind('click', $.proxy(this.onClick, this));
    };

    this.unbind = function() {
        Super.unbind.call(this);
        this.targetEvent.unbind('click', $.proxy(this.onClick, this));
    };
    
    if (step) {
        this.init(step, parent);  
    }
};


CONFIGURATOR.ELEMENTS.dispatch.registerObject('choice_simple', CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimple);
CONFIGURATOR.ELEMENTS.CHOICE.ChoiceSimple.prototype = new CONFIGURATOR.ELEMENTS.CHOICE.BaseChoice;
