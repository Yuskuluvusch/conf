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


<h2>{l s='Product configurator - General' mod='configurator'}</h2>
{if $product}
    {if $configurator}
        <div class="alert alert-success">
            <p class="alert-text">{l s='There is a configurator for' mod='configurator'} {$product->name|escape:'html':'UTF-8'}</p>
        </div>
        
        <a href="{Context::getContext()->link->getAdminLink('AdminConfiguratorSteps')|escape:'htmlall':'UTF-8'}&id_configurator={$configurator->id|escape:'htmlall':'UTF-8'}" class="btn btn-primary" title="{l s='Manage step' mod='configurator'}"><i class="icon-edit"></i> {l s='Manage steps' mod='configurator'}</a>
        <a href="{Context::getContext()->link->getAdminLink('AdminConfigurator')|escape:'htmlall':'UTF-8'}&statusconfigurator&id_configurator={$configurator->id|escape:'htmlall':'UTF-8'}&id_product={$product->id|escape:'htmlall':'UTF-8'}" class="btn btn-default" title="{if $configurator->active}{l s='Desactivate configurator' mod='configurator'}{else}{l s='Activate configurator' mod='configurator'}{/if}">{if $configurator->active}{l s='Desactivate configurator' mod='configurator'}{else}{l s='Activate configurator' mod='configurator'}{/if}</a>
        <a onclick="{literal}if (confirm('{/literal}{l s='Are you sure to delete the configurator ?' mod='configurator'}{literal}')) {
                        return true;
                    } else {
                        event.stopPropagation();
                        event.preventDefault();
                    }
                    ;{/literal}" href="{Context::getContext()->link->getAdminLink('AdminConfigurator')|escape:'htmlall':'UTF-8'}&deleteconfigurator&id_configurator={$configurator->id|escape:'htmlall':'UTF-8'}" class="btn btn-danger" title="{l s='Delete configurator' mod='configurator'}"><i class="icon-remove-sign"></i> {l s='Delete configurator' mod='configurator'}</a>

		<div class="row">
			<div class="col-md-12">
				<h2>{l s='Final price' mod='configurator'}</h2>
			</div>
			<div class="col-md-4">
				<select name="use_base_price" data-toggle="select2">
					<option value="1" {if $configurator->use_base_price}selected{/if}>{l s='Base price + configurated price' mod='configurator'}</option>
					<option value="0" {if !$configurator->use_base_price}selected{/if}>{l s='Configurated price only' mod='configurator'}</option>
				</select>
			</div>
		</div>
                 
                                
		 <div class="row">
			<div class="col-md-12">
					<h2>{l s='Hide quantity' mod='configurator'}</h2>
			</div>

			<div class="col-md-9">
					<input type="radio" name="hide_qty_product" id="hide_qty_product_on" value="1" {if $configurator->hide_qty_product}checked="checked" {/if} />
					<label for="hide_qty_product_on" class="radioCheck">
							{l s='Yes' mod='configurator'}
					</label>
					<input type="radio" name="hide_qty_product" id="hide_qty_product_off" value="0" {if !$configurator->hide_qty_product}checked="checked"{/if} />
					<label for="hide_qty_product_off" class="radioCheck">
							{l s='No' mod='configurator'}
					</label>
			</div>
		</div>
                                        
                                        
                <div class="row">
                    <div class="col-md-12">
                        <h2>{l s='Hide button add to cart' mod='configurator'}</h2>
                    </div>
                        
                    <div class="col-md-9">
                        <input type="radio" name="hide_button_add_to_cart" id="hide_button_add_to_cart_on" value="1" {if $configurator->hide_button_add_to_cart}checked="checked" {/if} />
                        <label for="hide_button_add_to_cart_on" class="radioCheck">
                                {l s='Yes' mod='configurator'}
                        </label>
                        <input type="radio" name="hide_button_add_to_cart" id="hide_button_add_to_cart_off" value="0" {if !$configurator->hide_button_add_to_cart}checked="checked"{/if} />
                        <label for="hide_button_add_to_cart_off" class="radioCheck">
                                {l s='No' mod='configurator'}
                        </label>
                    </div>
                </div>
                        
                        
                <div class="row">
                    <div class="col-md-12">
                        <h2>{l s='Hide product price' mod='configurator'}</h2>
                    </div>
                        
                    <div class="col-md-9">
                        <input type="radio" name="hide_product_price" id="hide_product_price_on" value="1" {if $configurator->hide_product_price}checked="checked" {/if} />
                        <label for="hide_product_price_on" class="radioCheck">
                                {l s='Yes' mod='configurator'}
                        </label>
                        <input type="radio" name="hide_product_price" id="hide_product_price_off" value="0" {if !$configurator->hide_product_price}checked="checked"{/if} />
                        <label for="hide_product_price_off" class="radioCheck">
                                {l s='No' mod='configurator'}
                        </label>
                    </div>
                </div>


                <div class="row">
                    <div class="col-md-12">
                        <h2>{l s='Use combination' mod='configurator'}</h2>
                    </div>

                    <div class="col-md-9">
                        <input type="radio" name="use_combination" id="use_combination_on" value="1" {if $configurator->use_combination}checked="checked" {/if} />
                        <label for="use_combination_on" class="radioCheck">
                                {l s='Yes' mod='configurator'}
                        </label>
                        <input type="radio" name="use_combination" id="use_combination_off" value="0" {if !$configurator->use_combination}checked="checked"{/if} />
                        <label for="use_combination_off" class="radioCheck">
                                {l s='No' mod='configurator'}
                        </label>
                    </div>
                </div>
                        
		{$HOOK_CONFIGURATOR_DISPLAY_ADMIN_PRODUCTS_EXTRA}
		
    {else}

        <div class="alert alert-info" role="alert">
            <p class="alert-text">{l s='There is no configurator for' mod='configurator'} {if $product->name}{$product->name|escape:'html':'UTF-8'}{else}{l s='this product' mod='configurator'}{/if}</p>
        </div>

        <div class="row">
			<div class="col-lg-3">
				<a href="{Context::getContext()->link->getAdminLink('AdminConfigurator')|escape:'htmlall':'UTF-8'}&addconfigurator&id_product={$product->id|escape:'htmlall':'UTF-8'}" 
				   class="btn btn-primary" 
				   title="{l s='Add a configurator' mod='configurator'}">
					<i class="icon-plus-sign"></i> {l s='Add a configurator' mod='configurator'}
				</a>
			</div>
                         {*
			<div class="col-lg-1">
				<span class="text-center">
					<strong>{l s='OR' mod='configurator'}</strong>
				</span>
			</div>
			<div class="col-lg-5">
				<select name="duplicate_configurator" data-toggle="select2">
					<option value="">{l s='Select a product configuration to copy' mod='configurator'}</option>
					{foreach $configurators as $row}
						<option value="{$row.id_configurator|intval}">{$row.name|escape:'htmlall':'UTF-8'}</option>
					{/foreach}
				</select>
			</div>
			<div class="col-lg-3">
				<a  data-href="{Context::getContext()->link->getAdminLink('AdminConfigurator')|escape:'htmlall':'UTF-8'}&id_product={$product->id|escape:'htmlall':'UTF-8'}&duplicate_configurator=" 
					id="configurator_btn_duplicate" class="btn btn-primary" 
					title="{l s='Copy a configurator' mod='configurator'}">
					 <i class="icon-copy"></i>
					{l s='Copy configuration' mod='configurator'}
				 </a>
			</div> *}
		</div>

    {/if}
{else}
    <div class="alert alert-warning">
        <p class="alert-text">{l s='You must save this product before adding a configurator.' mod='configurator'}</p>
    </div>
{/if}

{if $product && $configurator}
    {include 'module:configurator/views/templates/admin/configurator/product_configurator_tabs_17.tpl'
        tabs=$productTabs
        configurator=$configurator
        languages=$languages
        languages_json=$languages_json
        id_lang=$default_form_language
    }
{/if}
<script type="text/javascript">
    {if isset($show_configurator) && $show_configurator}
    document.addEventListener("DOMContentLoaded", function(event) {
        setTimeout(() => {
            $('button.modules-list-button[data-target=module-configurator]').trigger('click');
        }, 750);
    });
    {/if}

    CONFIGURATOR_PRODUCT_UPLOAD_MANAGER.init();
	CONFIGURATOR_PRODUCT_DUPLICATE_MANAGER.init();
</script>
