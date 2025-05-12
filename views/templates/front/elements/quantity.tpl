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

{if !isset($showlabel)}
	{assign var=showlabel value=false}
{/if}
{if !isset($unique)}
	{assign var=unique value=false}
{/if}

{if isset($step) && $step->use_qty}
    <div {if $unique}unique-qty{/if} class="quantity_wanted form-group">
        {if $showlabel}
            <label>{l s='Quantity:' mod='configurator'}</label>
        {/if}
        <div class="input-group">
            <div class="input-group-btn">
                <button class="btn btn-configurator configurator-quantity-minus" type="button" {if $step->step_qty > 0}data-step="{{$step->step_qty}}"{/if}>-</button>
            </div>
            <input class="form-control qty {if $showlabel}qty-inline{/if}" type="text" value="0" data-force="{$option->force_value|escape:'htmlall':'UTF-8'}" {if $step->step_qty > 0}step="{{$step->step_qty}}"{/if}>
            <div class="input-group-btn">
                <button class="btn btn-configurator configurator-quantity-plus" type="button" {if $step->step_qty > 0}data-step="{{$step->step_qty}}"{/if}>+</button>
            </div>
        </div>
    </div>
{/if}
