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

{if $step->use_qty}
<div class="col-lg-6">
{/if}

<select class='select_option' {if $step->multiple}multiple{/if}>
	{foreach $step->options as $option}
		{if $option && $option->selected_by_default}
			{assign var=step_have_default value=true}
		{/if}
	{/foreach}
	{if !isset($step_have_default) || !$step_have_default}
		<option data-step='{$step->id|escape:'htmlall':'UTF-8'}' value="">{l s='Choose a value in the list' mod='configurator'}</option>
	{/if}
	{foreach $step->options as $option}
		{if $option}
			<optgroup id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
					  class="option option_select"
					  style="display:none;">
				<option is-select-option
						id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
						data-step='{$step->id|escape:'htmlall':'UTF-8'}'
						value="{$option->id|escape:'htmlall':'UTF-8'}">
					{$option->option.name|escape:'html':'UTF-8'}
					{if $step->display_total}
						{include file="../impact_total_price.tpl" before='(' after=')'}
					{/if}
					{if !$step->display_total}
						{include file="../impact_price.tpl" before='(' after=')'}
					{/if}
				</option>
			</optgroup>
		{/if}
	{/foreach}
	{assign var=step_have_default value=false}
</select>
	
{if $step->use_qty}
</div>
{/if}

{if $step->use_qty}
	<div class="col-lg-6">
		{include file="../quantity.tpl" showlabel=true unique=true}
	</div>
{/if}
