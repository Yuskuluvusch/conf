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
 * Handles input with type='number'
 * @param {type} step
 * @param {type} parent
 */
CONFIGURATOR.ELEMENTS.INPUT.NumberQuantityInput = function(step, parent) {
    
    var Super = Object.getPrototypeOf(this);

    this.timeOut;
    this.delayBeforeSend = 500;

    // empty input means inactive
    this.valueInactive = '0';
    
    this.initDOMLinks = function(step, parent) {
        
        this.HTMLElement = parent.getHTMLElement().find('.quantity_wanted');
        this.HTMLElementPlus = this.HTMLElement.find('.configurator-quantity-plus');
        this.HTMLElementMinus = this.HTMLElement.find('.configurator-quantity-minus');

        this.targetEvent = parent.getHTMLElement().find('input.qty');

    };

    this.bind = function() {
        let self = this;
        if (typeof this.HTMLElementPlus !== 'undefined') {
            this.HTMLElementPlus.on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                clearTimeout(self.timeOut);

                var stepQty = parseInt($(this).data('step') || 1);
                var newValue = parseInt((parseInt(self.targetEvent.val()) + stepQty) / stepQty) * stepQty;
                self.targetEvent.val(newValue);
                self.timeOut = setTimeout(function () {
                    Super.onInteract.call(self);
                }, self.delayBeforeSend);
            });
        }
        if (typeof this.HTMLElementMinus !== 'undefined') {
            this.HTMLElementMinus.on('click', function (e) {
                e.preventDefault();
                e.stopPropagation();
                clearTimeout(self.timeOut);

                var stepQty = parseInt($(this).data('step') || 1);
                var newValue = parseInt((parseInt(self.targetEvent.val()) - stepQty) / stepQty) * stepQty;
                if(newValue < 0) {
                    newValue = 0;
                }

                self.targetEvent.val(newValue);
                self.timeOut = setTimeout(function () {
                    Super.onInteract.call(self);
                }, self.delayBeforeSend);
            });
        }

        Super.bind.call(this);
    };

    this.unbind = function() {
        Super.unbind.call(this);
        if (typeof this.HTMLElementPlus !== 'undefined') {
            this.HTMLElementPlus.unbind('click');
        }
        if (typeof this.HTMLElementMinus !== 'undefined') {
            this.HTMLElementMinus.unbind('click');
        }
    };
    
    if (step) {
        this.init(step, parent);
    }
    
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('number_quantity_input', CONFIGURATOR.ELEMENTS.INPUT.NumberQuantityInput);
CONFIGURATOR.ELEMENTS.INPUT.NumberQuantityInput.prototype = new CONFIGURATOR.ELEMENTS.INPUT.NumberInput;
