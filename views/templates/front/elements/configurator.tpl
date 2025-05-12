{*
* 2007-2019 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author DMConcept <support@dmconcept.fr>
*  @copyright 2015 DMConcept
*  @license   http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}

<div id="configurator_block" class="configurator_block">
    <div class="col-xs-12 col-sm-9 col-md-6">
        <h2 class="page-heading">
            {l s='Configure your' mod='configurator'} {$product->name|escape:'html':'UTF-8'}
            <span class="pull-right required"><sup>*</sup>{l s='Required step' mod='configurator'}</span>
        </h2>
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
                            style="width: {math equation='100 / nbTabs' nbTabs=$nbTabsGroup }%"
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
                <div class="panel-group" id="configurator-accordions">
                    {foreach $configuratorStepTab as $tab}
                        <div class="panel panel-default {if $k eq '0'}accordion-opened{/if}">
                            <div class="panel-heading configurator-tab-page"
                                 data-toggle="collapse"
                                 data-target="#accordion_{$tab->id|escape:'htmlall':'UTF-8'}"
                                 aria-expanded="{if $k eq '0'}true{else}false{/if}"
                            >
                                {$tab->name[$id_lang]|escape:'htmlall':'UTF-8'}
                                <i class="icon icon-chevron-down pull-right"></i>
                                <i class="icon icon-chevron-up pull-right"></i>
                            </div>
                            <div id="accordion_{$tab->id|escape:'htmlall':'UTF-8'}" class="panel-collapse collapse {if $k eq '0'}in{/if}" data-parent="#configurator-accordions">
                                <div class="card-body" style="padding: 10px;">
                                    {foreach $configurator->steps as $step}
                                        {if $step->id_configurator_step_tab eq $tab->id}
                                            {assign var='tabClass' value='configurator-tab-'|cat:$tab->id}
                                            <!-- STEP -->
                                            {include file='./configurator_step.tpl' step=$step configuratorCartDetail=$configuratorCartDetail tabClass=$tabClass}
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
                    {include file='./configurator_step.tpl' step=$step configuratorCartDetail=$configuratorCartDetail tabClass=$tabClass}
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
    </div>
    <div id='configurator_preview_clear'></div>
    <div class="col-xs-12 col-sm-12 col-md-3">
        <div id="configurator_preview_container">
            {$previewHtml}{* HTML comment, no escape necessary *}
        </div>
    </div>
</div>

{if $display_modal_added_in_cart}
    {assign var='show_tax' value=Configuration::get('PS_TAX_DISPLAY') == 1 && Configuration::get('PS_TAX')}
    <div id="layer_cart" style="display: block; z-index: 99999;">
        <div class="clearfix">
            <div class="layer_cart_cart col-xs-12 col-md-12">
                <span class="title">
                    <!-- Plural Case [both cases are needed because page may be updated in Javascript] -->
                    <span class="ajax_cart_product_txt_s {if $cart_qties < 2} unvisible{/if}">
                        {l s='There are [1]%d[/1] items in your cart.' mod='configurator' sprintf=[$cart_qties] tags=['<span class="ajax_cart_quantity">']}
                    </span>
                            <!-- Singular Case [both cases are needed because page may be updated in Javascript] -->
                    <span class="ajax_cart_product_txt {if $cart_qties > 1} unvisible{/if}">
                        {l s='There is 1 item in your cart.' mod='configurator'}
                    </span>
                </span>
                <div class="layer_cart_row">
                    <strong class="dark">
                        {l s='Total products' mod='configurator'}
                        {if $use_taxes && $display_tax_label && $show_tax}
                            {if $priceDisplay == 1}
                                {l s='(tax excl.)' mod='configurator'}
                            {else}
                                {l s='(tax incl.)' mod='configurator'}
                            {/if}
                        {/if}
                    </strong>
                    <span class="ajax_block_products_total">
                        {if $cart_qties > 0}
                            {convertPrice price=$cart->getOrderTotal(false, Cart::ONLY_PRODUCTS)}
                        {/if}
                    </span>
                </div>
                <div class="layer_cart_row">
                    <strong class="dark">
                        {l s='Total' mod='configurator'}
                        {if $use_taxes && $display_tax_label && $show_tax}
                            {if $priceDisplay == 1}
                                {l s='(tax excl.)' mod='configurator'}
                            {else}
                                {l s='(tax incl.)' mod='configurator'}
                            {/if}
                        {/if}
                    </strong>
                    <span class="ajax_block_cart_total">
                        {if $cart_qties > 0}
                            {if $priceDisplay == 1}
                                {convertPrice price=$cart->getOrderTotal(false)}
                            {else}
                                {convertPrice price=$cart->getOrderTotal(true)}
                            {/if}
                        {/if}
                    </span>
                </div>
                <div class="button-container">
                    <span id="configurator_modal_continue" class="continue btn btn-default button exclusive-medium" title="{l s='Continue shopping' mod='configurator'}">
                        <span>
                            <i class="icon-chevron-left left"></i>{l s='Continue shopping' mod='configurator'}
                        </span>
                    </span>
                    <a class="btn btn-default button button-medium"	href="{$link->getPageLink("cart", true)|escape:"html":"UTF-8"}" title="{l s='Proceed to checkout' mod='configurator'}" rel="nofollow">
                        <span>
                            {l s='Proceed to checkout' mod='configurator'}<i class="icon-chevron-right right"></i>
                        </span>
                    </a>
                </div>
            </div>
        </div>
        <div class="crossseling"></div>
    </div>
    <div class="layer_cart_overlay" style="width: 100%; height: 100%; display: block; z-index: 99998;"></div>
{/if}

{strip}
{addJsDef configurator_floating_preview=$CONFIGURATOR_FLOATING_PREVIEW|intval}
{/strip}

<script>
    {if $display_modal_added_in_cart}
        setTimeout(function() {
            $("#configurator_modal_continue").on('click', function() {
                $("#layer_cart").remove();
            });
        }, 2000);
    {/if}
</script>