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

{*
*   Params :
*       $step
*       $option
*   Additionnal :
*       $dimension
*       $min
*       $max
*}

<span class="input-group-addon">{$option->option.name|escape:'html':'UTF-8'} : </span>

<input 
        {* If dimension, min and max are provided, add constraints*}
        {if isset($dimension) && isset($min) && isset($max)}
                data-dimension="{$dimension|escape:'htmlall':'UTF-8'}"
                data-min="{$min|escape:'htmlall':'UTF-8'}" 
                data-max="{$max|escape:'htmlall':'UTF-8'}"
        {/if}
		{if $option->min_value != ""}
                data-min="{$option->min_value|escape:'htmlall':'UTF-8'}"
        {/if}
		{if $option->max_value != ""}
                data-max="{$option->max_value|escape:'htmlall':'UTF-8'}"
        {/if}
        {if $option->placeholder != ""}
                placeholder="{$option->placeholder|escape:'htmlall':'UTF-8'}"
        {/if}
        data-step='{$step->id|escape:'htmlall':'UTF-8'}' 
        data-option='{$option->id|escape:'htmlall':'UTF-8'}'
        data-force="{$option->force_value|escape:'htmlall':'UTF-8'}"
        id="option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
        class="form-control grey" 
        type="text" 
        value="" 
/>

{if $step->input_suffix neq ''}
        <span class="input-group-addon">
                {$step->input_suffix|escape:'htmlall':'UTF-8'}
        </span>
{/if}

{if !empty($option->content[$lang_id])}
        {include file='../info.tpl' 
                 title=$option->option.name
                 content=$option->content[$lang_id]}
{/if}

{if $step->price_list eq ''}{include file="../impact_price.tpl"}{/if}
