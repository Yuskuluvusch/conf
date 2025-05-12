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

/**
 * Base module
 * Methods that all modules should implemente
 * @param params    Init parameter, specific to subclasses
 * @param callback  Must be called after the module ended its initialisation
 *                  Usefull when module needs to make async tasks
 */
CONFIGURATOR.MODULES.BaseModule = function(params, callback) {
    
    this.init = function(params, callback) {
        this.params = params;
        //this.initScroll();
        //this.startScroll();
    };

    /**
     * Starts scroll if allowed to
     */
    this.startScroll = function() {
        var canStart = this.canStartScroll();
        if (canStart) {
            if (this.scroll) {
                this.scroll.start();
            } else {
                console.log("WARNING: Cannot start scroll as it is not initialized !");
            }
        }
    };

    /**
     * Whether the conditions allows to start the scroll
     * @returns {Boolean}
     */
    this.canStartScroll = function() {
        return false;
    };

    /**
     * Initialized this.scroll field
     * with a scroll object which must have a 'start' method
     * @see startScroll
     * @returns {undefined}
     */
    this.initScroll = function() {
        // override by subclasses
    };


    /**
     * Single method to handle action on modules.
     * This method do not have any arguments on purpose. Indeed, we cannot
     * know how many arguments we will need.
     */
    this.handle = function() {
        console.log("Calling on handle");
    };
    
    
    /**
     * Called before massive update of the main module
     */
    this.reset = function() {
        console.log("Calling on reset");
    };
};
