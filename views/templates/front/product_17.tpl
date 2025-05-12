{*
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
 *}
{extends file='catalog/product.tpl'}

{if $content_only}
    {if $use_custom_left_column}
        {block name='page_content'}
            {$configuratorLeftColumnHtml nofilter}{* HTML comment, no escape necessary *}
        {/block}
    {/if}

    {block name='breadcrumb'}
        {* remove block *}
    {/block}
    {block name='product_description_short'}
        {* remove block *}
    {/block}

    {block name='page_header_container'}
        {* remove block *}
    {/block}
    {block name='product_prices'}
        {* remove block *}
    {/block}
    {block name='product_customization'}
        {* remove block *}
    {/block}
    
    {block name='header'}
        {* remove block *}
    {/block}
    
    {block name='hook_display_reassurance'}
        {* remove block *}
    {/block}
    
    {block name='product_tabs'}
        {* remove block *}
    {/block}
    
    {block name='product_accessories'}
        {* remove block *}
    {/block}
    
     {block name='product_footer'}
     {* remove block *}
    {/block}
    
    {block name='product_images_modal'}
     {* remove block *}
    {/block}
   
    {block name='page_footer_container'}
       {* remove block *}
    {/block}
    
    {block name='product_buy'}
        {$configuratorHtml nofilter}{* HTML comment, no escape necessary *}
        {if isset($configuratorCartDetail)}
            <script>
                {strip}
                var ERROR_LIST = {$ERROR_LIST|json_encode nofilter};{* JSON comment, no escape necessary *}
                var none = '{l s='None' mod='configurator' js=1}';
                var total_price_i18n = '{l s='Final price:' mod='configurator' js=1}';
                var tax_i18n = '{if $priceDisplay == 1}{l s='tax excl.' mod='configurator' js=1}{else}{l s='tax incl.' mod='configurator' js=1}{/if}';
                var detail = {json_encode($configuratorCartDetail->getDetail(true)) nofilter};{* JSON comment, no escape necessary *}
                var tabs_status = {json_encode($tabs_status) nofilter};{* JSON comment, no escape necessary *}
                var configuratorInfoText = {json_encode($configuratorInfoText) nofilter};
                var image_format = 'large_default';
                var fancybox_image_format='thickbox_default';
                var progress_data = {
                    'start':0,
                    'end':{$configuratorCartDetail->progress},
                    'start_color':"{$PROGRESS_START_COLOR}",
                    'end_color': "{$PROGRESS_END_COLOR}"
                };
                var progressive_display = {$PROGRESSIVE_DISPLAY|intval};
                var tooltip_display = {$TOOLTIP_DISPLAY|intval};
                var action = '{Context::getContext()->link->getProductLink($productObject)|escape:'html':'UTF-8'}';
                var popover_trigger = '{$CONFIGURATOR_POPOVER_TRIGGER|escape:'html':'UTF-8'}';
                var configurator_hide_empty_tabs = {$HIDE_EMPTY_TABS|intval};
                {/strip}
            </script>
        {/if}
        <style>
            #configurator_preview .configurator-add { display: none; }
            #configurator_preview .row > div:first-child { display:none; }
            #configurator_preview .breadcrumb { display:none; }
            .product-description-short { display: none;}
            #footer { display: none;}
            #content{ width: inherit !important; position: inherit !important; bottom: inherit !important;}

        </style>
    {/block}
{else}
    {if $use_custom_left_column}
        {block name='page_content_container'}
            {$configuratorLeftColumnHtml nofilter}{* HTML comment, no escape necessary *}
        {/block}
    {/if}

    {block name='product_description_short'}
        {* remove block *}
    {/block}

    {block name='page_header_container'}
        {* remove block *}
    {/block}
    {block name='product_prices'}
        {* remove block *}
    {/block}
    {block name='product_customization'}
        {* remove block *}
    {/block}

    {block name='product_buy'}
        {block name='product_variants'}
            {if $configurator->use_combination}
                <div id="configurator-product-variants">
                    {include file='catalog/_partials/product-variants.tpl'}
                    <script>
                        const configuratorCurrentUrlParams = '{$configuratorCurrentUrlGetParams nofilter}{* JSON comment, no escape necessary *}';
                        function configuratorDocReady(fn) {
                            // see if DOM is already available
                            if (document.readyState === "complete" || document.readyState === "interactive") {
                                // call on next available tick
                                setTimeout(fn, 1);
                            } else {
                                document.addEventListener("DOMContentLoaded", fn);
                            }
                        }
                        configuratorDocReady(function() {
                            $("#configurator-product-variants").on("change touchspin.on.startspin", "[data-product-attribute]", function (event) {
                                event.preventDefault();
                                event.stopPropagation();

                                $('#add_configurator_to_cart').attr('disabled', true);

                                // Trouver les attributs sélectionnés
                                let group = {};
                                for (const input of $('#configurator-product-variants [data-product-attribute')) {
                                    switch (input.tagName) {
                                        case 'SELECT':
                                            group[$(input).attr('data-product-attribute')] = $(input).val();
                                            break;
                                        case 'INPUT':
                                            switch ($(input).attr('type')) {
                                                case 'radio':
                                                case 'checkbox':
                                                    if ($(input).is(':checked')) {
                                                        group[$(input).attr('data-product-attribute')] = $(input).val();
                                                    }
                                                    break;
                                            }
                                    }
                                }

                                const getdata = {
                                    controller: 'product',
                                    token: '{Tools::getToken(false)}',
                                    id_product: '{$productObject->id}',
                                    group: group,
                                    qty: 1
                                };
                                const postdata = { ajax: 1, action: 'refresh', quantity_wanted: 1 };

                                // Requête ajax
                                $.ajax({
                                    type: 'POST',
                                    url: 'index.php?' + $.param(getdata),
                                    data: postdata,
                                    success: function (data) {
                                        // Met à jour les champs d'attibuts
                                        $("#configurator-product-variants").html(data.product_variants);

                                        // Formate URL
                                        const configuratorCurrentUrlNew = data.product_url.replace('#/', configuratorCurrentUrlParams + '#/');

                                        // Met à jour l'URL du produit
                                        window.history.replaceState(
                                            { id_product_attribute: data.id_product_attribute },
                                            data.product_title,
                                            configuratorCurrentUrlNew
                                        );

                                        $('#form_add_configurator_to_cart').find('[name="configurator_product_attribute"]').val(data.id_product_attribute);

                                        $.ajax({
                                            type: 'POST',
                                            url: '{Context::getContext()->link->getProductLink($productObject)|escape:'html':'UTF-8'}',
                                            data: {
                                                action: 'checkProductAttributeQuantity',
                                                id_product_attribute: data.id_product_attribute
                                            },
                                            success: function (data) {
                                                data = JSON.parse(data);
                                                if (data.available_quantity > 0 || data.$availableOutOfStock) {
                                                    $('#add_configurator_to_cart').attr('disabled', false);
                                                }
                                                Front.notify();
                                            }
                                        });
                                    }
                                });
                            });
                            $($("#configurator-product-variants").find('[data-product-attribute]')[0]).trigger('change');
                        });
                    </script>
                </div>
            {/if}
        {/block}
        {$configuratorHtml nofilter}{* HTML comment, no escape necessary *}
        {if isset($configuratorCartDetail)}
            <script>
                {strip}
                var ERROR_LIST = {$ERROR_LIST|json_encode nofilter}{* JSON comment, no escape necessary *};
                var none = '{l s='None' mod='configurator' js=1}';
                var total_price_i18n = '{l s='Final price:' mod='configurator' js=1}';
                var tax_i18n = '{if $priceDisplay == 1}{l s='tax excl.' mod='configurator' js=1}{else}{l s='tax incl.' mod='configurator' js=1}{/if}';
                var detail = {$configuratorCartDetail->getDetail(true)|json_encode nofilter}{* JSON comment, no escape necessary *};
                var tabs_status = {$tabs_status|json_encode nofilter}{* JSON comment, no escape necessary *};
                var configuratorInfoText = {$configuratorInfoText|json_encode nofilter}{* JSON comment, no escape necessary *};
                var image_format = 'large_default';
                var fancybox_image_format='thickbox_default';
                var progress_data = {
                    'start':0,
                    'end':{$configuratorCartDetail->progress},
                    'start_color':"{$PROGRESS_START_COLOR}",
                    'end_color': "{$PROGRESS_END_COLOR}"
                };
                var progressive_display = {$PROGRESSIVE_DISPLAY|intval};
                var tooltip_display = {$TOOLTIP_DISPLAY|intval};
                var configurator_hide_empty_tabs = {$HIDE_EMPTY_TABS|intval};
                var action = '{Context::getContext()->link->getProductLink($productObject)|escape:'html':'UTF-8'}';
                var popover_trigger = '{$CONFIGURATOR_POPOVER_TRIGGER|escape:'html':'UTF-8'}';
                {/strip}
            </script>
        {/if}
    {/block}
{/if}
