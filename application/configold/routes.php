<?php  if ( ! defined('BASEPATH')) exit('No direct script access allowed');
/*
| -------------------------------------------------------------------------
| URI ROUTING
| -------------------------------------------------------------------------
| This file lets you re-map URI requests to specific controller functions.
|
| Typically there is a one-to-one relationship between a URL string
| and its corresponding controller class/method. The segments in a
| URL normally follow this pattern:
|
|	example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
|	http://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There area two reserved routes:
|
|	$route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
|	$route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router what URI segments to use if those provided
| in the URL cannot be matched to a valid route.
|
*/
$route['default_controller'] = 'user/index';
$route['404_override'] = '';

/*admin*/
$route['admin'] = 'user/index';
$route['admin/signup'] = 'user/signup';
$route['admin/create_user'] = 'user/create_user';
$route['admin/login'] = 'user/index';
$route['admin/logout'] = 'user/logout';
$route['admin/login/validate_credentials'] = 'user/validate_credentials';
//SPORT
$route['admin/sport'] = 'admin_sport/index';
$route['admin/sport/add'] = 'admin_sport/add';
$route['admin/sport/update'] = 'admin_sport/update';
$route['admin/sport/update/(:any)'] = 'admin_sport/update/$1';
$route['admin/sport/delete/(:any)'] = 'admin_sport/delete/$1';
$route['admin/sport/(:any)'] = 'admin_sport/index/$1'; //$1 = page number
//TEAM
$route['admin/team'] = 'admin_team/index';
$route['admin/team/add'] = 'admin_team/add';
$route['admin/team/update'] = 'admin_team/update';
$route['admin/team/update/(:any)'] = 'admin_team/update/$1';
$route['admin/team/delete/(:any)'] = 'admin_team/delete/$1';
$route['admin/team/(:any)'] = 'admin_team/index/$1'; //$1 = page number
//LEAGUE
$route['admin/league'] = 'admin_league/index';
$route['admin/league/add'] = 'admin_league/add';
$route['admin/league/update'] = 'admin_league/update';
$route['admin/league/update/(:any)'] = 'admin_league/update/$1';
$route['admin/league/delete/(:any)'] = 'admin_league/delete/$1';
$route['admin/league/(:any)'] = 'admin_league/index/$1'; //$1 = page number
//MATCH
$route['admin/match'] = 'admin_match/index';
$route['admin/match/add'] = 'admin_match/add';
$route['admin/match/update'] = 'admin_match/update';
$route['admin/match/update/(:any)'] = 'admin_match/update/$1';
$route['admin/match/delete/(:any)'] = 'admin_match/delete/$1';
$route['admin/match/(:any)'] = 'admin_match/index/$1'; //$1 = page number
//CHANNEL
$route['admin/channel'] = 'admin_channel/index';
$route['admin/channel/add'] = 'admin_channel/add';
$route['admin/channel/update'] = 'admin_channel/update';
$route['admin/channel/update/(:any)'] = 'admin_channel/update/$1';
$route['admin/channel/delete/(:any)'] = 'admin_channel/delete/$1';
$route['admin/channel/(:any)'] = 'admin_channel/index/$1'; //$1 = page number
//SEASON
$route['admin/season'] = 'admin_season/index';
$route['admin/season/add'] = 'admin_season/add';
$route['admin/season/update'] = 'admin_season/update';
$route['admin/season/update/(:any)'] = 'admin_season/update/$1';
$route['admin/season/delete/(:any)'] = 'admin_season/delete/$1';
$route['admin/season/(:any)'] = 'admin_season/index/$1'; //$1 = page number
//USER
$route['admin/user'] = 'admin_user/index';
$route['admin/user/add'] = 'admin_user/add';
$route['admin/user/update'] = 'admin_user/update';
$route['admin/user/update/(:any)'] = 'admin_user/update/$1';
$route['admin/user/delete/(:any)'] = 'admin_user/delete/$1';
$route['admin/user/(:any)'] = 'admin_user/index/$1'; //$1 = page number
//API



/* End of file routes.php */
/* Location: ./application/config/routes.php */