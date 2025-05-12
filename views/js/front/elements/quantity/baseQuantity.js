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

CONFIGURATOR.ELEMENTS.QUANTITY.BaseQuantity = function(step, parent) {
    
    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.QUANTITY.BaseQuantity.prototype = new CONFIGURATOR.ELEMENTS.BaseGroupElement;
