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

<!-- CONFIGURATOR -->
<div id="configurator_block" class="configurator_block tabs">
    {*<div class="">*}
        <h1 class="h1" itemprop="name">
            {*l s='Configure your' mod='configurator'*} {$productObject->name|escape:'html':'UTF-8'}
            <span class="pull-right required"><sup>*</sup>{l s='Required step' mod='configurator'}</span>
        </h1>
        {block name='product_description_short'}
            <div id="product-description-short-{$productObject->id}" itemprop="description">
                {$productObject->description_short nofilter}{* HTML comment, no escape necessary *}
            </div>
        {/block}
    {*</div>*}
    {*<div class="col-xs-12 col-sm-12 col-md-12">*}
        {if $configurator->tab_type === 'tab'}
            <div id="configurator-tabs">
                {assign var='k' value='0'}
                <ul>
                    {foreach $configuratorStepTab as $tab}
                        <li href="javascript:void(0);"
                            id="tab_{$tab->id|escape:'htmlall':'UTF-8'}"
                            class="configurator-tab-page"
                            {if $k eq '0'}data-selected="true"{else}data-selected="false"{/if}
                            data-block="configurator-tab-{$tab->id|escape:'htmlall':'UTF-8'}"
                            style="width: {math equation='95 / nbTabs' nbTabs=$nbTabsGroup }%;"
                            title="{$tab->name[$id_lang]|escape:'htmlall':'UTF-8'}"
                        >
                            {$tab->name[$id_lang]|escape:'htmlall':'UTF-8'}
                        </li>
                       {assign var='k' value=$k+1}
                    {/foreach}
                </ul>
            </div>
        {/if}
        <div class="step_list">
            {assign var='tabClass' value=''}
            {if $configurator->tab_type === 'accordion'}
                {assign var='k' value='0'}
                <div class="accordion" id="configurator-accordions">
                    {foreach $configuratorStepTab as $tab}
                        <div class="card configurator-card {if $k eq '0'}accordion-opened{/if}">
                            <div class="card-header configurator-tab-page"
                                 data-toggle="collapse"
                                 data-target="#accordion_{$tab->id|escape:'htmlall':'UTF-8'}"
                                 aria-expanded="{if $k eq '0'}true{else}false{/if}"
                            >
                                {$tab->name[$id_lang]|escape:'htmlall':'UTF-8'}
                                <i class="material-icons">navigate_next</i>
                            </div>
                            <div id="accordion_{$tab->id|escape:'htmlall':'UTF-8'}" class="panel-collapse collapse {if $k eq '0'}in{/if}" data-parent="#configurator-accordions">
                                <div class="card-body">
                                    {foreach $configurator->steps as $step}
                                        {if $step->id_configurator_step_tab eq $tab->id}
                                            {assign var='tabClass' value='configurator-tab-'|cat:$tab->id}
                                            <!-- STEP -->
                                            {include file='./configurator_step_17.tpl' step=$step configuratorCartDetail=$configuratorCartDetail tabClass=$tabClass}
                                            <!-- END STEP -->
                                        {/if}
                                    {/foreach}

                                    <!-- TABS ACTIONS -->
                                    {if $nbTabsGroup > 1}
                                        <div class="configurator-accordions-actions text-center">
                                            {if !($k eq '0')}
                                                <a class="btn btn-default btn-lg accordion-action-previous">
                                                    <i class="icon icon-chevron-left"></i>
                                                    {l s='Previous' mod='configurator'}
                                                </a>
                                            {/if}
                                            {if ($k + 1) < $nbTabsGroup}
                                                <a class="btn btn-primary btn-lg accordion-action-next">
                                                    {l s='Next' mod='configurator'}
                                                    <i class="icon icon-chevron-right"></i>
                                                </a>
                                            {/if}
                                            {if ($k + 1) >= $nbTabsGroup}
                                                <a class="btn btn-success btn-lg accordion-action-add-to-cart">
                                                    {l s='Add to cart' mod='configurator'}
                                                    <i class="icon icon-shopping-cart"></i>
                                                </a>
                                            {/if}
                                        </div>
                                    {/if}

                                </div>
                            </div>
                        </div>
                        {assign var='k' value=$k+1}
                    {/foreach}
                </div>
            {else}
                {foreach $configurator->steps as $step}
                    {foreach $configuratorStepTab as $tab}
                        {if $step->id_configurator_step_tab eq $tab->id}
                            {assign var='tabClass' value='configurator-tab-'|cat:$tab->id}
                        {/if}
                    {/foreach}
                    <!-- STEP -->
                    {include file='./configurator_step_17.tpl' step=$step configuratorCartDetail=$configuratorCartDetail tabClass=$tabClass}
                    <!-- END STEP -->
                {/foreach}

                <!-- TABS ACTIONS -->
                {if $nbTabsGroup > 1}
                    <div class="configurator-tabs-actions text-center">
                        <a id="tab-action-previous" class="btn btn-default btn-lg" style="display:none;">
                        <span><i class="icon icon-chevron-left"></i>
                            {l s='Previous' mod='configurator'}</span>
                        </a>
                        <a id="tab-action-next" class="btn btn-primary btn-lg">
                            {l s='Next' mod='configurator'}
                            <i class="icon icon-chevron-right"></i>
                        </a>
                        <a id="tab-action-add-to-cart" class="btn btn-success btn-lg" style="display:none;">
                            {l s='Add to cart' mod='configurator'}
                            <i class="icon icon-shopping-cart"></i>
                        </a>
                    </div>
                {/if}
            {/if}
        </div>
    {*</div>*}
    <div id='configurator_preview_clear'></div>
    {*<div class="col-xs-12 col-sm-12 col-md-12">*}
        <div id="configurator_preview_container">
            {$previewHtml nofilter}{* HTML comment, no escape necessary *}
        </div>
    {*</div>
    <div class="clearfix"></div>*}
</div>
<!-- END CONFIGURATOR -->

{if $display_modal_added_in_cart}
    <button
            id="configurator_added_in_cart_btn"
            type="button"
            data-toggle="modal"
            data-target="#blockcart-modal"
            style="display: none;"
    ></button>
    <div id="blockcart-modal" class="modal fade" tabindex="-1">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                    <h4 class="modal-title h6 text-sm-center"><i class="material-icons rtl-no-flip">&#xE876;</i>{l s='Product successfully added to your shopping cart' d='Shop.Theme.Checkout'}</h4>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-5 divide-right">
                            <div class="row">
                                <div class="col-md-6">
                                    <img class="product-image" src="{$product.cover.medium.url}" alt="{$product.cover.legend}" title="{$product.cover.legend}" itemprop="image">
                                </div>
                                <div class="col-md-6">
                                    <h6 class="h6 product-name">{$product.name}</h6>
                                    <p>{Tools::displayPrice($old_cart_detail->getPriceInCart($old_cart_detail->id_cart))}</p>
                                    {hook h='displayProductPriceBlock' product=$product type="unit_price"}
                                    {if isset($old_cart_detail)}
                                        {$old_cart_detail->getDetailFormated() nofilter}{* HTML content, no escape necessary *}
                                    {/if}
                                    {assign var="customization_quantity" value=Context::getContext()->cart->getProductQuantity($productObject->id, 0, $old_cart_detail->id_customization)}
                                    <p><strong>{l s='Quantity:' d='Shop.Theme.Checkout'}</strong>&nbsp;{$customization_quantity['quantity']}</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-7">
                            <div class="cart-content">
                                {if $cart.products_count > 1}
                                    <p class="cart-products-count">{l s='There are %products_count% items in your cart.' sprintf=['%products_count%' => $cart.products_count] d='Shop.Theme.Checkout'}</p>
                                {else}
                                    <p class="cart-products-count">{l s='There is %product_count% item in your cart.' sprintf=['%product_count%' =>$cart.products_count] d='Shop.Theme.Checkout'}</p>
                                {/if}
                                <p><strong>{l s='Total products:' d='Shop.Theme.Checkout'}</strong>&nbsp;{$cart.subtotals.products.value}</p>
                                <p><strong>{l s='Total shipping:' d='Shop.Theme.Checkout'}</strong>&nbsp;{$cart.subtotals.shipping.value} {hook h='displayCheckoutSubtotalDetails' subtotal=$cart.subtotals.shipping}</p>
                                {if $cart.subtotals.tax}
                                    <p><strong>{$cart.subtotals.tax.label}</strong>&nbsp;{$cart.subtotals.tax.value}</p>
                                {/if}
                                <p><strong>{l s='Total:' d='Shop.Theme.Checkout'}</strong>&nbsp;{$cart.totals.total.value} {$cart.labels.tax_short}</p>
                                <div class="cart-content-btn">
                                    <button type="button" class="btn btn-secondary" data-dismiss="modal">{l s='Continue shopping' d='Shop.Theme.Actions'}</button>
                                    <a href="{Context::getContext()->link->getPageLink('cart')}" class="btn btn-primary">{l s='Proceed to checkout' d='Shop.Theme.Actions'}</a>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
{/if}

<script>
    {strip}
    var configurator_floating_preview = {$CONFIGURATOR_FLOATING_PREVIEW|intval};
    {/strip}
    {if $display_modal_added_in_cart}
        setTimeout(function() {
            $('#configurator_added_in_cart_btn').trigger('click');
        }, 2000);
    {/if}
</script>
