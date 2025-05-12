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

<div id="price_impact_period_block_{$id|escape:'htmlall':'UTF-8'}"
	 class="price_impact_period_block"
	 data-id="{$id|escape:'htmlall':'UTF-8'}"
>
	<hr>

	<!-- TABLE -->
	<div id="price_impact_period_{$id|escape:'htmlall':'UTF-8'}">
		<div id="price_impact_period_group_list_{$id|escape:'htmlall':'UTF-8'}"
			 class="price_impact_period_group_list"
		></div>
	</div>

	<!-- ADD -->
	<div class="panel price_impact_period_panel"
		 id="price_impact_period_panel"
		 class="price_impact_period_panel"
	>
		<h3><i class="icon-tasks"></i> {l s='Add a specific period' mod='configurator'}</h3>

		<div class="row">
			<div class="col-lg-6">
				<div class="form-group">
					<div class="input-group">
						<span class="input-group-addon">{l s='From' mod='configurator'}</span>
						<input type="text"
							   class="datepicker"
							   id="price_impact_period_start"
							   readonly
						>
						<span class="input-group-addon"><i class="icon-calendar-empty"></i></span>
					</div>
				</div>
			</div>
			<div class="col-lg-6">
				<div class="form-group">
					<div class="input-group">
						<span class="input-group-addon">{l s='To' mod='configurator'}</span>
						<input type="text"
							   class="datepicker"
							   id="price_impact_period_end"
							   readonly
						>
						<span class="input-group-addon"><i class="icon-calendar-empty"></i></span>
					</div>
				</div>
			</div>
		</div>
		<div class="form-group">
			<div class="input-group">
                <span class="input-group-addon">
                    <span class="devise">
                        {$currency->sign|escape:'htmlall':'UTF-8'}
                    </span>
                </span>
				<input id="input_impact_value_period"
					   type="text"
					   class="form-control input_impact_value_period"
					   value="0"
					   onchange="this.value = this.value.replace(/,/g, '.');"
				>
			</div>
		</div>
		<a class='add_price_impact_period btn btn-default' href="#">
			<i class="icon-plus-sign"></i> {l s='Add' mod='configurator'}
		</a>

	</div>

	<input id="impact_value_period_values"
		   name="impact_value_period"
		   type="hidden"
		   value="{$value|escape:'htmlall':'UTF-8'}"
	>
</div>

<script type="text/javascript">
    (function($) {
        $(function() {

            impactValuePeriodHandler.init();
            impactValuePeriodHandler.renderPeriods('#price_impact_period_block_{$id|escape:'htmlall':'UTF-8'}', '{$option->impact_value_period}'); {* $values is JSON data, no escape necessary *}

            $(".price_impact_period_block .datepicker").datepicker({
                prevText: '',
                nextText: '',
                dateFormat: 'yy-mm-dd'
            });

            $(".price_impact_period_block .datepicker + span").click(function() {
                $(this).parent().find('.datepicker').focus();
            });

        });
    })(jQuery);
</script>
