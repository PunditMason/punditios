<?php
defined('BASEPATH') OR exit('No direct script access allowed');

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
| example.com/class/method/id/
|
| In some instances, however, you may want to remap this relationship
| so that a different class/function is called than the one
| corresponding to the URL.
|
| Please see the user guide for complete details:
|
| https://codeigniter.com/user_guide/general/routing.html
|
| -------------------------------------------------------------------------
| RESERVED ROUTES
| -------------------------------------------------------------------------
|
| There are three reserved routes:
|
| $route['default_controller'] = 'welcome';
|
| This route indicates which controller class should be loaded if the
| URI contains no data. In the above example, the "welcome" class
| would be loaded.
|
| $route['404_override'] = 'errors/page_missing';
|
| This route will tell the Router which controller/method to use if those
| provided in the URL cannot be matched to a valid route.
|
| $route['translate_uri_dashes'] = FALSE;
|
| This is not exactly a route, but allows you to automatically route
| controller and method names that contain dashes. '-' isn't a valid
| class or method name character, so it requires translation.
| When you set this option to TRUE, it will replace ALL dashes in the
| controller and method URI segments.
|
| Examples: my-controller/index -> my_controller/index
|   my-controller/my-method -> my_controller/my_method
*/
//$route['default_controller'] = 'welcome';

$route['default_controller'] = 'user/index';
$route['404_override'] = '';
$route['translate_uri_dashes'] = TRUE;


//$route['default_controller'] = 'user/index';
//$route['404_override'] = '';

/*admin*/
$route['admin'] = 'User/index';
$route['admin/signup'] = 'User/signup';
$route['admin/create_user'] = 'User/create_user';
$route['admin/login'] = 'User/index';
$route['admin/logout'] = 'User/logout';
$route['admin/login/validate_credentials'] = 'User/validate_credentials';
//SPORT
$route['admin/sport'] = 'Admin_sport/index';
$route['admin/sport/add'] = 'Admin_sport/add';
$route['admin/sport/update'] = 'Admin_sport/update';
$route['admin/sport/update/(:any)'] = 'Admin_sport/update/$1';
$route['admin/sport/delete/(:any)'] = 'Admin_sport/delete/$1';
$route['admin/sport/(:any)'] = 'Admin_sport/index/$1'; //$1 = page number
//TEAM
$route['admin/team'] = 'Admin_team/index';
$route['admin/team/add'] = 'Admin_team/add';
$route['admin/team/update'] = 'Admin_team/update';
$route['admin/team/update/(:any)'] = 'Admin_team/update/$1';
$route['admin/team/delete/(:any)'] = 'Admin_team/delete/$1';
$route['admin/team/(:any)'] = 'Admin_team/index/$1'; //$1 = page number
//LEAGUE
$route['admin/league'] = 'Admin_league/index';
$route['admin/league/add'] = 'Admin_league/add';
$route['admin/league/update'] = 'Admin_league/update';
$route['admin/league/update/(:any)'] = 'Admin_league/update/$1';
$route['admin/league/delete/(:any)'] = 'Admin_league/delete/$1';
$route['admin/league/(:any)'] = 'Admin_league/index/$1'; //$1 = page number
//MATCH
$route['admin/match'] = 'Admin_match/index';
$route['admin/match/add'] = 'Admin_match/add';
$route['admin/match/update'] = 'Admin_match/update';
$route['admin/match/update/(:any)'] = 'Admin_match/update/$1';
$route['admin/match/delete/(:any)'] = 'Admin_match/delete/$1';
$route['admin/match/(:any)'] = 'Admin_match/index/$1'; //$1 = page number
//CHANNEL
$route['admin/channel'] = 'Admin_channel/index';
$route['admin/channel/add'] = 'Admin_channel/add';
$route['admin/channel/update'] = 'Admin_channel/update';
$route['admin/channel/update/(:any)'] = 'Admin_channel/update/$1';
$route['admin/channel/delete/(:any)'] = 'Admin_channel/delete/$1';
$route['admin/channel/(:any)'] = 'Admin_channel/index/$1'; //$1 = page number
//SEASON
$route['admin/season'] = 'Admin_season/index';
$route['admin/season/add'] = 'Admin_season/add';
$route['admin/season/update'] = 'Admin_season/update';
$route['admin/season/update/(:any)'] = 'Admin_season/update/$1';
$route['admin/season/delete/(:any)'] = 'Admin_season/delete/$1';
$route['admin/season/(:any)'] = 'Admin_season/index/$1'; //$1 = page number
//USER
$route['admin/user'] = 'Admin_user/index';
$route['admin/user/add'] = 'Admin_user/add';
$route['admin/user/update'] = 'Admin_user/update';
$route['admin/user/update/(:any)'] = 'Admin_user/update/$1';
$route['admin/user/delete/(:any)'] = 'Admin_user/delete/$1';
$route['admin/user/(:any)'] = 'Admin_user/index/$1'; //$1 = page number

//BANNER
$route['admin/banner'] = 'Admin_banner/index'; 
$route['admin/banner/add'] = 'Admin_banner/add';
$route['admin/banner/update'] = 'Admin_banner/update';
$route['admin/banner/update/(:any)'] = 'Admin_banner/update/$1';
$route['admin/banner/delete/(:any)'] = 'Admin_banner/delete/$1';
$route['admin/banner/(:any)'] = 'Admin_banner/index/$1'; //$1 = page number


//COVER
$route['admin/cover'] = 'Admin_cover/index'; 
$route['admin/cover/add'] = 'Admin_cover/add';
$route['admin/cover/update'] = 'Admin_cover/update';
$route['admin/cover/update/(:any)'] = 'Admin_cover/update/$1';
$route['admin/cover/delete/(:any)'] = 'Admin_cover/delete/$1';
$route['admin/cover/(:any)'] = 'Admin_cover/index/$1'; //$1 = page number

//NEWS
$route['admin/news'] = 'Admin_news/index'; 
$route['admin/news/add'] = 'Admin_news/add';
$route['admin/news/update'] = 'Admin_news/update';
$route['admin/news/update/(:any)'] = 'Admin_news/update/$1';
$route['admin/news/delete/(:any)'] = 'Admin_news/delete/$1';
$route['admin/news/(:any)'] = 'Admin_news/index/$1'; //$1 = page number

//About
$route['admin/aboutus'] = 'Admin_about/index';
$route['admin/aboutus/add'] = 'Admin_about/add';
$route['admin/aboutus/update'] = 'Admin_about/update';
$route['admin/aboutus/update/(:any)'] = 'Admin_about/update/$1';
$route['admin/aboutus/delete/(:any)'] = 'Admin_about/delete/$1';
$route['admin/aboutus/(:any)'] = 'Admin_about/index/$1'; //$1 = page number

//Terms
$route['admin/terms'] = 'Admin_terms/index';
$route['admin/terms/add'] = 'Admin_terms/add';
$route['admin/terms/update'] = 'Admin_terms/update';  
$route['admin/terms/update/(:any)'] = 'Admin_terms/update/$1';
$route['admin/terms/delete/(:any)'] = 'Admin_terms/delete/$1';
$route['admin/terms/(:any)'] = 'Admin_terms/index/$1'; //$1 = page number
   
//Policy
$route['admin/policy'] = 'Admin_policy/index';
$route['admin/policy/add'] = 'Admin_policy/add';
$route['admin/policy/update'] = 'Admin_policy/update';
$route['admin/policy/update/(:any)'] = 'Admin_policy/update/$1';
$route['admin/policy/delete/(:any)'] = 'Admin_policy/delete/$1';
$route['admin/policy/(:any)'] = 'Admin_policy/index/$1'; //$1 = page number

//API



/*
| -------------------------------------------------------------------------
| Sample REST API Routes
| -------------------------------------------------------------------------
*/
$route['api/app/users/(:num)'] = 'api/example/users/id/$1'; // Example 4
$route['api/app/users/(:num)(\.)([a-zA-Z0-9_-]+)(.*)'] = 'api/example/users/id/$1/format/$3$4'; // Example 8
