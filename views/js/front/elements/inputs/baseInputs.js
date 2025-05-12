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
CONFIGURATOR.ELEMENTS.INPUTS = CONFIGURATOR.ELEMENTS.INPUTS || {};

CONFIGURATOR.ELEMENTS.INPUTS.BaseInputs = function(step, parent) {
    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('group_inputs', CONFIGURATOR.ELEMENTS.INPUTS.BaseInputs);
CONFIGURATOR.ELEMENTS.INPUTS.BaseInputs.prototype = new CONFIGURATOR.ELEMENTS.BaseGroupElement;
