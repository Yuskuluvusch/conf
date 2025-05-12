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

{if !isset($id)}
    {assign var=id value=0}
{/if}
{if empty($choices)}
    <div class="alert alert-warning">
        {l s='You must save this step before configuring division.' mod='configurator'}
    </div>
{elseif empty($choices.block_option.groups)}
    <div class="alert alert-warning">
        {l s='You can\'t configure division on the first step.' mod='configurator'}
    </div>
{elseif ! $find_division_step}
    <div class="alert alert-warning">
        {l s='No steps found.' mod='configurator'}
    </div>
{else}
    
    {foreach $choices as $block}
        
        <div id="step_division_block_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}"
             class="step_division_block step_division_{$type|escape:'htmlall':'UTF-8'}_block"
             data-id="{$id|escape:'htmlall':'UTF-8'}"
             data-value="{$division_value|escape:'htmlall':'UTF-8'}"
        >
            <div class="form-group">
                <label class="control-label col-lg-2">{$block.name|escape:'htmlall':'UTF-8'}</label>
                <div class="col-lg-9">
                    {foreach $block.groups as $key => $group}
                        {if $group.type === 'select'}
                            <div class="{$group.class|escape:'htmlall':'UTF-8'}" >
                                {foreach $group.selects as $select}
                                    {if !isset($select.parent_step) || $select.parent_step->use_input || $select.parent_step->price_list }
                                        <select
                                            {foreach $select.params as $attr => $value} {$attr|cat:"="|cat:$value|escape:'htmlall':'UTF-8'}{/foreach}
                                        >
                                            <option value="0">{l s='No division' mod='configurator'}</option>
                                            {foreach $select.options as $value => $option}
                                                {if $option.classname!="ConfiguratorStepAbstract" || $option.object->use_input || $option.object->price_list }
                                                    <option value="{$value|escape:'htmlall':'UTF-8'}"
                                                        {foreach $option.attrs as $attr => $value} {$attr|cat:"="|cat:$value|escape:'htmlall':'UTF-8'}{/foreach}
                                                    >
                                                        {$option.option|escape:'htmlall':'UTF-8'}
                                                    </option>
                                                {/if}
                                            {/foreach}
                                        </select>
                                    {/if}
                                {/foreach}
                            </div>
                        {/if}
                    {/foreach}
                </div>
            </div>
        </div>
        {break}
    {/foreach}
{/if}
