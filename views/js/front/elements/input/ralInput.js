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
CONFIGURATOR.ELEMENTS.INPUT.RalInput = function (step, parent) {

    var Super = Object.getPrototypeOf(this);
    this.valueInactive = '';

    this.onChangeRal = function (event) {
        var $ral_block = $(event.currentTarget);
        var ref = $ral_block.data('ref');

        var step_id = $(this.targetEvent).data('step');
        var option_id = $(this.targetEvent).data('option');

        $('#configuratorRalModal-'+step_id+'-'+option_id+' .configurator-ral-list-option').removeClass('selected');
        $ral_block.addClass('selected');

        // Close modal
        $('#configuratorRalModal-'+step_id+'-'+option_id).modal('hide');

        // Change value in operation
        this.targetEvent.val(ref);

        this.onInteract();
    };
    
    this.initDOMLinks = function(step, parent) {
        Super.initDOMLinks.call(this, step, parent);
        this.targetEvent = this.getHTMLElement().find('input[data-type=ral_input]');

        var step_id = $(this.targetEvent).data('step');
        var option_id = $(this.targetEvent).data('option');

        // Bind configurator-ral-attribute
        $('#configuratorRalModal-'+step_id+'-'+option_id+' .configurator-ral-list-option').bind('click', $.proxy(this.onChangeRal, this));
    };   
    
    if (step) {
        this.init(step, parent);
    }
    
};

CONFIGURATOR.ELEMENTS.dispatch.registerObject('ral_input', CONFIGURATOR.ELEMENTS.INPUT.RalInput);
CONFIGURATOR.ELEMENTS.INPUT.RalInput.prototype = new CONFIGURATOR.ELEMENTS.INPUT.BaseInput;
