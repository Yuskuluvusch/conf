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
{if empty($conditions_choices)}
    <div class="alert alert-warning">
        {l s='You must save this step before configuring display conditions.' mod='configurator'}
    </div>
{elseif empty($choices.block_option.groups)}
    <div class="alert alert-warning">
        {l s='You can\'t configure display conditions on the first step.' mod='configurator'}
    </div>
{else}
	<div id="conditions_block_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}"
		 class="conditions_block conditions_{$type|escape:'html':'UTF-8'}_block"
		 data-type="{$type|escape:'htmlall':'UTF-8'}"
		 data-id="{$id|escape:'htmlall':'UTF-8'}"
	>
		<div id="conditions_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}">
            <div id="condition_group_list_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}"
				 class="condition_group_list"
			></div>
		</div>

		<a class="btn btn-default add_condition_group" href="#">
            <i class="icon-plus-sign"></i> {l s='Add a new condition group' mod='configurator'}
		</a>
		<div class="clearfix">&nbsp;</div>

		<div class="panel conditions-panel"
			 id="conditions-panel_{$type|escape:'htmlall':'UTF-8'}_{$id|escape:'htmlall':'UTF-8'}"
			 class="conditions-panel"
			 style="display:none;"
		>
			<h3><i class="icon-tasks"></i> {l s='Conditions' mod='configurator'}</h3>

			{foreach $choices as $block}
				<div class="form-group">
					<label class="control-label col-lg-2">{$block.name|escape:'htmlall':'UTF-8'}</label>
					<div class="col-lg-9">
					    <div class="col-lg-12">
							{foreach $block.groups as $group}
								<div class="{$group.class|escape:'htmlall':'UTF-8'}" >
									{if $group.type === 'select'}
										{foreach $group.selects as $select}
											<select
												{foreach $select.params as $attr => $value} {$attr|cat:"="|cat:$value|escape:'htmlall':'UTF-8'}{/foreach}
											>
												{foreach $select.options as $value => $option}
													<option value="{$value|escape:'htmlall':'UTF-8'}"
														{foreach $option.attrs as $attr => $value} {$attr|cat:"="|cat:$value|escape:'htmlall':'UTF-8'}{/foreach}
													>
														{$option.option|escape:'htmlall':'UTF-8'}
													</option>
												{/foreach}
											</select>
										{/foreach}
									{else}
										<textarea class="formula_editor condition_step_formula"></textarea>
									{/if}
								</div>
							{/foreach}

							<div class="col-lg-2">
								<a class='add_condition btn btn-default' href="#">
                                	<i class="icon-plus-sign"></i> {l s='Add the condition' mod='configurator'}
								</a>
							</div>
					    </div>

					    <div class="col-lg-12">
							{foreach $block.groups as $group}
								{if $group.type === 'select'}
									{foreach $group.selects as $select}
										{foreach $select.options as $value => $option}
											{foreach $option.attrs as $attr => $valueattr}
												{if ($attr == "data-pricelist" && $valueattr == 1) || $option.object->use_qty}
													<div class="div_min_max" data-parentid="{$value|intval}">
														<div class="col-lg-12">
															<p class="help-block">
																{l s='(Optional) In the case of a price list, you can define display of item based on values entered by the customer.' mod='configurator'}
															</p>
														</div>

														<div class="col-lg-12">
															<div class="{$group.class|escape:'html':'UTF-8'}" >
																<div class="input-group">
																	<span class="input-group-addon">{l s='Min' mod='configurator'}</span>
																	<input type="text" name="min" value="" class="min"/>
																	<span class="input-group-addon">{$option.attrs.data_suffix|escape:'html':'UTF-8'}</span>
																</div>
															</div>

															<div class="{$group.class|escape:'html':'UTF-8'}" >
																<div class="input-group">
																	<span class="input-group-addon">{l s='Max' mod='configurator'}</span>
																	<input type="text" name="max" value="" class="max"/>
																	<span class="input-group-addon"> {$option.attrs.data_suffix|escape:'html':'UTF-8'}</span>
																</div>
															</div>
														</div>
													</div>
													{break}
												{/if}
											{/foreach}
										{/foreach}
									{/foreach}
						    	{/if}
							{/foreach}
					    </div>
					</div>
				</div>
			{/foreach}
		</div>
	</div>
{/if}

<script type="text/javascript">
	(function($) {
		$(function() {
			{if isset($values)}
				displayConditionsHandler.renderConditions('#conditions_block_{$type|escape:'html':'UTF-8'}_{$id|escape:'html':'UTF-8'}', '{$values}'); {* $values is JSON data, no escape necessary *}
			{/if}
		});
	})(jQuery);
</script>
