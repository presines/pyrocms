<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
/**
 *
 * @package  	PyroCMS
 * @subpackage  Categories
 * @category  	Module
 * @author  	Phil Sturgeon - PyroCMS Dev Team
 */
class Admin_Categories extends Admin_Controller
{
	/**
	 * Array that contains the validation rules
	 * @access protected
	 * @var array
	 */
    private $categories;

	protected $validation_rules = array(
		array(
			'field' => 'parent_id',
			'label' => 'lang:cat_category_label',
			'rules' => 'trim|numeric'
		),
		array(
			'field' => 'slug',
			'label' => 'lang:cat_slug_label',
			'rules' => 'trim|required|alpha_dot_dash|max_length[100]|callback__check_slug'
		),
		array(
			'field' => 'title',
			'label' => 'lang:cat_title_label',
			'rules' => 'trim|htmlspecialchars|required|max_length[100]|callback__check_title'
		),
		array(
			'field' => 'thumbnail_path',
			'label' => 'lang:cat_thumbnail_path_label',
			'rules' => 'trim'
		),
		array(
			'field' => 'headerimg_path',
			'label' => 'lang:cat_headerimg_path_label',
			'rules' => 'trim'
		),
		array(
			'field' => 'description',
			'label' => 'lang:cat_description_label',
			'rules' => 'trim'
		),
		array(
			'field' => 'featured',
			'label' => 'lang:cat_featured_label',
			'rules' => 'trim|alpha'
		)
	);
	
	/** 
	 * The constructor
	 * @access public
	 * @return void
	 */
	public function __construct()
	{
		parent::Admin_Controller();
		$this->load->model('products_categories_m');
		$this->lang->load('categories');
		$this->lang->load('products');


		// Set the validation rules
		$this->validation_rules = $this->validation_rules;


        $this->categories= $this->products_categories_m->get_categories();

	    $this->template->append_metadata( css('products.css', 'products') )
                       ->set_partial('shortcuts', 'admin/partials/shortcuts');

	}
	
	/**
	 * Index method, lists all categories
	 * @access public
	 * @return void
	 */
	public function index()
	{
		$this->pyrocache->delete_all('modules_m');
			
		// Using this data, get the relevant results
		$categories = $this->categories;

		$this->template
			->title($this->module_details['name'], lang('cat_list_title'))
			->set('categories', $categories)
			->build('admin/categories/index', $this->data);
	}
	
	/**
	 * Create method, creates a new category
	 * @access public
	 * @return void
	 */
	public function create()
	{
		
		// Validate the data
		if ($this->form_validation->run())
		{
			$this->blog_categories_m->insert($_POST)
				? $this->session->set_flashdata('success', sprintf( lang('cat_add_success'), $this->input->post('title')) )
				: $this->session->set_flashdata(array('error'=> lang('cat_add_error')));

			redirect('admin/blog/categories');
		}
		
		// Loop through each validation rule
		foreach($this->validation_rules as $rule)
		{
			$category->{$rule['field']} = set_value($rule['field']);
		}
		
		// Render the view	
		$this->data->category =& $category;	
		$this->template->title($this->module_details['name'], lang('cat_create_title'))
						->build('admin/categories/form', $this->data);	
	}
	
	/**
	 * Edit method, edits an existing category
	 * @access public
	 * @param int id The ID of the category to edit 
	 * @return void
	 */
	public function edit($id = 0)
	{	
		// Get the category
		$category = $this->blog_categories_m->get($id);
		
		// ID specified?
		$category or redirect('admin/blog/categories/index');
		
		// Validate the results
		if ($this->form_validation->run())
		{		
			$this->blog_categories_m->update($id, $_POST)
				? $this->session->set_flashdata('success', sprintf( lang('cat_edit_success'), $this->input->post('title')) )
				: $this->session->set_flashdata(array('error'=> lang('cat_edit_error')));
			
			redirect('admin/blog/categories/index');
		}
		
		// Loop through each rule
		foreach($this->validation_rules as $rule)
		{
			if($this->input->post($rule['field']) !== FALSE)
			{
				$category->{$rule['field']} = $this->input->post($rule['field']);
			}
		}

		// Render the view
		$this->data->category =& $category;
		$this->template->title($this->module_details['name'], sprintf(lang('cat_edit_title'), $category->title))
						->build('admin/categories/form', $this->data);
	}	

	/**
	 * Delete method, deletes an existing category (obvious isn't it?)
	 * @access public
	 * @param int id The ID of the category to edit 
	 * @return void
	 */
	public function delete($id = 0)
	{	
		$id_array = (!empty($id)) ? array($id) : $this->input->post('action_to');
		
		// Delete multiple
		if(!empty($id_array))
		{
			$deleted = 0;
			$to_delete = 0;
			foreach ($id_array as $id) 
			{
				if($this->blog_categories_m->delete($id))
				{
					$deleted++;
				}
				else
				{
					$this->session->set_flashdata('error', sprintf($this->lang->line('cat_mass_delete_error'), $id));
				}
				$to_delete++;
			}
			
			if( $deleted > 0 )
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('cat_mass_delete_success'), $deleted, $to_delete));
			}
		}		
		else
		{
			$this->session->set_flashdata('error', $this->lang->line('cat_no_select_error'));
		}
		
		redirect('admin/blog/categories/index');
	}
		
	/**
	 * Callback method that checks the title of the category
	 * @access public
	 * @param string title The title to check
	 * @return bool
	 */
	public function _check_title($title = '')
	{
		if ($this->blog_categories_m->check_title($title))
		{
			$this->form_validation->set_message('_check_title', sprintf($this->lang->line('cat_already_exist_error'), $title));
			return FALSE;
		}

		return TRUE;
	}
	
	/**
	 * Create method, creates a new category via ajax
	 * @access public
	 * @return void
	 */
	public function create_ajax()
	{
		// Loop through each validation rule
		foreach($this->validation_rules as $rule)
		{
			$category->{$rule['field']} = set_value($rule['field']);
		}
		
		$this->data->method = 'create';
		$this->data->category =& $category;
		
		if ($this->form_validation->run())
		{
			$id = $this->blog_categories_m->insert_ajax($_POST);
			
			if($id > 0)
			{
				$message = sprintf( lang('cat_add_success'), $this->input->post('title'));
			}
			else
			{
				$message = lang('cat_add_error');
			}
			
			$json = array('message' => $message,
					'title' => $this->input->post('title'),
					'category_id' => $id,
					'status' => 'ok'
					);
			echo json_encode($json);
		}	
		else
		{		
			// Render the view
			$errors = validation_errors();
			$form = $this->load->view('admin/categories/form', $this->data, TRUE);
			if(empty($errors))
			{
				
				echo $form;
			}
			else
			{
				$json = array('message' => $errors,
					      'status' => 'error',
					      'form' => $form
					     );
				echo json_encode($json);
			}
		}
	}
}