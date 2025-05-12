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

{foreach $step->options as $option}
    {if $option}
		<div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}" class="option option_group" style="display:none;">
			<input data-step='{$step->id|escape:'htmlall':'UTF-8'}' 
				   id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
				   type="{if $step->multiple}checkbox{else}radio{/if}" 
				   name="step[{$step->id|escape:'htmlall':'UTF-8'}][]" 
				   value="{$option->id|escape:'htmlall':'UTF-8'}"
				   {if $step->use_qty}style='display: none;'{/if}
		   />
			{if $step->use_qty}
				{include file="../quantity.tpl"}
			{/if}
			<label for="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}">
				{$option->option.name|escape:'html':'UTF-8'}
				{if $step->display_total}
					{include file="../impact_total_price.tpl"}
				{/if}
				{if !$step->display_total}
					{include file="../impact_price.tpl"}
				{/if}
			</label>
			{if !empty($option->content[$lang_id])}
				{include file='../info.tpl' 
					 title=$option->option.name
					 content=$option->content[$lang_id]}
			{/if}
		</div>
    {/if}
{/foreach}
