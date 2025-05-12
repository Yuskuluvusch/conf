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
        {foreach $step->options as $option}
                {if $option}
                        <div id="step_option_{$step->id|escape:'htmlall':'UTF-8'}_{$option->id|escape:'htmlall':'UTF-8'}"
                             class="option_input option_group col-md-6 form-group" style="display:none;">
                                <div class="input-group">
                                        {include file='../options/input_core.tpl' option=$option step=$step dimension="1"}
                                </div>
                        </div>
                {/if}
        {/foreach}
</div>
