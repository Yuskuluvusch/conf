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

CONFIGURATOR.ELEMENTS.CHOICES.ChoicesSimples = function(step, parent){
    
    var Super = Object.getPrototypeOf(this);
    
    /**
     * Contains current active child's ID
     * Set to undefined when none is active
     */
    this.current;

    this.updateInternalState = function() {
        var updated = false;
        var i = 0;
        this.current = undefined;
        // look for an active child, when found, stop research
        while (!updated && i < this.substeps.length) {
            var substep = this.substeps[i];
            if (this.isVisibleAndActive(substep)) {
                this.current = substep.getID();
                updated = true;
            }
            i++;
        }
                
        if (this.current > 0) {
            this.state = this.STATE.ACTIVE;
        } else {
            this.state = this.STATE.INACTIVE;
        }
        
    };
    
    this.notify = function(id, state) {
        var allowed = Super.notify.call(this, id, state);
      
        // if allowed, means the checked element has changed
        // ask children to update their state
        if (allowed) {
            this.substeps.forEach(function(substep) {
                substep.updateStateFromHtml();
            });
        }
        
        return allowed;
    };
    
    this.validateChildAction = function(id, state) {
        var valid = false;
        
        switch (state) {
            case this.STATE.INACTIVE:
                if (this.step.params.required !== "1") {
                    this.current = undefined;
                    valid = true;
                }
                break;
            case this.STATE.ACTIVE:
                this.current = id;
                valid = true;
                break;
                
            default:
                console.log("validateChildAction choices-simples invalid state");
                break;
        }

        return valid;
    };

    if (step) {
        this.init(step, parent);  
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('choices_simples', CONFIGURATOR.ELEMENTS.CHOICES.ChoicesSimples);
CONFIGURATOR.ELEMENTS.CHOICES.ChoicesSimples.prototype = new CONFIGURATOR.ELEMENTS.CHOICES.BaseChoices;
