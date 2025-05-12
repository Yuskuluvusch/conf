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
CONFIGURATOR.ELEMENTS.QUANTITY.SELECT = CONFIGURATOR.ELEMENTS.QUANTITY.SELECT || {};

/**
 * Handles quantity with a select
 * There is one input for all select options, which means that the value
 * is kept when user changes option and lost when he deselects the select
 * @param {type} step
 * @param {type} parent
 * @returns {undefined}
 */
CONFIGURATOR.ELEMENTS.QUANTITY.SELECT.SelectSimpleQuantity = function(step, parent) {

    var Super = Object.getPrototypeOf(this);

    this.notify = function(id, state) {
        var qty = this.substeps[1];

        // stores visibility in order to restore it later if not allowed
        var qtyVisibility = qty.getVisibleState();
        
        var qtyOp = qty.getOperations();

        // in case the operation is not allowed by parent
        var beforeQty = qtyOp && qtyOp[0] && qtyOp[0].value || false;

        // update
        if (qty.getID() !== id) {
            // id === 0 means reset value
            if (id !== 0) {
                var val = (beforeQty) ? beforeQty : 1;
                qty.setValue(val);
                qty.show();
            } else {
                qty.hide();
            }
        }
        
        var allowed = Super.notify.call(this, id, state);

        if (!allowed) {
            qty.setValue(beforeQty);
            if (qtyVisibility === this.STATE.VISIBLE) {
                qty.show();
            } else {
                qty.hide();
            }
        }

        return allowed;
    };

    this.getOperations = function() {
        var op = $.merge([], this.operations);
        var opeSelect = this.substeps[0].getOperations();

        // retrieves option_qty from input only if its an add operation
        if (opeSelect.length && opeSelect[0].action === this.OPERATION_NAME.ADD) {
            var opeQty = this.substeps[1].getOperations();
            if (opeQty.length) {
                opeSelect[0].option_qty = opeQty[0].value;
            }
        }
        
        op = $.merge(op, opeSelect);

        return op;
    };

    this.updateState = function() {
        Super.updateState.call(this);

        // hide input if select is not active or 'none' option
        var select = this.substeps[0];
        var selected = select.getSelected();
        if (select.getState() === this.STATE.INACTIVE ||
            !selected || selected === "0") {
            this.substeps[1].hide();
        }
    };

    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('select_simple_quantity', CONFIGURATOR.ELEMENTS.QUANTITY.SELECT.SelectSimpleQuantity);
CONFIGURATOR.ELEMENTS.QUANTITY.SELECT.SelectSimpleQuantity.prototype = new CONFIGURATOR.ELEMENTS.QUANTITY.BaseQuantity;
