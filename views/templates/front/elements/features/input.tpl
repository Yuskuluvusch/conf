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
*   Precondition: $step->price_list eq ''
*   Generate input's HTML for all options
*   If no constraints are given, generates a simple input.
*   If constraints (dimension, min and max) are given, adds them in input's parameters
*
*   Parameters :
*       $step       Same as in dispatcher
*       
*}
<div class="row">
    {foreach $step->options as $option}
        {if $option}
            <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
                 class="option_input option_group col-md-6 form-group" style="display:none;">
                <div class="input-group">
                    {include file='./input_core.tpl' option=$option step=$step dimension="1"}
                </div>

                {if $option->min_value || $option->max_value}
                    <small>
                        {l s='Available values:' mod='configurator'}
                        {if $option->min_value && $option->max_value}
                            {$option->min_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'} - {$option->max_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
                        {else if $option->min_value}
                            > {$option->min_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
                        {else if $option->max_value}
                            < {$option->max_value|escape:'htmlall':'UTF-8'}{$step->input_suffix|escape:'htmlall':'UTF-8'}
                        {/if}
                    </small>
                {/if}

            </div>
        {/if}
    {/foreach}
</div>
