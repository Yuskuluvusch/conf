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
CONFIGURATOR.ELEMENTS.CHOICES = CONFIGURATOR.ELEMENTS.CHOICES || {};

CONFIGURATOR.ELEMENTS.CHOICES.BaseChoices = function(step, parent) {

    var Super = Object.getPrototypeOf(this);
    
    this.init = function(step, parent){
        Super.init.call(this, step, parent);
        this.updateInternalState();
    };
    
    
    /**
     * Called right after children's update in order to set parent's state
     * depending on children. Indeed, for checkboxes and radio button, we have
     * to list active elements
     */
    this.updateInternalState = function() {
        // override by subclasses
    };
    
    this.update = function(data) {
        Super.update.call(this, data);
    
        // update state after children's one
        this.updateInternalState();
    };
    
    
    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.CHOICES.BaseChoices.prototype = new CONFIGURATOR.ELEMENTS.BaseGroupElement;
