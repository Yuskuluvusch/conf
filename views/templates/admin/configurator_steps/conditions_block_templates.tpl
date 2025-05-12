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

{literal}
	<script id="tmpl_conditions_group" type="text/x-handlebars-template">
		{{#separator}}
		<div class="row condition_separator text-center"><strong>{/literal}{l s='OR' mod='configurator'}{literal}</strong></div>
		<div class="clearfix">&nbsp;</div>
		{{/separator}}
		<div data-id="{{id}}" class="panel condition_group">
		<div class="panel-heading">
                    <i class="icon-tasks"></i> {/literal}{l s='Conditions group' mod='configurator'}{literal} {{id}}
                    <a href="#" class="btn-negative_condition" data-id="{{id}}">
                        {{#if negative_condition}}
                            <i class="icon-remove action-disabled list-action-enable"></i>
                        {{else}}
                            <i class="icon-check action-enabled list-action-enable"></i>
                        {{/if}}
                    </a>
                </div>
		<table class="table">
        <thead>
		<tr>
		<th class="fixed-width-md">
		<span class="title_box">{/literal}{l s='Step' mod='configurator'}{literal}</span>
		</th>
		<th>
		<span class="title_box">{/literal}{l s='Option' mod='configurator'}{literal}</span>
		</th>
		<th></th>
		<th></th>
		</tr>
        </thead>
        <tbody></tbody>
		</table>
		</div>
	</script>

	<script id="tmpl_conditions_row" type="text/x-handlebars-template">
		{{#separator}}
		<tr><td colspan="4" class="text-center"><b>{/literal}{l s='AND' mod='configurator'}{literal}</b></td></tr>
		{{/separator}}
		<tr class="condition_row" data-id="{{id}}" data-min="{{min}}" data-max="{{max}}" data-formula="{{formula}}">
			<td>{{step}}</td>
			<td>{{option}}</td>
			<td>{{formula}}</td>
			<td>
				<a class="btn btn-default delete_condition" href="#">
					<i class="icon-remove"></i> {/literal}{l s='Delete' mod='configurator'}{literal}
				</a>
			</td>
		</tr>
	</script>
{/literal}
