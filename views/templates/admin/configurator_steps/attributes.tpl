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

<div class="tab-pane tab-content">
    <div id="tab-pane-{$type}" class="tab-pane">
        <div class="panel configurator-steps-tab">
            <h3 class="tab"> <i class="icon-info-sign"></i> {l s='Step\'s options' mod='configurator'}</h3>
            {if $options}
                <div class="row">
                    <div class="col-lg-12">
                        <div class="row">
							<div class="alert alert-info">
								{l s='You can delete the default option by clicking on ' mod='configurator'} <i class="icon-asterisk"></i>
							</div>
							{*if !empty($configurator_step->formula) or !empty($configurator_step->formula_surface)}
							<div class="alert alert-warning">
								{l s='You are using a formula to calculate step\'s price or surface.' mod='configurator'}
								{l s='If you disable an option, be sure that option\'s #ID is not used by your formula.' mod='configurator'}
							</div>
							{/if*}
                            {$listAttributes_html}{* HTML comment, no escape necessary *}
                        </div>
                    </div>
                </div>
                        
                <div id="configurator_option_content" class="row">
					<div class="col-lg-12">
						<div class="panel">
							<h3 class="tab"><i class="icon-cog"></i> {l s='General settings' mod='configurator'}</h3>
							<div id="alert-option-settings" class="alert alert-warning">
								{l s='Select an option to edit his settings' mod='configurator'}
							</div>
						</div>
					</div>
                    
                    <div class="col-lg-6">
                        <div class="panel">
                            <h3 class="tab"> <i class="icon-dollar"></i> {l s='Price impact' mod='configurator'}</h3>
                            {if $configurator_step->price_list eq ''}
                                <div id="alert-price-impact" class="alert alert-warning">
                                    {l s='Select an option to edit his price impact.' mod='configurator'}
                                </div>
                            {else}
                                <div class="alert alert-warning">
                                    {l s='You already use a price list for impact price.' mod='configurator'}
                                </div>
                            {/if}
                        </div>
                            
                        <!-- DIVISION PARAMETERS -->
                        {if $configurator_step->use_division}
                            <div class="panel">
                                <h3 class="tab"> <i class="icon-eye-open"></i> {l s='Division' mod='configurator'}</h3>
                                <div id="alert-division" class="alert alert-warning">
                                    {l s='Select an option to edit his division.' mod='configurator'}
                                </div>
                            </div>
                        {/if}
                        <!-- END DIVISION PARAMETERS -->
                    </div>
                    
                    <div class="col-lg-6">
                        <!-- DISPLAY CONDITIONS PARAMETERS -->
                        <div class="panel">
                            <h3 class="tab"> <i class="icon-eye-open"></i> {l s='Display conditions of an option' mod='configurator'}</h3>
                            <div id="alert-display-conditions" class="alert alert-warning">
                                {l s='Select an option to edit his display conditions.' mod='configurator'}
                            </div>
                        </div>
                        <!-- END DISPLAY CONDITIONS PARAMETERS -->
                    </div>
                            
                </div>
            {else}
				<div class="alert alert-warning">
					<button data-dismiss="alert" class="close" type="button">×</button>
					{l s='You must save this step before configuring options.' mod='configurator'}
				</div>
            {/if}

            <div class="panel-footer">
				<a href="{Context::getContext()->link->getAdminLink('AdminConfiguratorSteps')|escape:'html':'UTF-8'}&id_configurator={$id_configurator|escape:'htmlall':'UTF-8'}"
                   class="btn btn-default"
                >
                    <i class="process-icon-cancel"></i> {l s='Cancel' mod='configurator'}
                </a>
				<button type="submit"
                        name="submitAddconfigurator_step"
                        class="btn btn-default pull-right"
                >
                    <i class="process-icon-save"></i> {l s='Save' mod='configurator'}
                </button>
				<button type="submit"
                        name="submitAddconfigurator_stepAndStay"
                        class="btn btn-default pull-right"
                >
                    <i class="process-icon-save"></i> {l s='Save and stay' mod='configurator'}
                </button>
            </div>
        </div>

    </div>
</div>
