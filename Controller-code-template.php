		// Load Hybrid login options;
		$this->load->model('tool/image');
		$data['providers'] = array();
		$data['hybrid_auth_enabled'] = $this->config->get('hybrid_auth_status');
		if($this->config->get('hybrid_auth_status')) {
		
			$this->document->addStyle('catalog/view/javascript/bootstrap/css/bootstrap-social.css');
			
			foreach ($this->config->get('hybrid_auth_module') as $config) { 
					
				if($config['enabled']) {
					$data['providers'][] = array(
						"name"				=>		$config['provider'],
						aClass"			=>		'btn btn-block btn-social btn-lg btn-' . $config['css_class'],
						"iClass"			=>		'fa fa-' . $config['css_class'],
						"loginText"			=>		'Sign in with ' .  $config['provider'],
						"href"				=>		$this->url->link('hybrid/auth', 'provider=' . 
													$config['provider'] . '&redirect=' . base64_encode($this->url->link('account/edit')))
						);
				}
			}
		}