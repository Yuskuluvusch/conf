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
CONFIGURATOR.ELEMENTS.PRICELIST = CONFIGURATOR.ELEMENTS.PRICELIST || {};

/**
 * Handles price list displayed as table
 * @param {type} step
 * @param {type} parent
 * @returns {undefined}
 */
CONFIGURATOR.ELEMENTS.PRICELIST.PriceListTable = function(step, parent) {

    var Super = Object.getPrototypeOf(this);

    /**
     * Targets are all cells in table
     */
    this.cellQuery = 'table tbody td.table-cell';

    /**
     * Keeps track of the selected cell
     */
    this.selectedCell;

    this.init = function(step, parent) {
        Super.init.call(this, step, parent);
        this.updateInternalState(step.substeps);
    };

    this.initDOMLinks = function(step, parent) {
        Super.initDOMLinks.call(this, step, parent);

        this.targetEvent = this.getHTMLElement().find(this.cellQuery);
    };

    this.clickOnCell = function(event) {
        var target = $(event.target);

        // clicked
        if (target.html().trim() === '') {
            return;
        }

        var oldSelected = this.selectedCell;
        var nextState;
        var currentState = this.state;
        var ope;
        if (target.hasClass('selected')) {
            nextState = this.STATE.INACTIVE;
            ope = this.createOperation(this.OPERATION_NAME.RESET_STEP);
            ope.step = this.getID();
        } else {
            nextState = this.STATE.ACTIVE;
            ope = this.createOperation(this.OPERATION_NAME.ADD_PRICE_LIST);
            ope.step = this.getID();

            ope.optionDim1 = target.attr('data-option-1');
            ope.optionDim2 = target.attr('data-option-2');

            ope.valueDim1 = target.attr('data-value-1');
            ope.valueDim2 = target.attr('data-value-2');

            this.selectedCell = target;
        }

        if (ope) {
            this.resetOperations();
            this.addOperations(ope);
        }
        this.syncHTMLState(nextState);
        var allowed = Super.notify.call(this, this.getID(), nextState);
        this.state = (allowed) ? nextState : currentState;

        if (!allowed) {
            this.selectedCell = oldSelected;
            this.syncHTMLState();
        }
    };

    this.syncHTMLState = function(state) {
        if (state) {
            this.state = state;
        }

        switch (this.state) {
            case this.STATE.ACTIVE:
                this.targetEvent.removeClass('selected');
                this.selectedCell.addClass('selected');
                break;
            case this.STATE.INACTIVE:
                this.targetEvent.removeClass('selected');
                break;
        }
        
    };

    this.updateInternalState = function(substeps) {
        var value1 = substeps[0].params.value;
        var value2 = substeps[1].params.value;

        this.selectedCell = this.targetEvent.filter('[data-value-1="'+ value1 +'"]');
        this.selectedCell = this.selectedCell.filter('[data-value-2="'+ value2 +'"]');
        if (this.selectedCell.length) {
            this.state = this.STATE.ACTIVE;
        } else {
            this.state = this.STATE.INACTIVE;
        }

        this.syncHTMLState();
    };

    this.mergeAndUpdate = function() {
        // do nothing in order to avoid console.log because
        // we cannot init children
    };

    this.update = function(data) {
        this.step = data;
        this.show();
        this.showErrors();
        this.updateInternalState(data.substeps);
    };

    this.bind = function() {
        this.targetEvent.bind('click', $.proxy(this.clickOnCell, this));
    };

    this.unbind = function() {
        this.targetEvent.unbind('click', $.proxy(this.clickOnCell, this));
    };

   if (step) {
        this.init(step, parent);
    }
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('pricelist_table', CONFIGURATOR.ELEMENTS.PRICELIST.PriceListTable);
CONFIGURATOR.ELEMENTS.PRICELIST.PriceListTable.prototype = new CONFIGURATOR.ELEMENTS.PRICELIST.BasePricelist;
