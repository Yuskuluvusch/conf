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

<div class="row">
        {if $step->options[0]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[0]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file='../options/input_core.tpl' option=$step->options[0] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
        {if $step->options[1]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[1]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file='../options/input_core.tpl' option=$step->options[1] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
</div>
<div class="row">
        {if $step->options[2]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[2]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file='../options/input_core.tpl' option=$step->options[2] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
</div>
<div class="row">
        {if $step->options[3]}
                <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$step->options[3]->id|escape:'htmlall':'UTF-8'}"
                     class="option_input option_group col-md-6 form-group" style="display:none;">
                        <div class="input-group">
                                {include file='../options/input_core.tpl' option=$step->options[3] step=$step dimension="1"}
                        </div>
                </div>
        {/if}
</div>
