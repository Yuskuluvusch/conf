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

CONFIGURATOR.IO = function(setup) {
    
    this.setup = {};

    this.errorDispatch = CONFIGURATOR.ERRORS.dispatch;

    this.init = function(setup) {
        this.setup = setup || this.setup;
    };
    
    /**
     * parseJSON with a backup plan in case of faillure (same method as in
     * UPack project)
     * @param {type} json_string
     * @returns {Boolean|Object} False if couldn't parse, parsed object otherwise
     */
    this.parseJSON = function(json_string) {
        try {
          var json_parsed = JSON.parse(json_string);
        } catch (e) {
            console.log("Unable to parse content: ");
            return false;
        }
        return json_parsed;
    };
    
    /**
     * Wrap around to send data to the server
     * @param {Object|Array} data   Data to send
     * @param {function} done       Callback method. When provided, overrides
     *                              callback provided at init time
     * @returns {Object}
     */
    this.send = function(data, done) {
        return new Promise(resolve => {
            done = done || this.setup.done;

            var self = this;

            $.ajax({
                'type': 'POST',
                'url': this.setup.url,
                'data': data,
                'success': function (data) {
                    data = self.parseJSON(data);
                    if (!data) {
                        data = self.createGeneralError();
                    }
                    done(data);
                    self.refreshCart();
                    resolve();
                }
            }).fail(function () {
                var data = self.createGeneralError();
                done(data);
                resolve();
            });
        });
    };

    this.refreshCart = function () {
        if(typeof ajaxCart !== 'undefined') { // 1.6
            ajaxCart.refresh();
        } else if (typeof prestashop === 'object' && typeof prestashop.emit !== 'undefined') {  // 1.7
            prestashop.emit('updatedCart');
        }
    };

    /**
     * Creates an empty reponse with errors filled with 'GENERAL' error
     * @returns a data response with errors field filled
     */
    this.createGeneralError = function() {
        var data = {};
        data.errors = [];
        data.errors.push('GENERAL');
        return data;
    };
    
    if (setup) {
        this.init(setup);
    }
};