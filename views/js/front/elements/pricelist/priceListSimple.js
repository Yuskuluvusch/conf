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
CONFIGURATOR.ELEMENTS.PRICELIST = CONFIGURATOR.ELEMENTS.PRICELIST || {};

/**
 * Handles price list with inputs or select as children
 * @param {type} step
 * @param {type} parent
 * @returns {undefined}
 */
CONFIGURATOR.ELEMENTS.PRICELIST.PriceListSimple = function(step, parent) {

    /**
     * In this case, we are assuming that all children are subclass from
     * BaseSimpleElement as it is supposed to determine one dimension each.
     * We can then override the dimension attribute according to the position in
     * the list
     * @returns {Array}
     */
    this.getOperations = function() {
        var op = $.merge([], this.operations);

        this.substeps.forEach(function(substep, id) {
            var ope = substep.getOperations();

            if (ope.length === 1) {
                // dimension are in the same order as the one in children's list
                ope[0].dimension = (substep.step.params.pos + 1) || (id + 1);
            } else if (ope.length > 1) {
                console.log("WARNING: should not happen for a price list !");
            }
            op = $.merge(op, ope);
        });

        return op;
    };

    this.updateState = function() {
        var numberActive = 0;

        // price list considered as active only if all its children are actives
        for (var s in this.substeps) {
            var substep = this.substeps[s];
            if (this.isVisibleAndActive(substep)) {
                numberActive++;
            }
        }

        // comparaison to length in order to take into acount
        // one and two dimension (why not more one day)
        if (numberActive === this.substeps.length) {
            this.state = this.STATE.ACTIVE;
        } else {
            this.state = this.STATE.INACTIVE;
        }
    };


    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('pricelist_simple_input', CONFIGURATOR.ELEMENTS.PRICELIST.PriceListSimple);
CONFIGURATOR.ELEMENTS.dispatch.registerObject('pricelist_simple_select', CONFIGURATOR.ELEMENTS.PRICELIST.PriceListSimple);
CONFIGURATOR.ELEMENTS.PRICELIST.PriceListSimple.prototype = new CONFIGURATOR.ELEMENTS.PRICELIST.BasePricelist;
