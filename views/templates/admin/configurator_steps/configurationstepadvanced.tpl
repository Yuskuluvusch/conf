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
    <div id="tab-pane-ConfigurationStepAdvanced" class="tab-pane">
        <!-- CONFIGURATION STEP ADVANCED -->
        <div class="panel configurator-steps-tab">
            <h3 class="tab">
				<i class="icon-cog"></i>
				{l s='Advanced step\'s configuration' mod='configurator'}
			</h3>
			<div class="row">
				<div class="col-xs-12 col-lg-6">
					<!-- WEIGHT -->
					<div step-type='attributes,products,features'>
						<h4>
							<i class="icon-truck"></i>
							{l s='Weight management' mod='configurator'}
						</h4>
						<div class="form-group">
							<label class="control-label col-lg-4" for="weight">
								<span class="label-tooltip"
									  data-toggle="tooltip"
									  title="{l s='Set a weight' mod='configurator'}"
								>
									{l s='Weight' mod='configurator'}
								</span>
							</label>

							<div class="input-group col-lg-7">
								<input
										id="weight"
										class="form-control grey formula_editor"
										type="text"
										name="weight"
										value="{$configurator_step->weight|escape:'htmlall':'UTF-8'}"
								>
								<span class="input-group-addon">
									{Configuration::get('PS_WEIGHT_UNIT')}
								</span>
							</div>
						</div>
					</div>
					<!-- DELIVERY -->
					<div step-type='attributes,products,features'>
						<h4>
							<i class="icon-calendar"></i>
							{l s='Delivery management' mod='configurator'}
						</h4>

						<div class="alert alert-warning">
							@TODO
						</div>

						<div class="form-group">
							<label class="control-label col-lg-4" for="weight">
								<span class="label-tooltip"
									  data-toggle="tooltip"
									  title="{l s='Set a delivery impact in hours' mod='configurator'}"
								>
									{l s='Delivery impact' mod='configurator'}
								</span>
							</label>

							<div class="input-group col-lg-7">
								<input
										id="delivery_impact"
										class="form-control grey formula_editor"
										type="text"
										name="delivery_impact"
										value="{$configurator_step->delivery_impact|escape:'htmlall':'UTF-8'}"
								>
								<span class="input-group-addon">
									{l s='hours' mod='configurator'}
								</span>
							</div>
						</div>
					</div>
				</div>
				<div class="col-xs-12 col-lg-6">
					<!-- DIMENSIONS -->
					<div step-type='attributes,products,features'>
						<h4>
							<i class="icon-truck"></i>
							{l s='Dimensions management' mod='configurator'}
						</h4>
						<div class="form-group">
							<label class="control-label col-lg-4" for="dimension_width">
								<span class="label-tooltip"
									  data-toggle="tooltip"
									  title="{l s='Set the width of the final product' mod='configurator'}"
								>
									{l s='Width' mod='configurator'}
								</span>
							</label>

							<div class="input-group col-lg-7">
								<input
									id="dimension_width"
									class="form-control grey formula_editor"
									type="text"
									name="dimension_width"
									value="{$configurator_step->dimension_width|escape:'htmlall':'UTF-8'}"
								>
								<span class="input-group-addon">
									{Configuration::get('PS_DIMENSION_UNIT')}
								</span>
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-lg-4" for="dimension_height">
								<span class="label-tooltip"
									  data-toggle="tooltip"
									  title="{l s='Set the height of the final product' mod='configurator'}"
								>
									{l s='Height' mod='configurator'}
								</span>
							</label>

							<div class="input-group col-lg-7">
								<input
									id="dimension_height"
									class="form-control grey formula_editor"
									type="text"
									name="dimension_height"
									value="{$configurator_step->dimension_height|escape:'htmlall':'UTF-8'}"
								>
								<span class="input-group-addon">
									{Configuration::get('PS_DIMENSION_UNIT')}
								</span>
							</div>
						</div>

						<div class="form-group">
							<label class="control-label col-lg-4" for="dimension_depth">
								<span class="label-tooltip"
									  data-toggle="tooltip"
									  title="{l s='Set the depth of the final product' mod='configurator'}"
								>
									{l s='Depth' mod='configurator'}
								</span>
							</label>

							<div class="input-group col-lg-7">
								<input
									id="dimension_depth"
									class="form-control grey formula_editor"
									type="text"
									name="dimension_depth"
									value="{$configurator_step->dimension_depth|escape:'htmlall':'UTF-8'}"
								>
								<span class="input-group-addon">
									{Configuration::get('PS_DIMENSION_UNIT')}
								</span>
							</div>
						</div>
					</div>

				</div>
							
			</div>
			
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
