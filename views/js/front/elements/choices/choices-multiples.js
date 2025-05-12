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

CONFIGURATOR.ELEMENTS.CHOICES.ChoicesMultiples = function(step, parent){
    
    /**
     * Contains current active element's ID
     * if ID is in array => ACTIVE
     * else => INACTIVE
     */
    this.currents = [];
    
    this.updateInternalState = function() {
        var self = this;
        this.currents = [];
        this.substeps.forEach(function(substep) {
            if (self.isVisibleAndActive(substep)) {
                self.addToCurrents(substep.getID());
            }
        });
        
        if (this.currents.length > 0) {
            this.state = this.STATE.ACTIVE;
        } else {
            this.state = this.STATE.INACTIVE;
        }
    };
    
    /**
     * Add the provided id to the list of active elements
     * @param {type} id     ID to add
     */
    this.addToCurrents = function(id) {
        this.currents.push(id);
    };
    
    /**
     * Removes the provided id from the list if it is inside
     * @param {type} id     ID to remove
     */
    this.removeFromCurrents = function(id) {
        var index = this.currents.indexOf(id);
        if (index > -1) {
            this.currents.splice(index, 1);
        }
    };
    
    this.validateChildAction = function(id, state) {
        var valid = false;

        switch (state) {
            case this.STATE.INACTIVE:
                // Old system: can't remove last selected option when step is required
                /*if (this.step.params.required === "1") {
                    // remove only if at least there are two elements left
                    if (this.currents.length > 1) {
                        this.removeFromCurrents(id);
                        valid = true;
                    }
                } else {
                    this.removeFromCurrents(id);
                    valid = true;
                }*/

                // New system: can remove last selected option in all case
                this.removeFromCurrents(id);
                valid = true;
                break;
            case this.STATE.ACTIVE:
                this.addToCurrents(id);
                valid = true;
                break;
                
            default:
                console.log("validateChildAction choices-multiples invalid state");
                break;
        }

        return valid;
    };
    
    
    if (step) {
        this.init(step, parent);  
    }
};


CONFIGURATOR.ELEMENTS.dispatch.registerObject('choices_multiples', CONFIGURATOR.ELEMENTS.CHOICES.ChoicesMultiples);
CONFIGURATOR.ELEMENTS.CHOICES.ChoicesMultiples.prototype = new CONFIGURATOR.ELEMENTS.CHOICES.BaseChoices;
