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

CONFIGURATOR.ELEMENTS.CHOICE.BaseChoice = function(step, parent) {
    
    var Super = Object.getPrototypeOf(this);
    
    /**
     * DOM Element inside HTMLElement to which we bind 'onclick' listener
     */
    this.targetEvent;
    
    /**
     * DOM Element inside HTMLElement where an hypothetic price is displayed
     */
    this.HTMLPriceLabel;
	this.HTMLReducPriceLabel;
    
    this.init = function(step, parent) {
        
        this.initDOMLinks(step, parent);
        
        Super.init.call(this, step, parent);
        
        this.updateInternal(step);
        
    };
    
    //
    // TODO
    // For now, looking for an ID attribute
    // Later we will have to handle steps in steps in steps
    // so we should always look for a specific element inside the parent
    //
    this.initDOMLinks = function(step, parent) {
        Super.initDOMLinks.call(this, step, parent);
        
        // seems that JQuery uniform is messing with some home made trigger, so we have to be
        // specifically listening to the input and not the all line (result as a double clic)
        this.targetEvent = this.getHTMLElement().find('input[type=radio], input[type=checkbox]');

        this.HTMLPriceLabel = this.getHTMLElement().find('.label.label-default');  
		this.HTMLReducPriceLabel = this.getHTMLElement().find('.label.label-danger.reduc');  
    };    
    
    this.updateInternal = function(data) {
        this.step = data;
        
        this.resetOperations();
        // selected field from params defines the Element's initial state
        var initState = this.STATE.INACTIVE;
        if (this.step.params.selected) {
            initState = this.STATE.ACTIVE;
            // When the initial state is 'selected', we have to prepare the
            // corresponding operation in order to be able to give this option back
            // at the next getOperations() procedure
            var op = this.createOperationFromState(initState);
            this.addOperations(op); 
        }
        this.syncHTMLState(initState);
        
        this.getHTMLPriceLabel().html(data.params.display_amount);
		this.getHTMLReducPriceLabel().html(data.params.display_reduc);
    };
    
    /**
     * Update the HTML state of the current element through this.targetEvent.
     * Call JQuery's uniform plugin in order to update its display. If a state
     * is provided, set it as the new state before update. Only work for
     * INACTIVE and ACTIVE state
     * 
     * @param {type} newState Coming from this.STATE. When provided, is set as 
     *                          the new state
     */
    this.syncHTMLState = function(newState) {
        if (newState) {
            this.state = newState;
        }
        
        var htmlState;
        
        switch (this.state) {
            case this.STATE.INACTIVE:
                htmlState = false;
                this.getHTMLElement().removeClass('selected');
                break;
            case this.STATE.ACTIVE:
                htmlState = true;
                this.getHTMLElement().addClass('selected');
                break;
            default:
                console.log("Do not know how to update HTML for state: " + this.state);
                htmlState = false;
        }
        
        
        this.targetEvent.prop('checked', htmlState);
        // update CSS through uniform
        $.uniform.update(this.targetEvent);
    };
        
    /**
     * On change action binded to HTMLElement during bind/unbind
     * 'this' MUST be binded to the current object (using $.proxy for example)
     */
    this.onChange = function() {
        var currentState = this.state;
        var nextState = (this.state === this.STATE.ACTIVE) ? this.STATE.INACTIVE : this.STATE.ACTIVE;
        
        
        var oldOperations = this.operations; 
        var op = this.createOperationFromState(nextState);
        if (op) {
            this.resetOperations();
            this.addOperations(op);
        }
        
        var allowed = this.parent.notify(this.getID(), nextState);
        
        nextState = allowed ? nextState : currentState;
        this.syncHTMLState(nextState);
        
        // initial state restored if we weren't allowed to update
        if (!allowed) {
            this.operations = oldOperations;
        }
    };
    
    this.bind = function() {
        this.targetEvent.bind('change', $.proxy(this.onChange, this));
    };

    this.unbind = function() {
        this.targetEvent.unbind('change', $.proxy(this.onChange, this));
    };
        
    /**
     * 
     * @return HTML Element where price must be displayed
     */
    this.getHTMLPriceLabel = function() {
        return this.HTMLPriceLabel;
    };
	this.getHTMLReducPriceLabel = function() {
        return this.HTMLReducPriceLabel;
    };
    
    if (step) {
        this.init(step, parent);  
    }
};

CONFIGURATOR.ELEMENTS.CHOICE.BaseChoice.prototype = new CONFIGURATOR.ELEMENTS.BaseSimpleElement;
