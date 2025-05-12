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

CONFIGURATOR.ELEMENTS.CHOICE.ChoiceMultiple = function(step, parent){

    var Super = Object.getPrototypeOf(this);

    /**
     * TRUE means checked as default on server side
     * FALSE otherwise
     */
    this.isDefaultOption;

    this.init = function(step, parent) {
        Super.init.call(this, step, parent);
        
        // if state is ACTIVE during init, means element is a
        // default option (selected in backoffice)
        this.isDefaultOption = (this.state === this.STATE.ACTIVE);
    };
    
    this.updateInternal = function(data) {
        Super.updateInternal.call(this, data);
        
        //
        //  if defaultOption and INACTIVE, element has to provide
        //  a 'remove' operation in order to cancel default option from server
        // when leaving "INVISIBLE" state (case of conditionnal appearance)
        if (this.isDefaultOption && 
            this.state === this.STATE.INACTIVE) {
            var op = this.createOperationFromState(this.state);
            this.addOperations(op);
        }
    };

    if (step) {
        this.init(step, parent);  
    }
};


CONFIGURATOR.ELEMENTS.dispatch.registerObject('choice_multiple', CONFIGURATOR.ELEMENTS.CHOICE.ChoiceMultiple);
CONFIGURATOR.ELEMENTS.CHOICE.ChoiceMultiple.prototype = new CONFIGURATOR.ELEMENTS.CHOICE.BaseChoice;
