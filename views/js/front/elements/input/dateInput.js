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
 * Handles input with type='number' and data-type=date
 * @param {type} step
 * @param {type} parent
 */

CONFIGURATOR.ELEMENTS.INPUT.dateInput = function(step, parent) {
    
    this.valueInactive = '';
    var Super = Object.getPrototypeOf(this);
    var format = $("input[data-type=datePicker]").attr("data-format").toLowerCase();
       
    this.initDOMLinks = function(step, parent) {
        Super.initDOMLinks.call(this, step, parent);
        this.targetEvent = this.getHTMLElement().find('input[data-type=datePicker]');
    };
    
    this.validateData = function (inputContent) {
        return this.targetEvent[0].checkValidity();
    };

    if (step) {
        this.init(step, parent);
    }

  $( function() {
    $( "input[data-type=datePicker]" ).datepicker({
       dateFormat : format,
       onSelect : function() {
        $(this).blur();
       }
      });
  } );
  
};
CONFIGURATOR.ELEMENTS.dispatch.registerObject('date_input', CONFIGURATOR.ELEMENTS.INPUT.dateInput);
CONFIGURATOR.ELEMENTS.INPUT.dateInput.prototype = new CONFIGURATOR.ELEMENTS.INPUT.BaseInput;