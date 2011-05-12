<?php defined('BASEPATH') or exit('No direct script access allowed');

class Module_Products extends Module {

	public $version = '0.5';

	public function info()
	{
		return array(
			'name' => array(
				'en' => 'Products',
				'es' => 'Productos',
			),
			'description' => array(
				'en' => 'Products module.',
				'es' => 'Módulo de productos.',
			),
			'frontend' => True,
			'backend' => True,
			'menu' => 'content'
		);
	}

	public function install()
	{
	    return TRUE;
	}

	public function uninstall()
	{
		return TRUE;
	}


	public function upgrade($old_version)
	{
		// Your Upgrade Logic
		return TRUE;
	}

	public function help()
	{
		// Return a string containing help info
		// You could include a file and return it here.
		return "";
	}
}
/* End of file details.php */
