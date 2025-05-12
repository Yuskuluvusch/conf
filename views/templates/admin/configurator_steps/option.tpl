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

{assign var='template_id' value=$option->id}

<div class="col-lg-12">
    <div class="panel">
        <h3 class="tab"><i class="icon-cog"></i> {l s='General settings' mod='configurator'}</h3>
        {include 'module:configurator/views/templates/admin/configurator_steps/option_settings.tpl'
            id=$template_id
            option=$option
            configurator=$configurator
        }
    </div>
</div>

<div class="col-lg-6">
    <div class="panel">
        <h3 class="tab"> <i class="icon-dollar"></i> {l s='Price impact' mod='configurator'}</h3>

        {if $configurator_step->price_list eq ''}

            {include 'module:configurator/views/templates/admin/configurator_steps/price_impact.tpl'
                id=$template_id
                option=$option
                currency=$currency
            }

        {else}
            <div class="alert alert-warning">
                {l s='You already use a price list for impact price.' mod='configurator'}
            </div>
        {/if}

    </div>

    <div class="panel">
        <h3 class="tab"> <i class="icon-dollar"></i> {l s='Tax impact' mod='configurator'}</h3>
        {include 'module:configurator/views/templates/admin/configurator_steps/tax_impact.tpl'
            id=$template_id
            option=$option
            currency=$currency
        }
    </div>

    <!-- DIVISION PARAMETERS -->
    {if $configurator_step->use_division}
        <div class="panel">

            <h3 class="tab"> <i class="icon-eye-open"></i> {l s='Division' mod='configurator'}</h3>

            <div id="division_block_{$template_id|escape:'html':'UTF-8'}" class="division_block">
                <div class="form-group">
                    <label class="col-lg-12">{l s='Division for :' mod='configurator'} {$option->option.name|escape:'html':'UTF-8'}</label>
                </div>

                <hr />

                {include 'module:configurator/views/templates/admin/configurator_steps/division_block.tpl'
                    id=$template_id
                    type="division" 
                    choices=$conditions_choices
                    division_value=$option->id_configurator_step_option_division
                    option=$option
                }
            </div>
        </div>
    {/if}
    <!-- END DIVISION PARAMETERS -->
</div>

<div class="col-lg-6">
    <!-- DISPLAY CONDITIONS PARAMETERS -->
    <div class="panel">
        <h3 class="tab"> <i class="icon-eye-open"></i> {l s='Display conditions of an option' mod='configurator'}</h3>

        <div id="display_conditions_block_{$option->id|escape:'html':'UTF-8'}" class="display_conditions_block">
            <div class="form-group">
                <label class="col-lg-12">{l s='Display conditions for :' mod='configurator'} {$option->option.name|escape:'html':'UTF-8'}</label>
            </div>

            <hr />

            {include 'module:configurator/views/templates/admin/configurator_steps/conditions_block.tpl'
                type="option"
                id=$template_id
                choices=$conditions_choices
                values=$options_conditions[$template_id]
            }
        </div>
    </div>
    <!-- END DISPLAY CONDITIONS PARAMETERS -->
</div>

<div class="configuratorDisplayAdminOptionSettingsFooter">
    {hook h='configuratorDisplayAdminOptionSettingsFooter' configurator_step=$configurator_step option=$option id=$template_id}
</div>



<script type="text/javascript">
	$(document).ready(function(){
		if(typeof formulaEditor !== 'undefined') {
			formulaEditor.init();
		}
	});
</script>
