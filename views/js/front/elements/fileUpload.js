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

CONFIGURATOR.ELEMENTS.FileUpload = function(step, parent) {

    this.getState = function() {
        return this.STATE.ACTIVE;
    };

    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('file_upload', CONFIGURATOR.ELEMENTS.FileUpload);
CONFIGURATOR.ELEMENTS.FileUpload.prototype = new CONFIGURATOR.ELEMENTS.BaseGroupElement;