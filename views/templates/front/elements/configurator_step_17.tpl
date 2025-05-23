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

{assign var='stepInfos' value=$configuratorCartDetail->getStepInfosByIdStep($step->id)}
<div id="step_{$step->id|escape:'htmlall':'UTF-8'}"
     class="step_group form-group {if $stepInfos neq false}info-on-this-step{/if} {$tabClass|escape:'htmlall':'UTF-8'} {$step->class|escape:'htmlall':'UTF-8'} {if $step->dropzone}dmviewer2d-step-dropzone{/if}"
     style="display : none;{$step->css|escape:'htmlall':'UTF-8'}"
>
    <label class="title">
        <span class="step_title">
           <!-- <i class="material-icons">chevron_right</i> -->
           <span class="dmicons"> </span>
            {$step->public_name|escape:'html':'UTF-8'}
            {if $step->required}
                <sup>*</sup>
            {/if}
        </span>
        {if $step->content neq ''}
            {include    file='./info.tpl'
                        title=$step->public_name
                        content=$step->content}
        {/if}
    </label>

    {if $display_price}
        {assign var="stepPrice" value=0}
        {foreach $configuratorCartDetail->getDetail() as $id => $stepDetail}
            {if $id == $step->id && isset($stepDetail.display_step_amount)}
                {assign var="stepPrice" value=$stepDetail.display_step_amount}
            {/if}
        {/foreach}
        <div class="display-step-amount">{Tools::displayPrice($stepPrice)}</div>
    {/if}
    <div class="row">
        <div class="col-xs-12 error-step"></div>
        <div class="col-xs-12 info-step">
            {if $stepInfos neq false}
                <p>
                    {$stepInfos nofilter}{* HTML content, no escape necessary *}
                </p>
            {/if}
        </div>
        <div class="col-xs-12 info-text">
            {if $step->info_text }
                {$step->info_text nofilter}{* HTML content, no escape necessary *}
            {/if}
        </div>
        <div class="col-xs-12">
            {if $step->isType(ConfiguratorStepAbstract::TYPE_STEP_UPLOAD)}
                <p class="text-muted">
                    {l s='You can download a maximum of %d files.' mod='configurator' sprintf=[$step->nb_files]}
                    {if !empty($step->extensions)}
                        {l s='Allowed extensions:' mod='configurator'}&nbsp;{$step->getDisplayExtensions()|escape:'html':'UTF-8'}
                    {/if}
                </p>
            {/if}
            {if $step->displayed_by_yes}
                <div class="form-group">
                    <div>
                        <input data-toggle="collapse"
                               data-target="#collapse_{$step->id|escape:'htmlall':'UTF-8'}"
                               data-step="{$step->id|escape:'htmlall':'UTF-8'}"
                               type="radio"
                               id="no_radio_{$step->id|escape:'htmlall':'UTF-8'}"
                               class="no_radio"
                               name="yesnoradio[{$step->id|escape:'htmlall':'UTF-8'}][]"
                               checked="checked" />
                        <label for="no_radio_{$step->id|escape:'htmlall':'UTF-8'}">{l s='No' mod='configurator'}</label>
                    </div>

                    <div>
                        <input data-toggle="collapse"
                               data-target="#collapse_{$step->id|escape:'htmlall':'UTF-8'}"
                               type="radio"
                               id="yes_radio_{$step->id|escape:'htmlall':'UTF-8'}"
                               class="yes_radio"
                               name="yesnoradio[{$step->id|escape:'htmlall':'UTF-8'}][]" />
                        <label for="yes_radio_{$step->id|escape:'htmlall':'UTF-8'}">{l s='Yes' mod='configurator'}</label>
                    </div>
                </div>
            {/if}

            {assign var='img_color_exists' value=false}
            {assign var='img_color_not_exists' value=true}
            {foreach $step->options as $option}
                {if Validate::isLoadedObject($option)}
                    {if isset($option->option['id_attribute'])}
                        {assign var='img_color_exists' value=$img_color_exists or file_exists($smarty.const._PS_COL_IMG_DIR_|cat:$option->option['id_attribute']|cat:'.jpg')}
                    {elseif isset($option->option['id_product'])}
                        {assign var='img_color_exists' value=$img_color_exists or file_exists($smarty.const._PS_COL_IMG_DIR_|cat:$option->option['id_product']|cat:'.jpg')}
                    {/if}
                    {if isset($option->option['id_attribute'])}
                        {assign var='img_color_not_exists' value=$img_color_not_exists or !file_exists($smarty.const._PS_COL_IMG_DIR_|cat:$option->option['id_attribute']|cat:'.jpg')}
                    {elseif isset($option->option['id_product'])}
                        {assign var='img_color_not_exists' value=$img_color_not_exists or !file_exists($smarty.const._PS_COL_IMG_DIR_|cat:$option->option['id_product']|cat:'.jpg')}
                    {/if}
                {/if}
            {/foreach}
            <div class="{if $step->displayed_by_yes}collapse{/if} step_options {if $img_color_exists && $img_color_not_exists}step-color-texture{/if}" id="collapse_{$step->id|escape:'htmlall':'UTF-8'}">
                {if $step->displayed_by_yes}<hr/>{/if}
                {if $step->type !== ConfiguratorStepAbstract::TYPE_STEP_DESIGNER}
                    {include file='./'|cat:{$step->type}|cat:'/default.tpl' step=$step}
                {/if}
                {hook h='displayConfiguratorFrontStepOptions' configurator_step=$step configurator_cart_detail=$configuratorCartDetail}
            </div>
        </div>
    </div>
</div>
