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

{if !isset($before)}
	{assign var=before value=''}
{/if}
{if !isset($after)}
	{assign var=after value=''}
{/if}

{assign var='priceDisplayPrecision' value=$smarty.const._PS_PRICE_DISPLAY_PRECISION_|intval}

{if $option->impact_value > 0 || strlen($option->impact_formula) > 0}
	{if $option->impact_type eq 'percent'}
		<span class="label label-default percent">
			{$before}+ {Tools::ps_round($option->impact_value, $priceDisplayPrecision)|escape:'htmlall':'UTF-8'}%{$after}
		</span>
	{elseif $option->impact_type eq 'area' and $option->impact_step_id}
		{if !empty($option->unity)}
			{assign var=area_suffix value=$option->unity}
		{else}
			{foreach $configurator->steps as $step}
				{if $step->id eq $option->impact_step_id}
					{assign var=area_suffix value=$step->input_suffix}
					{break}
				{/if}
			{/foreach}
		{/if}
		<span class="label label-default area">
			{if $option->conversion_factor > 0}
				{assign var=amount value=$option->impact_value * $option->conversion_factor}
			{else}
                                {assign var=amount value=$option->impact_value}
				{assign var=area_suffix value=$option->impact_value}
			{/if}
			{$before}+ {Tools::displayPrice(ConfiguratorCartDetailModel::getPriceOption($amount, $productObject->id))}{$after}
			{if isset($area_suffix)}/&nbsp;{$area_suffix|escape:'htmlall':'UTF-8'}²{/if}
		</span>
	{elseif $option->impact_type eq 'area_multiple' and $option->impact_step_id}
		{if !empty($option->unity)}
			{assign var=area_suffix value=$option->unity}
		{else}
			{assign var=impact_multiple_step_id value=$option->impact_multiple_step_id}
			{assign var=impact_multiple_step_id value=","|explode:$impact_multiple_step_id}
			{foreach $configurator->steps as $step}
				{if $step->id|in_array:$impact_multiple_step_id}
					{assign var=area_suffix value=$step->input_suffix}
					{break}
				{/if}
			{/foreach}
		{/if}
		<span class="label label-default area">
			{if $option->conversion_factor > 0}
				{assign var=amount value=$option->impact_value * $option->conversion_factor}
			{else}
				{assign var=amount value=$option->impact_value}
				{assign var=area_suffix value=$option->impact_value}
			{/if}
			{$before}+ {Tools::displayPrice(ConfiguratorCartDetailModel::getPriceOption($amount, $productObject->id))}{$after}
			{if isset($area_suffix)}/&nbsp;{$area_suffix|escape:'htmlall':'UTF-8'}²{/if}
		</span>
	{elseif     $option->impact_type eq 'multiplier'
                or  $option->impact_type eq 'neg_multiplier'
                or  $option->impact_type eq 'multiplier_price'}
		<span class="label label-default multiplier"></span>
	{elseif $option->impact_type eq 'reduction'}
		<span class="label label-default amount">
			{$before}- {Tools::displayPrice(ConfiguratorCartDetailModel::getPriceOption($option->impact_value, $productObject->id))}{$after}
		</span>
	{else}
		<span class="label label-default amount">
			{$before}+ {Tools::displayPrice(ConfiguratorCartDetailModel::getPriceOption($option->impact_value, $productObject->id))}{$after}
		</span>
		<span class="label label-danger reduc">- {Tools::displayPrice(0)}</span>
	{/if}
{elseif ($option->impact_type eq 'pricelist' or $option->impact_type eq 'pricelist_area' or $option->impact_type eq 'pricelist_area_square') and ($option->impact_step_id or ($option->id_impact_step_option_x and $option->id_impact_step_option_y))}
	<span class="label label-default pricelist"></span>
{elseif $option->impact_type eq 'pricelist_quantity' and !$step->use_qty}
	<span class="label label-default pricelist"></span>
{/if}
