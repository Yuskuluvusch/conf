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

{assign var=id value=$configurator_step->id}

{if !Validate::isLoadedObject($configurator_step)}
	<div class="alert alert-warning">
		{l s='You must save this step before configuring filters.' mod='configurator'}
	</div>
{elseif empty($choices)}
	<div class="alert alert-warning">
		{l s='You can\'t configure filters on the first step.' mod='configurator'}
	</div>
{else}
	<div id="filters_block_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}"
		 class="filters_block filters_{$type|escape:'htmlall':'UTF-8'}_block"
		 data-type="{$type|escape:'htmlall':'UTF-8'}"
		 data-id="{$id|escape:'htmlall':'UTF-8'}"
	>
		<div id="filters_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}">
			<div id="filter_group_list_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}" class="filter_group_list"></div>
		</div>

		<a class="btn btn-default add_filter_group" href="#">
			<i class="icon-plus-sign"></i> {l s='Add a new filter group' mod='configurator'}
		</a>
		<div class="clearfix">&nbsp;</div>

		<div class="panel filters-panel"
			 id="filters-panel_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}"
			 class="filters-panel"
			 style="display:none;"
		>
			<h3><i class="icon-tasks"></i> {l s='Filters' mod='configurator'}</h3>

			<div class="form-group">
				<div class="col-lg-3 col-md-6">
					<label>{l s='Type' mod='configurator'}</label>
					<select class="select_type">
						{foreach $choices.filters_options as $choice_id => $choice_label}
							<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
								{$choice_label|escape:'htmlall':'UTF-8'}
							</option>
						{/foreach}
					</select>
				</div>
				<div class="col-lg-3 col-md-6">
					<label>{l s='Option' mod='configurator'}</label>
					<select class="select_option">
						<optgroup label="{$choices.filters_options.features}" data-type="features">
							{foreach $choices.features_options as $choice_id => $choice_label}
								<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
									{$choice_label|escape:'htmlall':'UTF-8'}
								</option>
							{/foreach}
						</optgroup>
						<optgroup label="{$choices.filters_options.attributes}" data-type="attributes">
							{foreach $choices.attributes_options as $choice_id => $choice_label}
								<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
									{$choice_label|escape:'htmlall':'UTF-8'}
								</option>
							{/foreach}
						</optgroup>
					</select>
				</div>
				<div class="col-lg-3 col-md-6">
					<label>{l s='Operator' mod='configurator'}</label>
					<select class="select_operator">
						{foreach $choices.selectors_options as $choice_id => $choice_label}
							<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
								{$choice_label|escape:'htmlall':'UTF-8'}
							</option>
						{/foreach}
					</select>
				</div>
				<div class="col-lg-3 col-md-6">
					<label>{l s='Step' mod='configurator'}</label>
					<select class="select_target_step">
						{foreach $choices.steps_options as $choice_id => $choice}
							<option value="{$choice->id|escape:'htmlall':'UTF-8'}"
									data-step-type="{$choice->type|escape:'htmlall':'UTF-8'}"
							>
								{$choice->name|escape:'htmlall':'UTF-8'}
							</option>
						{/foreach}
					</select>
				</div>
			</div>
			<div class="form-group">
				<div class="col-lg-1">

				</div>
				<div class="col-lg-3 col-md-6">
					<label>{l s='Type' mod='configurator'}</label>
					<select class="select_target_type">
						{foreach $choices.filters_options as $choice_id => $choice_label}
							<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
								{$choice_label|escape:'htmlall':'UTF-8'}
							</option>
						{/foreach}
					</select>
				</div>
				<div class="col-lg-3 col-md-6">
					<label>{l s='Option' mod='configurator'}</label>
					<select class="select_target_option">
						<optgroup label="{$choices.filters_options.features}" data-type="features">
							{foreach $choices.features_options as $choice_id => $choice_label}
								<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
									{$choice_label|escape:'htmlall':'UTF-8'}
								</option>
							{/foreach}
						</optgroup>
						<optgroup label="{$choices.filters_options.attributes}" data-type="attributes">
							{foreach $choices.attributes_options as $choice_id => $choice_label}
								<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
									{$choice_label|escape:'htmlall':'UTF-8'}
								</option>
							{/foreach}
						</optgroup>
					</select>
				</div>
				<div class="col-lg-4 col-md-12">
					<label>{l s='Value' mod='configurator'}</label>
					<select class="select_value">
						{foreach $choices.value_option as $choice_id => $choice_label}
							<option value="{$choice_id|escape:'htmlall':'UTF-8'}">
								{$choice_label|escape:'htmlall':'UTF-8'}
							</option>
						{/foreach}
					</select>
				</div>
				<div class="col-lg-10 col-md-12" style="display:none;">
					<label>{l s='Formula' mod='configurator'}</label>
					<input id="filter_formula" class="formula_editor" type="hidden">
				</div>
			</div>

			<div class="form-group">
				<div class="col-lg-2 col-lg-offset-5">
					<a class='add_filter btn btn-default' href="#">
						<i class="icon-plus-sign"></i> {l s='Add' mod='configurator'}
					</a>
				</div>
			</div>
		</div>

	</div>
{/if}

<script type="text/javascript">
    (function($) {
        $(function() {
			{if isset($values)}
            filtersHandler.renderFilters('#filters_block_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}', '{$values}'); {* $values is JSON data, no escape necessary *}
			{/if}
        });
    })(jQuery);
</script>
