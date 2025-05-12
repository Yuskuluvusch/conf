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
 * Handle textarea
 * @param {type} step
 * @param {type} parent
 */
CONFIGURATOR.ELEMENTS.INPUT.TextAreaInput = function (step, parent) {

    var Super = Object.getPrototypeOf(this);

    // empty input means inactive
    this.valueInactive = '';

    this.selectorLabelMinValue = ".label_min";
    this.selectorLabelMaxValue = ".label_max";
    this.selectorMinValue = ".option_min_value";
    this.selectorMaxValue = ".option_max_value";
    this.selectorOptionInput = ".option_input";

    this.initDOMLinks = function (step, parent) {
        Super.initDOMLinks.call(this, step, parent);
        this.targetEvent = this.getHTMLElement().find('textarea');
    };

    this.validateData = function(content) {
        if (content === this.valueInactive &&
            this.targetEvent[0].validity) {
            // might be a filter from browser, check if valid
            return this.targetEvent.is(':valid');
        }
        // WARNING: isNaN('') -> false

        var valid = true;
        var min = this.step.params.min;
        var max = this.step.params.max;

        if (this.parent.getHTMLElement().hasClass('no-space-textarea')) {
            var c = content.replace(/\s/g,'').length;
        } else {
            var c = content.length;
        }

        if (min !== '' && !isNaN(min)) {
            valid = valid && min <= c;
        }

        if (max !== '' && !isNaN(max) && max !==0) {
            valid = valid && c <= max;
        }

        return valid;
    };

    this.getBlockMinMaxTarget = function () {
        var self = this;

        return self.targetEvent.parents(self.selectorOptionInput);
    };

    /**
     * Hide min and max value
     */
    this.hideAllMinMax = function () {
        var self = this;

        self.getBlockMinMaxTarget().find(self.selectorLabelMinValue).hide();
        self.getBlockMinMaxTarget().find(self.selectorLabelMaxValue).hide();
    };

    /**
     * Show min and max value
     */
    this.showMinMax = function () {
        var self = this;

        // Change text of min/max
        self.getBlockMinMaxTarget().find(self.selectorMaxValue).text(self.step.params.max);
        self.getBlockMinMaxTarget().find(self.selectorMinValue).text(self.step.params.min);

        // Active different template depending of case
        if (self.step.params.min > 0) {
            self.getBlockMinMaxTarget().find(self.selectorLabelMinValue).show();
        }
        if (this.step.params.max > 0) {
            self.getBlockMinMaxTarget().find(self.selectorLabelMaxValue).show();
        }
        if (!self.validateData(self.targetEvent.val())) {
            self.hasError = true;
            self.syncHTMLState();
        }
    };

    /**
     * Update min and max
     */
    this.updateMinMax = function(){
        var self = this;

        self.hideAllMinMax();

        if (self.step.params.min !== '' && !isNaN(self.step.params.min)) {
            self.targetEvent.prop("data-min", self.step.params.min);
            self.targetEvent.prop("minlength", self.step.params.min);
        }

        if (self.step.params.max !== '' && !isNaN(self.step.params.max) && self.step.params.max !==0) {
            self.targetEvent.prop("data-max", self.step.params.max);
            self.targetEvent.prop("maxlength", self.step.params.max);
        }

        self.showMinMax();
    };

    this.update = function(data){
        var self = this;

        self.updateMinMax();

        Super.update.call(self, data);
    };

    this.onKeyup = function(event) {
        if (this.parent.getHTMLElement().hasClass('no-space-textarea')) {
            var c = this.targetEvent.val().replace(/\s/g,'').length;
        } else {
            var c = this.targetEvent.val().length;
        }

        this.targetEvent.closest('.option_group').find('.option_current_value').text(
            c
        );
    };

    this.bind = function() {
        Super.bind.call(this);

        this.targetEvent.bind('keyup', $.proxy(this.onKeyup, this));

        //On unbind la verification de la touche ENTER
        this.targetEvent.unbind('keypress', $.proxy(this.onKeypress, this));

        // FIX: actualisation des valeurs MIN/MAX à la création de l'étape
        // Il y a eu des soucis de rafraichissement des formules dans des étapes avec des conditions
        this.showMinMax();
    };

    this.unbind = function() {
        Super.unbind.call(this);

        this.targetEvent.unbind('keyup', $.proxy(this.onKeyup, this));
    };

    if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('textarea_input', CONFIGURATOR.ELEMENTS.INPUT.TextAreaInput);
CONFIGURATOR.ELEMENTS.INPUT.TextAreaInput.prototype = new CONFIGURATOR.ELEMENTS.INPUT.BaseInput;
