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
CONFIGURATOR.ELEMENTS.QUANTITY = CONFIGURATOR.ELEMENTS.QUANTITY || {};
CONFIGURATOR.ELEMENTS.QUANTITY.CHOICE = CONFIGURATOR.ELEMENTS.QUANTITY.CHOICE || {};

/**
 * Assuming that the first substep is always the input radio/checkbox and
 * that the second one is the quantity
 * @param {type} step
 * @param {type} parent
 * @returns {undefined}
 */
CONFIGURATOR.ELEMENTS.QUANTITY.CHOICE.BaseChoiceQuantity = function(step, parent) {
        
    var Super = Object.getPrototypeOf(this);
    
    this.updateStateFromHtml = function() {
        // locating radio/checkbox element
        var select= this.substeps[0];
        var qty = this.substeps[1];
        
        select.updateStateFromHtml();
        if (select.getState() === this.STATE.INACTIVE) {
            qty.setValue(false);
        }
    };
    
    this.notify = function(id, state) {
        if (this.substeps[1].HTMLElement.hasClass('option_block')) {
            var move = this.substeps[1];
            this.substeps[1] = this.substeps[0];
            this.substeps[0] = move;
        }

        var select = this.substeps[0];
        var qty = this.substeps[1];
        
        var qtyOp = qty.getOperations();
        // in case the operation is not allowed by parent
        var beforeQty = qtyOp && qtyOp[0] && qtyOp[0].value || false;
        
        // when clicking on radio/checkbox, updates input
        // in order to provide immediate feedback
        if (select.getID() === id) {
            if (state === this.STATE.ACTIVE) {
                qty.setValue('1');
            } else {
                qty.setValue(false);
            }
        }
        select.syncHTMLState(state);
        
        var allowed = this.parent.notify(id, state);
        
        if (!allowed) {
            qty.setValue(beforeQty);
            var before = (state === this.STATE.ACTIVE)? this.STATE.INACTIVE : this.STATE.ACTIVE;
            select.syncHTMLState(before);
        }

        return allowed;
    };
    
    /**
     * Returns operation from input element
     * @return {array} operations
     */
    this.getOperations = function() {
        if (this.substeps[1].HTMLElement.hasClass('option_block')) {
            var move = this.substeps[1];
            this.substeps[1] = this.substeps[0];
            this.substeps[0] = move;
        }

        var op = this.substeps[1].getOperations();
        if (op.length > 0) {
            // overrides element to match the one from option
            op[0].step = this.step.params.action_step;
            op[0].option = this.step.params.action_option;
            
            // we need to redirect information from value to option_qty
            // because it is not the same process on server side
            //op[0].option_qty = op[0].value;

            // UPDATE: we update the quantity in real time with the targetEvent
            var value = parseInt(this.substeps[1].targetEvent.val());
            op[0].option_qty = value;
            op[0].action = (value > 0) ? "add" : "remove";

            delete op[0].value;
        } else {
            // force update quantity for multiple update
            var value = parseInt(this.substeps[1].targetEvent.val());
            op = [{
                action: (value > 0) ? "add" : "remove",
                dimension: 1,
                option: this.step.params.action_option,
                option_qty: value,
                step: this.step.params.action_step
            }];
        }

        // operation corresponds to the one from input number !
        return op;
    };
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('choice_quantity', CONFIGURATOR.ELEMENTS.QUANTITY.CHOICE.BaseChoiceQuantity);
CONFIGURATOR.ELEMENTS.QUANTITY.CHOICE.BaseChoiceQuantity.prototype = new CONFIGURATOR.ELEMENTS.QUANTITY.BaseQuantity;
