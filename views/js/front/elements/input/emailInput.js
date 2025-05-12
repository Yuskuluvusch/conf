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
CONFIGURATOR.ELEMENTS.INPUT = CONFIGURATOR.ELEMENTS.INPUT || {};

/**
 * Handle email
 * @param {type} step
 * @param {type} parent
 */
CONFIGURATOR.ELEMENTS.INPUT.EmailInput = function (step, parent) {
    this.valueInactive = '';

    var Super = Object.getPrototypeOf(this);

    this.initDOMLinks = function (step, parent) {
        Super.initDOMLinks.call(this, step, parent);
        this.targetEvent = this.getHTMLElement().find('input[type=email]');
    };

    this.validateData = function (inputContent) {
        return this.targetEvent[0].checkValidity();
    };

    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('email_input', CONFIGURATOR.ELEMENTS.INPUT.EmailInput);
CONFIGURATOR.ELEMENTS.INPUT.EmailInput.prototype = new CONFIGURATOR.ELEMENTS.INPUT.BaseInput;
