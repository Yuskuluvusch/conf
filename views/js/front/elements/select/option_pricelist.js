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
CONFIGURATOR.ELEMENTS.SELECT = CONFIGURATOR.ELEMENTS.SELECT || {};

/**
 * The only difference with the basic option element is that we need
 * a value attribute in operation. With the current server side version,
 * if we add a 'value' attribute to normal 'select' element it is considered
 * as an input...
 * @param {type} step
 * @param {type} parent
 * @returns {undefined}
 */
CONFIGURATOR.ELEMENTS.SELECT.OptionPriceList = function(step, parent) {
 
    var Super = Object.getPrototypeOf(this);
    
    this.createOperationFromState = function(state) {
        var op = Super.createOperationFromState.call(this, state);
        if (op) {
            op.value = this.step.params.name;
        }

        return op;
    };
    
    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('select_option_pricelist', CONFIGURATOR.ELEMENTS.SELECT.OptionPriceList);
CONFIGURATOR.ELEMENTS.SELECT.OptionPriceList.prototype = new CONFIGURATOR.ELEMENTS.SELECT.Option;
