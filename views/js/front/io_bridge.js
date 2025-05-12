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

(function () {
    var IO_MODULE = CONFIGURATOR.IO;

    //
    // Overriding IO modules in order to translate the parameters on-the-fly
    //

    CONFIGURATOR.IO = function (setup) {

        this.id_configurator_quantity = '#quantity-configurator';
        this.configurator_product_attribute = '[name="configurator_product_attribute"]';

        this.setup = {};

        this.init = function (setup) {
            this.setup = setup || this.setup;
            this.io = new IO_MODULE(setup);

            this.bridge = CONFIGURATOR.bridge();

        };


        this.send = function (operations, done) {
            console.log("Using io_bridge !");
            done = done || this.setup.done;

            var data = {
                ajax: 1,
                submitUpdateOption: 1,
                operations: operations,
                qty: $(this.id_configurator_quantity).val(),
                configurator_product_attribute: $(this.configurator_product_attribute).val() || 0
            };

            this.sendData(data, done);
        };

        this.sendSharedStep = function (operations, done) {
            done = done || this.setup.done;
            var data = {
                ajax: 1,
                submitUpdateOption: 1,
                operations: operations,
                qty: $(this.id_configurator_quantity).val(),
                resetSharedStep: 1,
                configurator_product_attribute: $(this.configurator_product_attribute).val() || 0
            };
            this.sendData(data, done);
        };

        this.sendData = function (data, done) {
            var self = this;
            console.log("Sending: ");
            console.log(data);
            this.io.send(data, function (data) {
                $('.steps-bottom-buttons button').attr('disabled', false);

                var newData;
                if (data && !data.errors) {
                    if (typeof dmbuilder_return !== 'undefined' && data.dmbuilder) {
                        dmbuilder_return = data.dmbuilder;
                    }
                    newData = self.translate(data.detail, data.steps_errors, data.steps_infos, data.steps_info_text, data.tabs_status);

                    newData = self.bridge.translateAnswer(data, newData);
                } else {
                    newData = data;
                }

                console.log("Data once translated");
                console.log(newData);
                done(newData);
            });
        };

        this.translate = function (data, errors, infos, infosText, tabs_status) {
            var substeps = this.bridge.translateParams(data, errors, infos, infosText);
            var newStep = {
                params: {
                    id: 0
                },
                substeps: substeps,
                errors: [],
                infos: [],
                infosText: null,
                tabs_status: tabs_status
            };
            // end tricky translation from old to new version
            return newStep;
        };

        if (setup) {
            this.init(setup);
        }
    };


})();