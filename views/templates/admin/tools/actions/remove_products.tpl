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
            <h3 class="text-center">{l s='Deleting ...' mod='configurator'} {{$progress}}% <small>{{$counters.current}} / {{$counters.total}} {l s='product(s)' mod='configurator'}</small></h3>
            <div class="progress">
                <div class="progress-bar progress-bar-success progress-bar-striped" role="progressbar" aria-valuenow="{{$progress}}" aria-valuemin="0" aria-valuemax="100" style="width: {{$progress}}%">
                  <span class="sr-only">{{$progress}}% Complete (success)</span>
                </div>
            </div>
        {else if $run}
            <h3 class="text-center">{l s='Deleting ...' mod='configurator'} {{$progress}}% <small>{{$counters.current}} / {{$counters.total}} {l s='product(s)' mod='configurator'}</small></h3>
            <div class="progress">
                <div class="progress-bar progress-bar-warning progress-bar-striped" role="progressbar" aria-valuenow="{{$progress}}" aria-valuemin="0" aria-valuemax="100" style="width: {{$progress}}%">
                  <span class="sr-only">{{$progress}}% Complete (success)</span>
                </div>
            </div>
        {else}
            <div class="alert alert-warning">
                {l s='You have %s product(s) to delete.' mod='configurator' sprintf=$counters.total}<br>
                <a href="{{$run_remove_products_link}}" class="btn btn-warning">
                    <i class="icon-trash"></i>
                    {l s='Delete' mod='configurator'}
                </a>
            </div>
        {/if}

        {if $run && !$end}
            <script>
                location.href = "{{$run_remove_products_link}}";
            </script>
        {/if}

    </body>
</html>
