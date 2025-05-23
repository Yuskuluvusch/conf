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
		{assign var='current_img_color_exists' value=file_exists($smarty.const._PS_COL_IMG_DIR_|cat:$option->option['id_attribute']|cat:'.jpg')}
		{assign var='isCustom' value=($current_img_color_exists and isset($option->option.texture_image) and $option->option.texture_image)}

		{** TODO: col_img_dir **}

		<div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
		 	class="option_block option_group {if $isCustom}custom{else}colortexture {if !$img_color_exists}color{else}texture{/if}{/if}"
		 	style="display:none;"
			{if $img_color_not_exists and empty($option->content[$lang_id])}
				data-toggle="popover"
				data-content="{$option->option.name|escape:'html':'UTF-8'} "
			{elseif !empty($option->content[$lang_id])}
				data-toggle="popover"
				title="{$option->option.name|escape:'html':'UTF-8'}"
				data-content="{$option->content[$lang_id]|escape:'htmlall':'UTF-8'} "
			{/if}
		>

			<div class='option_block_content'>
				<span class="configurator-zoom">
					<i class="material-icons zoom-in">&#xE8FF;</i>
				</span>

				<div class="option_img" style="background-color: {$option->option.color|escape:'htmlall':'UTF-8'}">
					{if $current_img_color_exists}
						<img class="img-responsive" alt="{$option->option.name|escape:'html':'UTF-8'}" src="{$img_col_dir|cat:$option->id_option|cat:'.jpg'}" />
					{/if}
				</div>

				<input class="hidden"
					   data-step='{$step->id|escape:'htmlall':'UTF-8'}'
					   id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
					   type="{if $step->multiple}checkbox{else}radio{/if}" name="step[{$step->id|escape:'htmlall':'UTF-8'}][]"
					   value="{$option->id|escape:'htmlall':'UTF-8'}"
				/>

				{if $img_color_exists and !$img_color_exists and $option->option.texture_image}<span>{$option->option.name|escape:'html':'UTF-8'}</span>{/if}
				{if !$isCustom and !$step->display_total or $isCustom and !$step->use_qty}
					{include file="../impact_price.tpl"}
				{/if}
			</div>

			{if $step->use_qty}
				{include file="../quantity.tpl"}
			{/if}

			{if $isCustom and $step->use_qty and !$step->display_total}
				{include file="../impact_price.tpl"}
			{/if}

			{if $step->display_total}
				{include file="../impact_total_price.tpl"}
			{/if}
		</div>
	{/if}
{/foreach}
<div class="clearfix">&nbsp;</div>
