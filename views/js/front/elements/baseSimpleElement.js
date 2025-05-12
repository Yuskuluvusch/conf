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

/**
 * Abstract class that contains methods used by all simple element
 * Simple element means here that it does not contain any substeps
 * @param {type} step
 * @param {type} parent
 */
CONFIGURATOR.ELEMENTS.BaseSimpleElement = function(step, parent) {

    var Super = Object.getPrototypeOf(this);
    
    /**
     * Links state to an operation
     * @param {type} state
     * @returns {CONFIGURATOR.ELEMENTS.CHOICE.BaseChoice.createOperation.ope}
     */
    this.createOperationFromState = function(state) {
        var op;
        switch (state) {
            case this.STATE.ACTIVE:
                op = this.createOperation(this.OPERATION_NAME.ADD);
                break;
            case this.STATE.INACTIVE:
                op = this.createOperation(this.OPERATION_NAME.REMOVE);
                break;
        }
        
        return op;
    };
    
    this.createOperation = function(operationName) {
        var ope = Super.createOperation.call(this, operationName);
        switch (operationName) {
            case this.OPERATION_NAME.ADD: 
            case this.OPERATION_NAME.REMOVE:
                ope.option = this.getID();
                ope.step = this.parent.getID();
                break;
            default:
                console.log("No operation linked to " + operationName + " for BaseSimpleElement");
                ope = {};
                break;
        }
        
        return ope;
    };
    
    this.update = function(data) {
        Super.update.call(this, data);
        this.updateInternal(data);
    };

    this.updateInternal = function(data) {
        // override by subclasses
    };
    
    if (step) {
        this.init(step, parent);  
    }
};

CONFIGURATOR.ELEMENTS.BaseSimpleElement.prototype = new CONFIGURATOR.ELEMENTS.BaseElement;