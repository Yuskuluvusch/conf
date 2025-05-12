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

<div class="row" id="start_products">
    <div class="col-lg-12">
        <div class="panel">
            <div class="panel-heading">
                <i class="icon-file"></i>
                {l s='Attachments' mod='configurator'}
            </div>
            <div class="table-responsive">
                <table class="table" id="orderProducts">
                    <thead>
                        <tr>
                            <th><span class="title_box ">{l s='Product' mod='configurator'}</span></th>
                            <th><span class="title_box ">{l s='Attachments' mod='configurator'}</span></th>
                        </tr>
                    </thead>
                    <tbody>
                        {foreach $attachements_by_cartdetails as $attachements_by_cartdetail}
                            <tr>
                                <td>{$products[$attachements_by_cartdetail.cart_detail->id_order_detail].product_name}</td>
                                <td>
                                    {foreach $attachements_by_cartdetail.attachments as $key => $attachment}
                                        {if $key > 0}<br>{/if}
                                        <a href="{$attachment_link}{$attachment.token}">{$attachment.file_name}</a>
                                    {/foreach}
                                </td>
                            </tr>
                        {/foreach}
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
