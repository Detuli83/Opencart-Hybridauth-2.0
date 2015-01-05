<?php

/**
 * OpenCart Ukrainian Community
 *
 * LICENSE
 *
 * This source file is subject to the GNU General Public License, Version 3
 * It is also available through the world-wide-web at this URL:
 * http://www.gnu.org/copyleft/gpl.html
 * If you did not receive a copy of the license and are unable to
 * obtain it through the world-wide-web, please send an email

 *
 * @category   OpenCart
 * @package    OCU HybridAuth
 * @copyright  Copyright (c) 2011 Eugene Lifescale by OpenCart Ukrainian Community (http://opencart-ukraine.tumblr.com)
 * @license    http://www.gnu.org/copyleft/gpl.html     GNU General Public License, Version 3
 */



/**
 * @category   OpenCart
 * @package    OCU HybridAuth
 * @copyright  Copyright (c) 2011 Eugene Lifescale by OpenCart Ukrainian Community (http://opencart-ukraine.tumblr.com)
 */

class ControllerHybridAuth extends Controller {

    private $_config = array();
    private $_redirect;

    public function index() {
        
        $this->_prepare();

        // Check if Logged
        if ($this->customer->isLogged()) {
            $this->response->redirect($this->_redirect);
        }

        // Check if module is Enabled
        if (!$this->config->get('hybrid_auth_status')) {
            $this->response->redirect($this->_redirect);
        }

        // Dependencies
        $this->language->load('hybrid/auth');
        require_once(DIR_SYSTEM . 'library/Hybrid/Auth.php');
        $this->load->model('hybrid/auth');

        // Load Config
        $this->_config['base_url']   = HTTP_SERVER . 'hybridauth.php';
        $this->_config['debug_file'] = DIR_SYSTEM . 'logs/hybridauth.txt';
        $this->_config['debug_mode'] = (bool) $this->config->get('hybrid_auth_debug');

        $settings = $this->config->get('hybrid_auth_module');
		
        foreach ($settings as $config) {
            $this->_config['providers'][$config['provider']] = array('enabled' => (bool) $config['enabled'],
                                                                     'keys'    => array('id'     => $config['key'],
                                                                                        'key'    => $config['key'],
                                                                                        'secret' => $config['secret'],
                                                                                        'scope'  => $config['scope']));
																						
        }

        // Receive request
        if (isset($this->request->get['provider'])) {
            $provider = $this->request->get['provider'];
        } else {

            // Save error to the System Log
            $this->log->write('Missing application provider.');

            // Set Message
            $this->session->data['error'] = sprintf("An error occurred, please <a href=\"%s\">notify</a> the administrator.",
                                                    $this->url->link('information/contact'));

            // Redirect to the Login Page
            $this->response->redirect($this->_redirect);
        }

        try {

            // Authentication Begin
            $auth = new Hybrid_Auth($this->_config);
            $adapter = $auth->authenticate($provider);
            $user_profile = $adapter->getUserProfile();


            // 1 - check if user already have authenticated using this provider before
            $customer_id = $this->model_hybrid_auth->findCustomerByIdentifier($provider, $user_profile->identifier);

            if ($customer_id) {
                // 1.1 Login
                $this->model_hybrid_auth->login($customer_id);

                // 1.2 Redirect to Refer Page
                $this->response->redirect($this->_redirect);
            }


            // 2 - else, here lets check if the user email we got from the provider already exists in our database ( for this example the email is UNIQUE for each user )
            // if authentication does not exist, but the email address returned  by the provider does exist in database,
            // then we tell the user that the email  is already in use
            // but, its up to you if you want to associate the authentication with the user having the address email in the database
            if ($user_profile->email){
                $customer_id = $this->model_hybrid_auth->findCustomerByEmail($user_profile->email);

                if ($customer_id) {
                    die('<script>alert("' . sprintf($this->language->get('text_provider_email_already_exists'), $provider, $user_profile->email) . '");window.close();window.opener.location.reload();</script>');
                }
            }

            // 3 - if authentication does not exist and email is not in use, then we create a new user
            $user_address = array();

            if (!empty($user_profile->address)) {
                $user_address[] = $user_profile->address;
            }

            if (!empty($user_profile->region)) {
                $user_address[] = $user_profile->region;
            }

            if (!empty($user_profile->country)) {
                $user_address[] = $user_profile->country;
            }

            // 3.1 - create new customer
            $customer_id = $this->model_hybrid_auth->addCustomer(
                array('email'      => $user_profile->email,
                      'firstname'  => $user_profile->firstName,
                      'lastname'   => $user_profile->lastName,
                      'telephone'  => $user_profile->phone,
                      'fax'        => false,
                      'newsletter' => true,
                      'company'    => false,
                      'address_1'  => ($user_address ? implode(', ', $user_address) : false),
                      'address_2'  => false,
                      'city'       => $user_profile->city,
                      'postcode'   => $user_profile->zip,
                      'country_id' => $this->model_hybrid_auth->findCountry($user_profile->country),
                      'zone_id'    => $this->model_hybrid_auth->findZone($user_profile->region),
                      'password'   => substr(rand().microtime(), 0, 6)));

            // 3.2 - create a new authentication for him
            $this->model_hybrid_auth->addAuthentication(
                array('customer_id' => (int) $customer_id,
                    'provider' => $provider,
                    'identifier' => $user_profile->identifier,
                    'web_site_url' => $user_profile->webSiteURL,
                    'profile_url' => $user_profile->profileURL,
                    'photo_url' => $user_profile->photoURL,
                    'display_name' => $user_profile->displayName,
                    'description' => $user_profile->description,
                    'first_name' => $user_profile->firstName,
                    'last_name' => $user_profile->lastName,
                    'gender' => $user_profile->gender,
                    'language' => $user_profile->language,
                    'age' => $user_profile->age,
                    'birth_day' => $user_profile->birthDay,
                    'birth_month' => $user_profile->birthMonth,
                    'birth_year' => $user_profile->birthYear,
                    'email' => $user_profile->email,
                    'email_verified' => $user_profile->emailVerified,
                    'phone' => $user_profile->phone,
                    'address' => $user_profile->address,
                    'country' => $user_profile->country,
                    'region' => $user_profile->region,
                    'city' => $user_profile->city,
                    'zip' => $user_profile->zip));

            // 3.3 - login
            $this->model_hybrid_auth->login($customer_id);

            // 3.4 - redirect to Refer Page
            $this->response->redirect($this->_redirect);

       } catch (Exception $e) {

            // Error Descriptions
            switch ($e->getCode()){
                case 0 : $error = "Unspecified error."; break;
                case 1 : $error = "Hybriauth configuration error."; break;
                case 2 : $error = "Provider not properly configured."; break;
                case 3 : $error = "Unknown or disabled provider."; break;
                case 4 : $error = "Missing provider application credentials."; break;
                case 5 : $error = "Authentication failed. The user has canceled the authentication or the provider refused the connection."; break;
                case 6 : $error = "User profile request failed. Most likely the user is not connected to the provider and he should to authenticate again.";
                         $adapter->logout();
                         break;
                case 7 : $error = "User not connected to the provider.";
                         $adapter->logout();
                         break;
            }

            $error .= "\n\nHybridAuth Error: " . $e->getMessage();
            $error .= "\n\nTrace:\n " . $e->getTraceAsString();

            $this->log->write($error);
       }
    }
    
    
    private function _prepare() {

        // Some API returns encoded URL
        if (isset($this->request->get) && isset($_GET)) {

            // Prepare for OpenCart
            foreach ($this->request->get as $key => $value) {
                $this->request->get[str_replace('amp;', '', $key)] = $value;
            }

            // Prepare for Library
            foreach ($_GET as $key => $value) {
                $_GET[str_replace('amp;', '', $key)] = $value;
            }
        }

        // Base64 URL Decode
        if (isset($this->request->get['redirect'])) {
            $this->_redirect = base64_decode($this->request->get['redirect']);
        } else {
            $this->_redirect = $this->url->link('account/account');
        }
    }
    
    
    public function success() {

        if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/hybrid/success.tpl')) {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . '/template/hybrid/success.tpl', $data));
        } else {
			$this->response->setOutput($this->load->view($this->config->get('config_template') . 'default/template/hybrid/success.tpl', $data));
        }

    }
    
}
