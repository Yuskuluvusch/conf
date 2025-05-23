{*
* 2007-2019 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2019 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{include file="$tpl_dir./errors.tpl"}
{if !isset($priceDisplayPrecision)}
	{assign var='priceDisplayPrecision' value=2}
{/if}
{if !$priceDisplay || $priceDisplay == 2}
	{assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
	{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL, $priceDisplayPrecision)}
{elseif $priceDisplay == 1}
	{assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
	{assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL, $priceDisplayPrecision)}
{/if}
<div itemscope itemtype="http://schema.org/Product">
	<div class="row">
		{if !$content_only}
			<div class="container">
				<div class="top-hr"></div>
				<h1>{$product->name|escape:'html':'UTF-8'}</h1>
			</div>
		{/if}
		{if isset($confirmation) && $confirmation}
			<p class="confirmation">
				{$confirmation}{* HTML comment, no escape necessary *}
			</p>
		{/if}
		<div class="primary_block col-xs-12 col-sm-3">
			{if isset($adminActionDisplay) && $adminActionDisplay}
				<div id="admin-action">
					<p>{l s='This product is not visible to your customers.' mod='configurator'}
						<input type="hidden" id="admin-action-product-id" value="{$product->id|escape:'htmlall':'UTF-8'}" />
						<input type="submit" value="{l s='Publish' mod='configurator'}" name="publish_button" class="exclusive" />
						<input type="submit" value="{l s='Back' mod='configurator'}" name="lnk_view" class="exclusive" />
					</p>
					<p id="admin-action-result"></p>
				</div>
			{/if}
			<!-- left infos-->
			<div class="pb-left-column">

				{if $use_custom_left_column}
					<section class="configurator-custom-left-column" data-configurator-view="2d">
						{$HOOK_CONFIGURATOR_DISPLAY_FRONT_PRODUCT_LEFT_COLUMN}
						<div class="configurator-product-cover">
				{/if}

				<!-- product img-->
				<div id="image-block" class="clearfix">
					{if $product->new}
						<span class="new-box">
							<span class="new-label">{l s='New' mod='configurator'}</span>
						</span>
					{/if}
					{if $product->on_sale}
						<span class="sale-box no-print">
							<span class="sale-label">{l s='Sale!' mod='configurator'}</span>
						</span>
					{elseif $product->specificPrice && $product->specificPrice.reduction && $productPriceWithoutReduction > $productPrice}
						<span class="discount">{l s='Reduced price!' mod='configurator'}</span>
					{/if}
					{if $have_image}
						<span id="view_full_size">
							{if $jqZoomEnabled && $have_image && !$content_only}
								<a class="jqzoom" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" rel="gal1" href="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'thickbox_default')|escape:'html':'UTF-8'}" itemprop="url">
									<img itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}"/>
								</a>
							{else}
								<img id="bigpic" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" width="{$largeSize.width|escape:'htmlall':'UTF-8'}" height="{$largeSize.height|escape:'htmlall':'UTF-8'}"/>
								{if !$content_only}
									<span class="span_link no-print">{l s='View larger' mod='configurator'}</span>
								{/if}
							{/if}
						</span>
					{else}
						<span id="view_full_size">
							<img itemprop="image" src="{$img_prod_dir|escape:'htmlall':'UTF-8'}{$lang_iso|escape:'htmlall':'UTF-8'}-default-large_default.jpg" id="bigpic" alt="" title="{$product->name|escape:'html':'UTF-8'}" width="{$largeSize.width|escape:'htmlall':'UTF-8'}" height="{$largeSize.height|escape:'htmlall':'UTF-8'}"/>
							{if !$content_only}
								<span class="span_link">
									{l s='View larger' mod='configurator'}
								</span>
							{/if}
						</span>
					{/if}
				</div> <!-- end image-block -->
				{if isset($images) && count($images) > 0}
					<!-- thumbnails -->
					<div id="views_block" class="clearfix {if isset($images) && count($images) < 2}hidden{/if}">
						{if isset($images) && count($images) > 2}
							<span class="view_scroll_spacer">
								<a id="view_scroll_left" class="" title="{l s='Other views' mod='configurator'}" href="javascript:{ldelim}{rdelim}">
									{l s='Previous' mod='configurator'}
								</a>
							</span>
						{/if}
						<div id="thumbs_list">
							<ul id="thumbs_list_frame">
							{if isset($images)}
								{foreach from=$images item=image name=thumbnails}
									{assign var=imageIds value="`$product->id`-`$image.id_image`"}
									{if !empty($image.legend)}
										{assign var=imageTitle value=$image.legend|escape:'html':'UTF-8'}
									{else}
										{assign var=imageTitle value=$product->name|escape:'html':'UTF-8'}
									{/if}
									<li id="thumbnail_{$image.id_image|escape:'htmlall':'UTF-8'}"{if $smarty.foreach.thumbnails.last} class="last"{/if}>
										<a{if $jqZoomEnabled && $have_image && !$content_only} href="javascript:void(0);" rel="{literal}{{/literal}gallery: 'gal1', smallimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'large_default')|escape:'html':'UTF-8'}',largeimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}'{literal}}{/literal}"{else} href="{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}"	data-fancybox-group="other-views" class="fancybox{if $image.id_image == $cover.id_image} shown{/if}"{/if} title="{$imageTitle|escape:'htmlall':'UTF-8'}">
											<img class="img-responsive" id="thumb_{$image.id_image|escape:'htmlall':'UTF-8'}" src="{$link->getImageLink($product->link_rewrite, $imageIds, 'cart_default')|escape:'html':'UTF-8'}" alt="{$imageTitle|escape:'htmlall':'UTF-8'}" title="{$imageTitle|escape:'htmlall':'UTF-8'}" height="{$cartSize.height|escape:'htmlall':'UTF-8'}" width="{$cartSize.width|escape:'htmlall':'UTF-8'}" itemprop="image" />
										</a>
									</li>
								{/foreach}
							{/if}
							</ul>
						</div> <!-- end thumbs_list -->
						{if isset($images) && count($images) > 2}
							<a id="view_scroll_right" title="{l s='Other views' mod='configurator'}" href="javascript:{ldelim}{rdelim}">
								{l s='Next' mod='configurator'}
							</a>
						{/if}
					</div> <!-- end views-block -->
					<!-- end thumbnails -->
				{/if}
				{if isset($images) && count($images) > 1}
					<p class="resetimg clear no-print">
						<span id="wrapResetImages" style="display: none;">
							<a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" data-id="resetImages">
								<i class="icon-repeat"></i>
								{l s='Display all pictures' mod='configurator'}
							</a>
						</span>
					</p>
				{/if}

				{if $use_custom_left_column}
						</div>
					</section>
				{/if}
			</div> <!-- end pb-left-column -->
			<!-- end left infos-->
			<!-- center infos -->
			<div class="pb-center-column">
				{if $product->online_only}
					<p class="online_only">{l s='Online only' mod='configurator'}</p>
				{/if}
				<p id="product_reference"{if empty($product->reference) || !$product->reference} style="display: none;"{/if}>
					<label>{l s='Reference:' mod='configurator'} </label>
					<span class="editable" itemprop="sku">{if !isset($groups)}{$product->reference|escape:'html':'UTF-8'}{/if}</span>
				</p>
				{if !$product->is_virtual && $product->condition}
				<p id="product_condition">
					<label>{l s='Condition:' mod='configurator'} </label>
					{if $product->condition == 'new'}
						<link itemprop="itemCondition" href="http://schema.org/NewCondition"/>
						<span class="editable">{l s='New product' mod='configurator'}</span>
					{elseif $product->condition == 'used'}
						<link itemprop="itemCondition" href="http://schema.org/UsedCondition"/>
						<span class="editable">{l s='Used' mod='configurator'}</span>
					{elseif $product->condition == 'refurbished'}
						<link itemprop="itemCondition" href="http://schema.org/RefurbishedCondition"/>
						<span class="editable">{l s='Refurbished' mod='configurator'}</span>
					{/if}
				</p>
				{/if}
				{if $product->description_short || $packItems|@count > 0}
					<div id="short_description_block">
						{if $product->description_short}
							<div id="short_description_content" class="rte align_justify" itemprop="description">{$product->description_short}{* HTML comment, no escape necessary *}</div>
						{/if}

						{if $product->description}
							<p class="buttons_bottom_block">
								<a href="javascript:{ldelim}{rdelim}" class="button">
									{l s='More details' mod='configurator'}
								</a>
							</p>
						{/if}
					</div> <!-- end short_description_block -->
				{/if}
				{if ($display_qties == 1 && !$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && $product->available_for_order)}
					<!-- number of item in stock -->
					<p id="pQuantityAvailable"{if $product->quantity <= 0} style="display: none;"{/if}>
						<span id="quantityAvailable">{$product->quantity|intval}</span>
						<span {if $product->quantity > 1} style="display: none;"{/if} id="quantityAvailableTxt">{l s='Item' mod='configurator'}</span>
						<span {if $product->quantity == 1} style="display: none;"{/if} id="quantityAvailableTxtMultiple">{l s='Items' mod='configurator'}</span>
					</p>
				{/if}
				<!-- availability or doesntExist -->
				{*<p id="availability_statut"{if !$PS_STOCK_MANAGEMENT || ($product->quantity <= 0 && !$product->available_later && $allow_oosp) || ($product->quantity > 0 && !$product->available_now) || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
					<span id="availability_value" class="label{if $product->quantity <= 0 && !$allow_oosp} label-danger{elseif $product->quantity <= 0} label-warning{else} label-success{/if}">{if $product->quantity <= 0}{if $PS_STOCK_MANAGEMENT && $allow_oosp}{$product->available_later}{else}{l s='This product is no longer in stock' mod='configurator'}{/if}{elseif $PS_STOCK_MANAGEMENT}{$product->available_now}{/if}</span>
				</p>*}
				{if $PS_STOCK_MANAGEMENT}
					{hook h="displayProductDeliveryTime" product=$product}
					<p class="warning_inline" id="last_quantities"{if ($product->quantity > $last_qties || $product->quantity <= 0) || $allow_oosp || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none"{/if} >{l s='Warning: Last items in stock!' mod='configurator'}</p>
				{/if}
				<p id="availability_date"{if ($product->quantity > 0) || !$product->available_for_order || $PS_CATALOG_MODE || !isset($product->available_date) || $product->available_date < $smarty.now|date_format:'%Y-%m-%d'} style="display: none;"{/if}>
					<span id="availability_date_label">{l s='Availability date:' mod='configurator'}</span>
					<span id="availability_date_value">{dateFormat date=$product->available_date full=false}</span>
				</p>
				<!-- Out of stock hook -->
				<div id="oosHook"{if $product->quantity > 0} style="display: none;"{/if}>
					{$HOOK_PRODUCT_OOS}{* HTML comment, no escape necessary *}
				</div>
				{if isset($HOOK_EXTRA_RIGHT) && $HOOK_EXTRA_RIGHT}{$HOOK_EXTRA_RIGHT}{/if}{* HTML comment, no escape necessary *}
				{if !$content_only}
					<!-- usefull links-->
					<ul id="usefull_link_block" class="clearfix no-print">
						{if $HOOK_EXTRA_LEFT}{$HOOK_EXTRA_LEFT}{/if}{* HTML comment, no escape necessary *}
						<li class="print">
							<a href="javascript:print();">
								{l s='Print' mod='configurator'}
							</a>
						</li>
						{if $have_image && !$jqZoomEnabled}{/if}
					</ul>
				{/if}
			</div>
			<!-- end center infos-->
		</div> <!-- end primary_block -->
		<!-- CONFIGURATOR -->
        {$configuratorHtml nofilter}{* HTML comment, no escape necessary *}
		<!-- END CONFIGURATOR -->
	</div>
	{if !$content_only}
		{if (isset($quantity_discounts) && count($quantity_discounts) > 0)}
			<!-- quantity discount -->
			<section class="page-product-box">
				<h3 class="page-product-heading">{l s='Volume discounts' mod='configurator'}</h3>
				<div id="quantityDiscount">
					<table class="std table-product-discounts">
						<thead>
							<tr>
								<th>{l s='Quantity' mod='configurator'}</th>
								<th>{if $display_discount_price}{l s='Price' mod='configurator'}{else}{l s='Discount' mod='configurator'}{/if}</th>
								<th>{l s='You Save' mod='configurator'}</th>
							</tr>
						</thead>
						<tbody>
							{foreach from=$quantity_discounts item='quantity_discount' name='quantity_discounts'}
							<tr id="quantityDiscount_{$quantity_discount.id_product_attribute|escape:'htmlall':'UTF-8'}" class="quantityDiscount_{$quantity_discount.id_product_attribute|escape:'htmlall':'UTF-8'}" data-discount-type="{$quantity_discount.reduction_type|escape:'htmlall':'UTF-8'}" data-discount="{$quantity_discount.real_value|floatval|escape:'htmlall':'UTF-8'}" data-discount-quantity="{$quantity_discount.quantity|intval|escape:'htmlall':'UTF-8'}">
								<td>
									{$quantity_discount.quantity|intval}
								</td>
								<td>
									{if $quantity_discount.price >= 0 || $quantity_discount.reduction_type == 'amount'}
										{if $display_discount_price}
											{convertPrice price=$productPrice-$quantity_discount.real_value|floatval}
										{else}
											{convertPrice price=$quantity_discount.real_value|floatval}
										{/if}
									{else}
										{if $display_discount_price}
											{convertPrice price = $productPrice-($productPrice*$quantity_discount.reduction)|floatval}
										{else}
											{$quantity_discount.real_value|floatval}%
										{/if}
									{/if}
								</td>
								<td>
									<span>{l s='Up to' mod='configurator'}</span>
									{if $quantity_discount.price >= 0 || $quantity_discount.reduction_type == 'amount'}
										{$discountPrice=$productPrice-$quantity_discount.real_value|floatval}
									{else}
										{$discountPrice=$productPrice-($productPrice*$quantity_discount.reduction)|floatval}
									{/if}
									{$discountPrice=$discountPrice*$quantity_discount.quantity}
									{$qtyProductPrice = $productPrice*$quantity_discount.quantity}
									{convertPrice price=$qtyProductPrice-$discountPrice}
								</td>
							</tr>
							{/foreach}
						</tbody>
					</table>
				</div>
			</section>
		{/if}
		{if isset($features) && $features}
			<!-- Data sheet -->
			<section class="page-product-box">
				<h3 class="page-product-heading">{l s='Data sheet' mod='configurator'}</h3>
				<table class="table-data-sheet">
					{foreach from=$features item=feature}
					<tr class="{cycle values="odd,even"}">
						{if isset($feature.value)}
						<td>{$feature.name|escape:'html':'UTF-8'}</td>
						<td>{$feature.value|escape:'html':'UTF-8'}</td>
						{/if}
					</tr>
					{/foreach}
				</table>
			</section>
			<!--end Data sheet -->
		{/if}
		{if $product->description}
			<!-- More info -->
			<section class="page-product-box">
				<h3 class="page-product-heading">{l s='More info' mod='configurator'}</h3>
				<!-- full description -->
				<div  class="rte">{$product->description}</div>{* HTML comment, no escape necessary *}
			</section>
			<!--end  More info -->
		{/if}
		{if isset($packItems) && $packItems|@count > 0}
		<section id="blockpack">
			<h3 class="page-product-heading">{l s='Pack content' mod='configurator'}</h3>
			{include file="$tpl_dir./product-list.tpl" products=$packItems}
		</section>
		{/if}
		<!--HOOK_PRODUCT_TAB -->
		<section class="page-product-box">
			{$HOOK_PRODUCT_TAB}{* HTML comment, no escape necessary *}
			{if isset($HOOK_PRODUCT_TAB_CONTENT) && $HOOK_PRODUCT_TAB_CONTENT}{$HOOK_PRODUCT_TAB_CONTENT}{/if}{* HTML comment, no escape necessary *}
		</section>
		<!--end HOOK_PRODUCT_TAB -->
		{if isset($accessories) && $accessories}
			<!--Accessories -->
			<section class="page-product-box">
				<h3 class="page-product-heading">{l s='Accessories' mod='configurator'}</h3>
				<div class="block products_block accessories-block clearfix">
					<div class="block_content">
						<ul id="bxslider" class="bxslider clearfix">
							{foreach from=$accessories item=accessory name=accessories_list}
								{if ($accessory.allow_oosp || $accessory.quantity_all_versions > 0 || $accessory.quantity > 0) && $accessory.available_for_order && !isset($restricted_country_mode)}
									{assign var='accessoryLink' value=$link->getProductLink($accessory.id_product, $accessory.link_rewrite, $accessory.category)}
									<li class="item product-box ajax_block_product{if $smarty.foreach.accessories_list.first} first_item{elseif $smarty.foreach.accessories_list.last} last_item{else} item{/if} product_accessories_description">
										<div class="product_desc">
											<a href="{$accessoryLink|escape:'html':'UTF-8'}" title="{$accessory.legend|escape:'html':'UTF-8'}" class="product-image product_image">
												<img class="lazyOwl" src="{$link->getImageLink($accessory.link_rewrite, $accessory.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{$accessory.legend|escape:'html':'UTF-8'}" width="{$homeSize.width|escape:'htmlall':'UTF-8'}" height="{$homeSize.height|escape:'htmlall':'UTF-8'}"/>
											</a>
											<div class="block_description">
												<a href="{$accessoryLink|escape:'html':'UTF-8'}" title="{l s='More' mod='configurator'}" class="product_description">
													{$accessory.description_short|strip_tags|truncate:25:'...'}{* HTML comment, no escape necessary *}
												</a>
											</div>
										</div>
										<div class="s_title_block">
											<h5 itemprop="name" class="product-name">
												<a href="{$accessoryLink|escape:'html':'UTF-8'}">
													{$accessory.name|truncate:20:'...':true|escape:'html':'UTF-8'}
												</a>
											</h5>
											{if $accessory.show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
											<span class="price">
												{if $priceDisplay != 1}
												{displayWtPrice p=$accessory.price}{else}{displayWtPrice p=$accessory.price_tax_exc}
												{/if}
											</span>
											{/if}
										</div>
										<div class="clearfix" style="margin-top:5px">
											{if !$PS_CATALOG_MODE && ($accessory.allow_oosp || $accessory.quantity > 0)}
												<div class="no-print">
													<a class="exclusive button ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, "qty=1&amp;id_product={$accessory.id_product|intval}&amp;token={$static_token}&amp;add")|escape:'html':'UTF-8'}" data-id-product="{$accessory.id_product|intval}" title="{l s='Add to cart' mod='configurator'}">
														<span>{l s='Add to cart' mod='configurator'}</span>
													</a>
												</div>
											{/if}
										</div>
									</li>
								{/if}
							{/foreach}
						</ul>
					</div>
				</div>
			</section>
			<!--end Accessories -->
		{/if}
		{if isset($HOOK_PRODUCT_FOOTER) && $HOOK_PRODUCT_FOOTER}{$HOOK_PRODUCT_FOOTER}{/if}{* HTML comment, no escape necessary *}
		<!-- description & features -->
		{if (isset($product) && $product->description) || (isset($features) && $features) || (isset($accessories) && $accessories) || (isset($HOOK_PRODUCT_TAB) && $HOOK_PRODUCT_TAB) || (isset($attachments) && $attachments) || isset($product) && $product->customizable}
			{if isset($attachments) && $attachments}
			<!--Download -->
			<section class="page-product-box">
				<h3 class="page-product-heading">{l s='Download' mod='configurator'}</h3>
				{foreach from=$attachments item=attachment name=attachements}
					{if $smarty.foreach.attachements.iteration %3 == 1}<div class="row">{/if}
						<div class="col-lg-4">
							<h4><a href="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attachment.id_attachment}")|escape:'html':'UTF-8'}">{$attachment.name|escape:'html':'UTF-8'}</a></h4>
							<p class="text-muted">{$attachment.description|escape:'html':'UTF-8'}</p>
							<a class="btn btn-default btn-block" href="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attachment.id_attachment}")|escape:'html':'UTF-8'}">
								<i class="icon-download"></i>
								{l s='Download' mod='configurator'} ({Tools::formatBytes($attachment.file_size, 2)|escape:'htmlall':'UTF-8'})
							</a>
							<hr />
						</div>
					{if $smarty.foreach.attachements.iteration %3 == 0 || $smarty.foreach.attachements.last}</div>{/if}
				{/foreach}
			</section>
			<!--end Download -->
			{/if}
			{if isset($product) && $product->customizable}
				{*
			<!--Customization -->
			<section class="page-product-box">
				<h3 class="page-product-heading">{l s='Product customization' mod='configurator'}</h3>
				<!-- Customizable products -->
				<form method="post" action="{$customizationFormTarget}" enctype="multipart/form-data" id="customizationForm" class="clearfix">
					<p class="infoCustomizable">
						{l s='After saving your customized product, remember to add it to your cart.' mod='configurator'}
						{if $product->uploadable_files}
						<br />
						{l s='Allowed file formats are: GIF, JPG, PNG'}{/if}
					</p>
					{if $product->uploadable_files|intval}
						<div class="customizableProductsFile">
							<h5 class="product-heading-h5">{l s='Pictures' mod='configurator'}</h5>
							<ul id="uploadable_files" class="clearfix">
								{counter start=0 assign='customizationField'}
								{foreach from=$customizationFields item='field' name='customizationFields'}
									{if $field.type == 0}
										<li class="customizationUploadLine{if $field.required} required{/if}">{assign var='key' value='pictures_'|cat:$product->id|cat:'_'|cat:$field.id_customization_field}
											{if isset($pictures.$key)}
												<div class="customizationUploadBrowse">
													<img src="{$pic_dir}{$pictures.$key}_small" alt="" />
														<a href="{$link->getProductDeletePictureLink($product, $field.id_customization_field)|escape:'html':'UTF-8'}" title="{l s='Delete' mod='configurator'}" >
															<img src="{$img_dir}icon/delete.gif" alt="{l s='Delete' mod='configurator'}" class="customization_delete_icon" width="11" height="13" />
														</a>
												</div>
											{/if}
											<div class="customizationUploadBrowse form-group">
												<label class="customizationUploadBrowseDescription">
													{if !empty($field.name)}
														{$field.name}
													{else}
														{l s='Please select an image file from your computer' mod='configurator'}
													{/if}
													{if $field.required}<sup>*</sup>{/if}
												</label>
												<input type="file" name="file{$field.id_customization_field}" id="img{$customizationField}" class="form-control customization_block_input {if isset($pictures.$key)}filled{/if}" />
											</div>
										</li>
										{counter}
									{/if}
								{/foreach}
							</ul>
						</div>
					{/if}
					{if $product->text_fields|intval}
						<div class="customizableProductsText">
							<h5 class="product-heading-h5">{l s='Text' mod='configurator'}</h5>
							<ul id="text_fields">
							{counter start=0 assign='customizationField'}
							{foreach from=$customizationFields item='field' name='customizationFields'}
								{if $field.type == 1}
									<li class="customizationUploadLine{if $field.required} required{/if}">
										<label for ="textField{$customizationField}">
											{assign var='key' value='textFields_'|cat:$product->id|cat:'_'|cat:$field.id_customization_field}
											{if !empty($field.name)}
												{$field.name}
											{/if}
											{if $field.required}<sup>*</sup>{/if}
										</label>
										<textarea name="textField{$field.id_customization_field}" class="form-control customization_block_input" id="textField{$customizationField}" rows="3" cols="20">{strip}
											{if isset($textFields.$key)}
												{$textFields.$key|stripslashes}
											{/if}
										{/strip}</textarea>
									</li>
									{counter}
								{/if}
							{/foreach}
							</ul>
						</div>
					{/if}
					<p id="customizedDatas">
						<input type="hidden" name="quantityBackup" id="quantityBackup" value="" />
						<input type="hidden" name="submitCustomizedDatas" value="1" />
						<button class="button btn btn-default button button-small" name="saveCustomization">
							<span>{l s='Save' mod='configurator'}</span>
						</button>
						<span id="ajax-loader" class="unvisible">
							<img src="{$img_ps_dir}loader.gif" alt="loader" />
						</span>
					</p>
				</form>
				<p class="clear required"><sup>*</sup> {l s='required fields' mod='configurator'}</p>
			</section>
			<!--end Customization -->
			*}
			{/if}
		{/if}
	{/if}
</div> <!-- itemscope product wrapper -->
{strip}
{if isset($configuratorCartDetail)}
        {addJsDef ERROR_LIST=$ERROR_LIST}
        {addJsDefL name='none'}{l s='None' mod='configurator' js=1}{/addJsDefL}  
	{addJsDefL name='total_price_i18n'}{l s='Final price:' mod='configurator' js=1}{/addJsDefL}
	{addJsDefL name='tax_i18n'}{if $priceDisplay == 1}{l s='tax excl.' mod='configurator' js=1}{else}{l s='tax incl.' mod='configurator' js=1}{/if}{/addJsDefL}
	{addJsDef detail=$configuratorCartDetail->getDetail(true)}
	{addJsDef image_format='large_default'}
	{addJsDef fancybox_image_format='thickbox_default'}
	{addJsDef progress_data=[
		'start' => 0,
		'end' => $configuratorCartDetail->progress,
		'start_color' => $PROGRESS_START_COLOR,
		'end_color' => $PROGRESS_END_COLOR
	]}
	{addJsDef progressive_display=$PROGRESSIVE_DISPLAY|intval}
        {addJsDef tooltip_display=$TOOLTIP_DISPLAY|intval}
	{addJsDef action=$link->getProductLink($product)|escape:'html':'UTF-8'}
{/if}
{if isset($smarty.get.ad) && $smarty.get.ad}
	{addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{if isset($smarty.get.adtoken) && $smarty.get.adtoken}
	{addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{addJsDef allowBuyWhenOutOfStock=$allow_oosp|boolval}
{addJsDef availableNowValue=$product->available_now|escape:'quotes':'UTF-8'}
{addJsDef availableLaterValue=$product->available_later|escape:'quotes':'UTF-8'}
{addJsDef attribute_anchor_separator=$attribute_anchor_separator|escape:'quotes':'UTF-8'}
{addJsDef attributesCombinations=$attributesCombinations}
{addJsDef currencySign=$currencySign} {* HTML comment, no escape necessary *}
{addJsDef currencyRate=$currencyRate|floatval}
{addJsDef currencyFormat=$currencyFormat|intval}
{addJsDef currencyBlank=$currencyBlank|intval}
{addJsDef currentDate=$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
{if isset($combinations) && $combinations}
	{addJsDef combinations=$combinations}
	{addJsDef combinationsFromController=$combinations}
	{addJsDef displayDiscountPrice=$display_discount_price}
	{addJsDefL name='upToTxt'}{l s='Up to' mod='configurator' js=1}{/addJsDefL}
{/if}
{if isset($combinationImages) && $combinationImages}
	{addJsDef combinationImages=$combinationImages}
{/if}
{addJsDef customizationFields=$customizationFields}
{addJsDef default_eco_tax=$product->ecotax|floatval}
{addJsDef displayPrice=$priceDisplay|intval}
{addJsDef ecotaxTax_rate=$ecotaxTax_rate|floatval}
{addJsDef group_reduction=$group_reduction}
{if isset($cover.id_image_only)}
	{addJsDef idDefaultImage=$cover.id_image_only|intval}
{else}
	{addJsDef idDefaultImage=0}
{/if}
{addJsDef img_ps_dir=$img_ps_dir}
{addJsDef img_prod_dir=$img_prod_dir}
{addJsDef id_product=$product->id|intval}
{addJsDef jqZoomEnabled=$jqZoomEnabled|boolval}
{addJsDef maxQuantityToAllowDisplayOfLastQuantityMessage=$last_qties|intval}
{addJsDef minimalQuantity=$product->minimal_quantity|intval}
{addJsDef noTaxForThisProduct=$no_tax|boolval}
{addJsDef customerGroupWithoutTax=$customer_group_without_tax|boolval}
{addJsDef oosHookJsCodeFunctions=Array()}
{addJsDef productHasAttributes=isset($groups)|boolval}
{addJsDef productPriceTaxExcluded=($product->getPriceWithoutReduct(true)|default:'null' - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcluded=($product->base_price - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcl=($product->base_price|floatval)}
{addJsDef productReference=$product->reference|escape:'html':'UTF-8'}
{addJsDef productAvailableForOrder=$product->available_for_order|boolval}
{addJsDef productPriceWithoutReduction=$productPriceWithoutReduction|floatval}
{addJsDef productPrice=$productPrice|floatval}
{addJsDef productUnitPriceRatio=$product->unit_price_ratio|floatval}
{addJsDef productShowPrice=(!$PS_CATALOG_MODE && $product->show_price)|boolval}
{addJsDef PS_CATALOG_MODE=$PS_CATALOG_MODE}
{if $product->specificPrice && $product->specificPrice|@count}
	{addJsDef product_specific_price=$product->specificPrice}
{else}
	{addJsDef product_specific_price=array()}
{/if}
{if $display_qties == 1 && $product->quantity}
	{addJsDef quantityAvailable=$product->quantity}
{else}
	{addJsDef quantityAvailable=0}
{/if}
{addJsDef quantitiesDisplayAllowed=$display_qties|boolval}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'percentage'}
	{addJsDef reduction_percent=$product->specificPrice.reduction*100|floatval}
{else}
	{addJsDef reduction_percent=0}
{/if}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'amount'}
	{addJsDef reduction_price=$product->specificPrice.reduction|floatval}
{else}
	{addJsDef reduction_price=0}
{/if}
{if $product->specificPrice && $product->specificPrice.price}
	{addJsDef specific_price=$product->specificPrice.price|floatval}
{else}
	{addJsDef specific_price=0}
{/if}
{addJsDef specific_currency=($product->specificPrice && $product->specificPrice.id_currency)|boolval} {* TODO: remove if always false *}
{addJsDef stock_management=$PS_STOCK_MANAGEMENT|intval}
{addJsDef taxRate=$tax_rate|floatval}
{addJsDefL name=doesntExist}{l s='This combination does not exist for this product. Please select another combination.' mod='configurator' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMore}{l s='This product is no longer in stock' mod='configurator' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMoreBut}{l s='with those attributes but is available with others.' mod='configurator' js=1}{/addJsDefL}
{addJsDefL name=fieldRequired}{l s='Please fill in all the required fields before saving your customization.' mod='configurator' js=1}{/addJsDefL}
{addJsDefL name=uploading_in_progress}{l s='Uploading in progress, please be patient.' mod='configurator' js=1}{/addJsDefL}
{addJsDefL name='product_fileDefaultHtml'}{l s='No file selected' mod='configurator' js=1}{/addJsDefL}
{addJsDefL name='product_fileButtonHtml'}{l s='Choose File' mod='configurator' js=1}{/addJsDefL}
{/strip}