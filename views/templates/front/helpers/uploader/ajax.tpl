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

<div class="form-group" style="display: none;">
    <div id="{$id|escape:'html':'UTF-8'}-images-thumbnails">
        {if isset($files) && $files|count > 0}
            {foreach $files as $file}
                {if isset($file.link)}
                    <div class="configurator-upload-row">
                        {*if isset($file.size)}<p>{l s='File size' mod='configurator'} {$file.size|floatval}kb</p>{/if*}
                        <a class="btn btn-link" href="{$file.link|escape:'html':'UTF-8'}"><i class="icon-download"></i> {$file.name|escape:'html':'UTF-8'}</a>
                        {if isset($file.delete_url)}
                            <a class="btn btn-default btn-sm configurator-delete-upload" href="{$file.delete_url}"> {* HTML CONTENT NO ESCAPE NEEDED HERE *}
                                <i class="icon-trash"></i> {l s='Delete' mod='configurator'}
                            </a>
                        {/if}
                    </div>
                {/if}
            {/foreach}
        {/if}
    </div>
</div>

{if isset($max_files) && $files|count >= $max_files && false}

<div class="row">
    <div class="alert alert-warning">{l s='You have reached the limit (%s) of files to upload.'|sprintf:$max_files mod='configurator'}</div>
</div>
<script type="text/javascript">
    $( document ).ready(function() {
        {if isset($files) && $files}
        $('#{$id|escape:'html':'UTF-8'}-images-thumbnails').parent().show();
        {/if}
    });
</script>

{else}

<div class="form-group">
    {if !$use_upload_camera}
        <input id="{$id|escape:'html':'UTF-8'}" type="file" name="{$name|escape:'html':'UTF-8'}[]" {if isset($multiple) && $multiple} multiple="multiple"{/if} />
    {else}

        <div>
            <ul class="nav nav-tabs nav-justified" role="tablist">
                <li role="presentation" class="active">
                    <a href="#home" aria-controls="home" role="tab" data-toggle="tab">
                        <i class="icon icon-file"></i> {l s='File' mod='configurator'}
                    </a>
                </li>
                <li role="presentation">
                    <a href="#profile" aria-controls="profile" role="tab" data-toggle="tab" class="uploader-webcam-active-btn">
                        <i class="icon icon-camera"></i> {l s="Webcam" mod="configurator"}
                    </a>
                </li>
            </ul>
            <div class="tab-content">
                <div role="tabpanel" class="tab-pane active" id="home">
                    <input id="{$id|escape:'html':'UTF-8'}" type="file" name="{$name|escape:'html':'UTF-8'}[]" {if isset($multiple) && $multiple} multiple="multiple"{/if} />
                </div>
                <div role="tabpanel" class="tab-pane uploader-webcam-block preview-off" id="profile">
                    <div class="uplaoder-webcam-actions">
                        <button class="uploader-webcam-picture-btn btn">
                            <i class="icon icon-camera"></i>
                        </button>
                        <button class="uploader-webcam-cancel-btn btn btn-danger">
                            <i class="icon icon-times"></i>
                        </button>
                        <button class="uploader-webcam-accept-btn btn btn-success">
                            <i class="icon icon-check"></i>
                        </button>
                    </div>
                    <video class="uploader-webcam-video" autoplay width="100%"></video>
                </div>
            </div>
        </div>

    {/if}
</div>

<div class="well" style="display:none">
    <div id="{$id|escape:'html':'UTF-8'}-files-list"></div>
    <button class="ladda-button btn btn-primary btn-upload-button" data-style="expand-right" type="button" id="{$id|escape:'html':'UTF-8'}-upload-button" style="display:none;">
		<span class="ladda-label">
            <i class="icon-check"></i> {if isset($multiple) && $multiple}{l s='Upload files' mod='configurator'}{else}{l s='Upload file' mod='configurator'}{/if}
        </span>
        <div class="spinner-in-progress">{l s='Upload in progess' mod='configurator'}</div>
        <div class="spinner">
            <div class="rect1"></div>
            <div class="rect2"></div>
            <div class="rect3"></div>
            <div class="rect4"></div>
            <div class="rect5"></div>
        </div>
    </button>
</div>
<div class="row" style="display:none">
    <div class="alert alert-success" id="{$id|escape:'html':'UTF-8'}-success"></div>
</div>
<div class="row" style="display:none">
    <div class="alert alert-danger" id="{$id|escape:'html':'UTF-8'}-errors"></div>
</div>

<script type="text/javascript">

    if(typeof configurator_uploader === "undefined") {
        var configurator_uploader = [];
    }

    configurator_uploader.push({
        id: "{$id|escape:'html':'UTF-8'}",
        multiple: {(isset($multiple) && $multiple) ? 1 : 0},
        max_files: {$max_files|escape:'html':'UTF-8'},
        files_counter: {$files|count},
        is_files: {(isset($files) && $files) ? 1 : 0},
        url: {if isset($url)}"{$url|escape:'html':'UTF-8'}"{else}false{/if},
        maxFileSize: {if isset($post_max_size)}{$post_max_size}{else}false{/if},
        dropZone: {if isset($drop_zone)}"{$drop_zone}"{else}false{/if},
        name: "{$name|escape:'html':'UTF-8'}",
        labels: {
            delete: "{l s='Delete' mod='configurator'}",
            remove_file: "{l s='Remove file' mod='configurator'}",
            fileuploadadd_alert: "{l s='You cannot have more than' mod='configurator'} {$max_files} {l s='files in total. Please remove some of the current files before adding new ones.' mod='configurator'}",
            webcam_picture: "{l s='webcam_picture_' mod='configurator'}",
        },
        show_upload_image: "{$show_upload_image}",
        use_upload_camera: {if $use_upload_camera}true{else}false{/if},
        display_progress: {if $display_progress}true{else}false{/if}
    });

</script>
{/if}
