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
CONFIGURATOR.MODULES = CONFIGURATOR.MODULES || {};
CONFIGURATOR.MODULES.DISPLAY = CONFIGURATOR.MODULES.DISPLAY || {};

/**
 * Base display module to handle the left panel (where images are displayed)
 * @param params    Init parameter, specific to subclasses
 * @param callback  Must be called after the module ended its initialisation
 *                  Usefull when module needs to make async tasks
 */
CONFIGURATOR.MODULES.DISPLAY.BaseDisplay = function(params, callback) {
    
    this.canStartScroll = function() {
        var WinHelper = CONFIGURATOR.WindowHelper;
        return !WinHelper.isMobile() && !this.params.contentOnly;
    };

    this.initScroll = function() {
        var self = this;
        this.scroll = new CONFIGURATOR.ScrollFix($);
        this.scroll.init(self.params.element, {
            marginTop: 35,
            removeOffsets: true,
            limit: function() {
                    return $('.page-product-box').first().offset().top - $(self.params.element).outerHeight(true);
            }
        });

    };

    if (params) {
        this.init(params, callback);
        // cannot add callback into init method as it is called by subclasses
        // here we are certain that only base_display element call 'callback'
        // and not one of its subclasses
        callback();
    }
};

CONFIGURATOR.MODULES.dispatch.registerObject('default_display', CONFIGURATOR.MODULES.DISPLAY.BaseDisplay);
CONFIGURATOR.MODULES.DISPLAY.BaseDisplay.prototype = new CONFIGURATOR.MODULES.BaseModule;