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

{assign var='display_modal' value=(bool)(Configuration::get('CONFIGURATOR_MODAL_CONFIRMATION_CART') || Configuration::get('CONFIGURATOR_MODAL_CONFIRMATION_CART_ACCEPTATION'))}
{if !Tools::getIsset('in_admin_modal')}
<div id="configurator_preview">
    <style>.social-sharing { display: none; } .dd_available { margin-top: 0; }</style>
    {hook h='displayProductButtons' product=$productArray}
<div class="row">
    <div class="col-lg-6">
        
        <div class="page-subheading">{l s='Your configuration:' mod='configurator'}</div>
        
        {* PROGRESS BAR *}
        {if $DISPLAY_PROGRESS}
            <div id="configurator-progress"><strong></strong></div>
        {/if}
        
        {* PREVIEW CONTENT *}
        <ul>
            {foreach $cartDetail as $step}
                {assign var=display value=false}
                {foreach $step.options as $option}
                    {if $option.selected || !empty($option.value)}
                        {assign var=display value=true}
                    {/if}
                {/foreach}
                {if $step.displayed_in_preview && $display}
                    <li>
                        <a href="#step_{$step.id|escape:'htmlall':'UTF-8'}">
                            {if $display_name}
                                <strong>{$step.name|escape:'html':'UTF-8'} : </strong>
                            {/if}
                            {assign var=k value=0}
                            {foreach $step.options as $option}
                                {if !empty($option.value) || is_numeric($option.value)}
                                    <span class="option_value">
                                        {if $k > 0}, {/if}
                                        {$option.name|escape:'html':'UTF-8'} : {$option.value|escape:'html':'UTF-8'}{$step.input_suffix|escape:'htmlall':'UTF-8'}
                                    </span>
                                    {assign var=k value=$k+1}
                                {elseif $option.selected}
                                    <span class="option">
                                        {if $k > 0}, {/if}
                                        {if $step.use_qty}
                                            {$option.qty|intval}x&nbsp;
                                        {/if}
                                        {$option.name|escape:'html':'UTF-8'}
                                    </span>
                                    {if $option.color != ''}
                                        <div class="option_img" style="height: 50px; width: 50px;background-color: {$option.color|escape:'htmlall':'UTF-8'}">
                                        </div>
                                    {/if}
                                    {if isset($option.texture_image)}
                                        <div class="option_img">
                                            <img style="height: 50px; width: 50px;" class="img-responsive" alt="{$option.name|escape:'html':'UTF-8'}" src="{$option.texture_image}" />
                                        </div>
                                    {/if}
                                    {assign var=k value=$k+1}
                                {/if}
                            {/foreach}
                        </a>
                    </li>
                {/if}
            {/foreach}
        </ul>
        
    </div>
    <div id="configurator_preview_buttons" class="col-lg-6">
        {* PREVIEW PRICES *}
        {if $priceDisplay >= 0 && $priceDisplay <= 2}
            {if $productPrice-$productPriceWithoutReduction neq 0}
                <dl class="dl-horizontal" {if (isset($configurator->hide_product_price) and $configurator->hide_product_price eq 1) or !$currentGrpDisplayPrice} style="display: none"{/if}>
                    <dt>
                    {l s='Base price' mod='configurator'}
                    {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                        ({if $priceDisplay == 1}{l s='tax excl.' mod='configurator'}{else}{l s='tax incl.' mod='configurator'}{/if})
                    {/if}
                    </dt>
                    <dd id="old_price">{Tools::displayPrice($productPriceWithoutReduction)}</dd>
                    {if ($displayReduction !== null)}
                        <dt></dt>
                        <dd><span class="badge badge-reduction">{$displayReduction}</span></dd>
                    {else}
                        <dt class="advantage">{l s='After reducing your advantage' mod='configurator'}</dt>
                        <dd class="advantage">{Tools::displayPrice($productPrice-$productPriceWithoutReduction)}</dd>
                    {/if}
                </dl>
                <hr />
            {/if}
            {if $configuratorDisplayPrice === 'both' || $configuratorDisplayPrice === 'tax_excl_only' || ($configuratorDisplayPrice !== 'tax_incl_only' && $priceDisplay === 1)}
                <dl id="dl-final-price-tax-excl" class="dl-horizontal dl-final-price" {if (isset($configurator->hide_product_price) and $configurator->hide_product_price eq 1) or !$currentGrpDisplayPrice} style="display: none"{/if}>
                    <dt>
                        {l s='Final price' mod='configurator'}
                        {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                            ({l s='tax excl.' mod='configurator'})
                        {/if}
                    </dt>
                    <dd id="final_price">{Tools::displayPrice($productPriceTaxExcl)}</dd>
                </dl>
                {if $displayUnitPrice && $configuratorStepQuantities > 0}
                    <dl id="dl-final-price-tax-excl" class="dl-horizontal dl-final-price" {if (isset($configurator->hide_product_price) and $configurator->hide_product_price eq 1) or !$currentGrpDisplayPrice} style="display: none"{/if}>
                        <dt>
                            {l s='Unit price' mod='configurator'}
                            {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                                ({l s='tax excl.' mod='configurator'})
                            {/if}
                        </dt>
                        <dd id="unit_price">{Tools::displayPrice($productPriceTaxExcl / ($configuratorStepQuantities * $qty))}</dd>
                    </dl>
                {/if}
            {/if}
            {if $configuratorDisplayPrice === 'both' || $configuratorDisplayPrice === 'tax_incl_only' || ($configuratorDisplayPrice !== 'tax_excl_only' && $priceDisplay !== 1)}
                <dl id="dl-final-price-tax-incl" class="dl-horizontal dl-final-price" {if (isset($configurator->hide_product_price) and $configurator->hide_product_price eq 1) or !$currentGrpDisplayPrice} style="display: none"{/if}>
                    <dt>
                        {l s='Final price' mod='configurator'}
                        {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                            ({l s='tax incl.' mod='configurator'})
                        {/if}
                    </dt>
                    <dd id="final_price">{Tools::displayPrice($productPriceTaxIncl)}</dd>
                </dl>
                {if $displayUnitPrice && $configuratorStepQuantities > 0}
                    <dl id="dl-final-price-tax-incl" class="dl-horizontal dl-final-price" {if (isset($configurator->hide_product_price) and $configurator->hide_product_price eq 1) or !$currentGrpDisplayPrice} style="display: none"{/if}>
                        <dt>
                            {l s='Unit price' mod='configurator'}
                            {if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                                ({l s='tax incl.' mod='configurator'})
                            {/if}
                        </dt>
                        <dd id="unit_price">{Tools::displayPrice($productPriceTaxIncl / ($configuratorStepQuantities * $qty))}</dd>
                    </dl>
                {/if}
            {/if}
        {/if}
        
        {* PREVIEW CONTENT *}
        {*
        <div class="product-actions">
            {assign var='product' value=$productObject}
            {block name='product_add_to_cart'}
                {include file='catalog/_partials/product-add-to-cart.tpl'}
            {/block}
        </div>
        *}
        <div class="buttons_container">
            <form
                id="form_add_configurator_to_cart"
                action="{if $update_cart}{Context::getContext()->link->getProductLink($productObject)|escape:'html':'UTF-8'}?configurator_update={$id_cart_detail}{else}{Context::getContext()->link->getProductLink($base_product)|escape:'html':'UTF-8'}{/if}"
                method="POST"
            >
                <input type="hidden" name="add" value="1" />
                {if $configurator->use_combination}
                    <input type="hidden" name="configurator_product_attribute" value="{$configuratorProductAttribute}" />
                {/if}
                <!-- QUANTITY -->
                <label id="quantity-configurator-label" for="quantity-configurator" {if $configurator->hide_qty_product eq 1} style="display: none"{/if}>{l s='Quantity :' mod='configurator'}</label>
                <div class="configurator-qty">
                    <div class="form-group">
                        <input id="quantity-configurator" class="form-control" type="number" name="qty" value="{$qty}" min="1" {if $configurator->hide_qty_product eq 1} style="display: none"{/if}  />
                    </div>
                </div>
                <!-- ADD TO CART -->
                <div class="configurator-add">
                    {if (isset($configurator->hide_button_add_to_cart) and $configurator->hide_button_add_to_cart eq 0 ) or $update_cart}
                        {if $display_modal}
                            <button
                                    type="button"
                                    class="btn btn-primary"
                                    data-toggle="modal"
                                    data-target="#configuratorPreviewModalConfirmation"
                                    {if $disable_addtocart_btn && $progress_value < 100}
                                        disabled
                                    {/if}
                            >
                                <i class="icon icon-chevron-right"></i>
                                {if $update_cart}
                                    <span id="current_configurator_to_cart">{l s='Update the cart' mod='configurator'}</span>
                                    <span style="display:none" id="wait_configurator_to_cart">{l s='Update in progress...' mod='configurator'}</span>
                                {else}
                                    <span id="current_configurator_to_cart">{l s='Add to cart' mod='configurator'}</span>
                                    <span style="display:none" id="wait_configurator_to_cart">{l s='Add in progress...' mod='configurator'}</span>
                                {/if}
                            </button>
                        {/if}
                        <button
                            type="submit"
                            id="add_configurator_to_cart"
                            class="button btn btn-primary {if $display_modal}hide-btn{/if}"
                            {if $disable_addtocart_btn && $progress_value < 100}
                                disabled
                            {/if}
                            {if $nbTabsGroup > 1}
                                style="display:none;"
                            {/if}>
                            <i class="material-icons shopping-cart"></i>
                            {if $update_cart}
                                <span id="current_configurator_to_cart">{l s='Update the cart' mod='configurator'}</span>
                                <span style="display:none" id="wait_configurator_to_cart">{l s='Update in progress...' mod='configurator'}</span>
                            {else}
                                <span id="current_configurator_to_cart">{l s='Add to cart' mod='configurator'}</span>
                                <span style="display:none" id="wait_configurator_to_cart">{l s='Add in progress...' mod='configurator'}</span>
                            {/if}
                        </button>
                        {if $nbTabsGroup > 1}
                            <a id="tab-action-next-preview" class="btn btn-primary btn-lg btn-block">
                                {l s='Next' mod='configurator'}
                                <i class="icon icon-chevron-right"></i>
                            </a>
                        {/if}
                    {/if}

                    {if $displaySharingButton}
                        <a id="configurator_obtain_sharing_link" class="btn btn-secondary btn-sm mt-2" href="#" data-cart-detail="{$id_cart_detail}">
                            <span>{l s='Share' mod='configurator'}</span>
                        </a>
                        <div id="configurator_obtain_sharing_link_modal" class="modal" tabindex="-1">
                            <div class="modal-dialog">
                                <div class="modal-content">
                                    <div class="modal-body">
                                        <p>{l s='This is your sharing link' mod='configurator'} :</p>
                                        <code><span id="configurator_obtain_sharing_link_modal_content"></span></code>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary" data-dismiss="modal">{l s='Close' mod='configurator'}</button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    {/if}

                    {hook h='displayConfiguratorFrontCartPreviewQuantity' id_cart_detail=$id_cart_detail}
                </div>
            </form>
        </div>
        
    </div>

    <div class="displayConfiguratorFrontCartPreview">
        {hook h='displayConfiguratorFrontCartPreview' id_cart_detail=$id_cart_detail}
    </div>

</div>

</div>
{/if}
{if Configuration::get('CONFIGURATOR_MODAL_CONFIRMATION_CART') || Configuration::get('CONFIGURATOR_MODAL_CONFIRMATION_CART_ACCEPTATION')}
    {$modal_confirmation nofilter}{* HTML content, no escape necessary *}
{/if}
