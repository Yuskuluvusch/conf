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

function htmlDecode(value) {
    return $("<textarea/>").html(value).text();
}

function decodeConfigurations() {
    let customizations = $('.order-product-customization td p').each(function (index) {
        let self = $(this);
        self.html(htmlDecode(self.html()));
    });
    let cart_customizations = $('td div div:contains(configurator-detail-step)').each(function (index) {
        let self = $(this);
        self.html(htmlDecode(self.html()));
    });

    let weird_customizations = $('.cellProduct .cellProductName .productName:contains( - Configurateur : <br />)').each(function (index) {
        let self = $(this);
        let configArray = self.text().split(" - Configurateur : <br />");
        self.text(configArray[0]);
        self.parents('.cellProduct').after('<tr class="order-product-customization"><td class="border-top-0"></td><td colspan="9" class="border-top-0 text-muted">'
            +'<p><strong>Configurateur :</strong>'+htmlDecode(configArray[1])+'</p></td></tr>');
    });

    let weird_customizations_en = $('.cellProduct .cellProductName .productName:contains( - Configurator : <br />)').each(function (index) {
        let self = $(this);
        let configArray = self.text().split(" - Configurator : <br />");
        self.text(configArray[0]);
        self.parents('.cellProduct').after('<tr class="order-product-customization"><td class="border-top-0"></td><td colspan="9" class="border-top-0 text-muted">'
            +'<p><strong>Configurator :</strong>'+htmlDecode(configArray[1])+'</p></td></tr>');
    });

    let weird_customizations_bis = $('.cellProduct .cellProductName .productName:contains( - Configuration : <br />)').each(function (index) {
        let self = $(this);
        let configArray = self.text().split(" - Configuration : <br />");
        self.text(configArray[0]);
        self.parents('.cellProduct').after('<tr class="order-product-customization"><td class="border-top-0"></td><td colspan="9" class="border-top-0 text-muted">'
            +'<p><strong>Configuration :</strong>' +htmlDecode(configArray[1])+'</p></td></tr>');
    });

    let customer_weird_customizations = $('.customer-bought-products-card .customer-bought-product .customer-bought-product-name a:contains( - Configurateur : <br />)').each(function (index) {
        let self = $(this);
        let configArray = self.text().split(" - Configurateur : <br />");
        self.text(configArray[0]);
        self.parents('.customer-bought-product').after('<tr class="customer-bought-product"><td></td><td colspan="2">'
            +'<p><strong>Configurateur :</strong>' +htmlDecode(configArray[1])+'</p></td></tr>');
    });

    let customer_weird_customizations_en = $('.customer-bought-products-card .customer-bought-product .customer-bought-product-name a:contains( - Configurator : <br />)').each(function (index) {
        let self = $(this);
        let configArray = self.text().split(" - Configurator : <br />");
        self.text(configArray[0]);
        self.parents('.customer-bought-product').after('<tr class="customer-bought-product"><td></td><td colspan="2">'
            +'<p><strong>Configurator :</strong>' +htmlDecode(configArray[1])+'</p></td></tr>');
    });

    let customer_weird_customizations_bis = $('.customer-bought-products-card .customer-bought-product .customer-bought-product-name a:contains( - Configuration : <br />)').each(function (index) {
        let self = $(this);
        let configArray = self.text().split(" - Configuration : <br />");
        self.text(configArray[0]);
        self.parents('.customer-bought-product').after('<tr class="customer-bought-product"><td></td><td colspan="2">'
            +'<p><strong>Configuration :</strong>' +htmlDecode(configArray[1])+'</p></td></tr>');
    });
}

$(document).ready(function() {
    decodeConfigurations();
});