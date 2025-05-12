# Configurator

## About
DMConcept

## CRON

Remove empty cart
$ php /modules/configurator/cron.php action=delete_empty_cart number=10 day=2

Remove old cart
$ php /modules/configurator/cron.php action=delete_old_cart number=10 day=2 with_customer=0 with_customized_data=0

Remove cart details without guest
$ php /modules/configurator/cron.php action=delete_cart_details_without_guest number=10 day=2 with_customized_data=0

Remove cart details without cart
$ php /modules/configurator/cron.php action=delete_cart_details_without_cart number=10

Clean customized_data
$ php /modules/configurator/cron.php action=clean_customized_data