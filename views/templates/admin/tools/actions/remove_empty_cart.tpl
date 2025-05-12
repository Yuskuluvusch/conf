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

<html>
    <head>
        <link rel="stylesheet" href="../modules/configurator/views/css/bootstrap.min.css" >
    </head>
    <body>
        
        {if $end}
            <h3 class="text-center">{l s='Deleting ...' mod='configurator'} 100% <small>{{$counters.current}} / {{$counters.total}} {l s='empty cart(s)' mod='configurator'}</small></h3>
            <div class="progress">
                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="100" aria-valuemin="0" aria-valuemax="100" style="width: 100%">
                  <span class="sr-only">100% Complete (success)</span>
                </div>
            </div>
        {elseif $run}
            <h3 class="text-center">{l s='Deleting ...' mod='configurator'} {{$progress}}% <small>{{$counters.current}} / {{$counters.total}} {l s='empty cart(s)' mod='configurator'}</small></h3>
            <div class="progress">
                <div class="progress-bar progress-bar-warning progress-bar-striped" role="progressbar" aria-valuenow="{{$progress}}" aria-valuemin="0" aria-valuemax="100" style="width: {{$progress}}%">
                  <span class="sr-only">{{$progress}}% Complete (success)</span>
                </div>
            </div>
        {else}
            <div class="alert alert-warning">
                {l s='You have %s empty cart(s) to delete.' mod='configurator' sprintf=$counters.total}<br>
                <a href="{{$run_remove_empty_cart_link}}" class="btn btn-warning">
                    <i class="icon-trash"></i>
                    {l s='Delete' mod='configurator'}
                </a>
            </div>
        {/if}

        {if $run && !$end}
            <script>
                location.href = "{{$run_remove_empty_cart_link}}";
            </script>
        {/if}

    </body>
</html>
