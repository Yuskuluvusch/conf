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

{if isset($step)}
    {assign var="first_option" value=current($step->options)}
    {if $step->use_custom_template eq 1}
        {assign var='custom_tpl' value='../custom/'|cat:$step->custom_template}
        {include file=$custom_tpl step=$step}
    {elseif $step->price_list neq ''}
        {include file='./price_list.tpl' step=$step}
    {elseif $step->use_input}
        {include file='./input.tpl' step=$step}
    {elseif $step->option_group->is_color_group and ($first_option->option['color'] neq '' OR $img_color_exists)}
        {include file='./block.tpl' step=$step}
    {elseif !$step->multiple and $step->option_group->group_type eq 'select'}
        {include file='./select.tpl' step=$step}
    {else}
        {include file='./option.tpl' step=$step}
    {/if}
{/if}
