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
<script id="tmpl_impact_value_period_group" type="text/x-handlebars-template">
	<div data-id="{{id}}" class="panel impact_value_period_group">
		<div class="panel-heading">
			<i class="icon-tasks"></i> {/literal}{l s='Your specific periods' mod='configurator'}{literal}
		</div>
		<table class="table">
			<thead>
			<tr>
				<th class="fixed-width-md">
					<span class="title_box">{/literal}{l s='From' mod='configurator'}{literal}</span>
				</th>
				<th class="fixed-width-md">
					<span class="title_box">{/literal}{l s='To' mod='configurator'}{literal}</span>
				</th>
				<th class="fixed-width-md">
					<span class="title_box">{/literal}{l s='Value' mod='configurator'}{literal}</span>
				</th>
				<th></th>
			</tr>
			</thead>
			<tbody></tbody>
		</table>
	</div>
</script>

<script id="tmpl_impact_value_period_row" type="text/x-handlebars-template">
	<tr class="impact_value_period_row" data-id="{{id}}" data-values="{{values_json}}">
		<td>{{values.date_start}}</td>
		<td>{{values.date_end}}</td>
		<td>{{values.specific_value}} {/literal}{Context::getContext()->currency->sign}{literal}</td>
		<td>
			<a class="btn btn-default delete_impact_value_period" href="#">
				<i class="icon-remove"></i> {/literal}{l s='Delete' mod='configurator'}{literal}
			</a>
		</td>
	</tr>
</script>
{/literal}
