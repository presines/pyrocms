<?php defined('BASEPATH') OR exit('No direct script access allowed');

/**
 *
 * @package  	PyroCMS
 * @subpackage  Categories
 * @category  	Module
 */
class Admin extends Admin_Controller {

	/**
	 * The id of post
	 * @access protected
	 * @var int
	 */
	protected $id = 0;

	private $_path 		= '';
	private $_type 		= NULL;
	private $_ext 		= NULL;

	/**
	 * Array that contains the validation rules
	 * @access protected
	 * @var array
	 */
	protected $validation_rules = array(
		array(
			'field' => 'title',
			'label' => 'lang:products_title_label',
			'rules' => 'trim|htmlspecialchars|required|max_length[100]|callback__check_title'
		),
		array(
			'field' => 'slug',
			'label' => 'lang:products_slug_label',
			'rules' => 'trim|required|alpha_dot_dash|max_length[100]|callback__check_slug'
		),
		array(
			'field' => 'product_category_id',
			'label' => 'lang:products_category_label',
			'rules' => 'trim|numeric'
		),
		array(
			'field' => 'thumbnail_path',
			'label' => 'lang:products_thumbnail_path_label',
			'rules' => 'trim'
		),
		array(
			'field' => 'description',
			'label' => 'lang:products_description_label',
			'rules' => 'trim'
		),
		array(
			'field' => 'body',
			'label' => 'lang:products_body_label',
			'rules' => 'trim'
		),
		array(
			'field' => 'status',
			'label' => 'lang:products_status_label',
			'rules' => 'trim|alpha'
		),
		array(
			'field' => 'ordering',
			'label' => 'lang:products_ordering_label',
			'rules' => 'trim|numeric'
		)
	);
    

	private $image_validation_rules = array(
		array(
			'field' => 'userfile',
			'label' => 'lang:products_img_file_label',
			'rules' => 'callback__check_ext'
		),
		array(
			'field' => 'name',
			'label' => 'lang:products_img_name_label',
			'rules' => 'trim|required|max_length[250]'
		),
		array(
			'field' => 'description',
			'label' => 'lang:products_img_description_label',
			'rules' => 'trim|max_length[250]'
		),
		array(
			'field' => 'type',
			'label' => 'lang:products_img_type_label',
			'rules' => 'trim|max_length[1]'
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

		$this->load->model('products_m');
		$this->load->model('products_categories_m');
		$this->load->model('products_images_m');
		$this->lang->load('products');
		$this->lang->load('categories');

		// Date ranges for select boxes
		$this->data->hours = array_combine($hours = range(0, 23), $hours);
		$this->data->minutes = array_combine($minutes = range(0, 59), $minutes);

		$this->data->categories = array();
		if ($categories = $this->products_categories_m->order_by('title')->get_all())
		{
			foreach ($categories as $category)
			{
				$this->data->categories[$category->id] = $category->title;
			}
		}

		$this->template
			->append_metadata( css('products.css', 'products') )
			->set_partial('shortcuts', 'admin/partials/shortcuts');
	}

	/**
	 * Show all created products
	 * @access public
	 * @return void
	 */
	public function index()
	{
		//set the base/default where clause
		$base_where = array('status' => 'all');

		//add post values to base_where if f_module is posted
		$base_where = $this->input->post('f_category') ? $base_where + array('category' => $this->input->post('f_category')) : $base_where;

		$base_where['status'] = $this->input->post('f_status') ? $this->input->post('f_status') : $base_where['status'];

		$base_where = $this->input->post('f_keywords') ? $base_where + array('keywords' => $this->input->post('f_keywords')) : $base_where;

		// Create pagination links
		$total_rows = $this->products_m->count_by($base_where);
		$pagination = create_pagination('admin/products/index', $total_rows);

		// Using this data, get the relevant results
		$products = $this->products_m->limit($pagination['limit'])->get_many_by($base_where);

		//do we need to unset the layout because the request is ajax?
		$this->is_ajax() ? $this->template->set_layout(FALSE) : '';

		$this->template
				->title($this->module_details['name'])
				->set_partial('filters', 'admin/partials/filters')
				->append_metadata(js('admin/filter.js'))
				->set('pagination', $pagination)
				->set('products', $products)
				->build('admin/index', $this->data);
	}

	/**
	 * Create new post
	 * @access public
	 * @return void
	 */
	public function create()
	{
		$this->load->library('form_validation');

		$this->form_validation->set_rules($this->validation_rules);

		if ($this->form_validation->run())
		{

			$id = $this->products_m->insert(array(
				'product_category_id'		=> $this->input->post('product_category_id'),
				'slug'				=> $this->input->post('slug'),
				'title'				=> $this->input->post('title'),
				'thumbnail_path'	=> $this->input->post('thumbnail_path'),
				'description'		=> $this->input->post('description'),
				'body'				=> $this->input->post('body'),
				'status'			=> $this->input->post('status'),
				'created_on'		=> date("Y-m-d",now())
			));

			if ($id)
			{
				$this->pyrocache->delete_all('products_m');
				$this->session->set_flashdata('success', sprintf($this->lang->line('products_post_add_success'), $this->input->post('title')));
			}
			else
			{
				$this->session->set_flashdata('error', $this->lang->line('products_post_add_error'));
			}

			// Redirect back to the form or main page
			$this->input->post('btnAction') == 'save_exit' ? redirect('admin/products') : redirect('admin/products/edit/' . $id);
		}
		else
		{
			// Go through all the known fields and get the post values
			foreach ($this->validation_rules as $key => $field)
			{
				$product->$field['field'] = set_value($field['field']);
			}
		}

		$this->template
				->title($this->module_details['name'], lang('products_create_title'))
				->append_metadata($this->load->view('fragments/wysiwyg', $this->data, TRUE))
				->append_metadata(js('products_form.js', 'products'))
				->set('product', $product)
				->build('admin/form');
	}

	/**
	 * Edit blog post
	 * @access public
	 * @param int $id the ID of the blog post to edit
	 * @return void
	 */
	public function edit($id = 0)
	{
		$id OR redirect('admin/products');

		$this->load->library('form_validation');

		$this->form_validation->set_rules($this->validation_rules);

		$product = $this->products_m->get($id);

		$this->id = $product->id;
		$thumbnail_path=$product->thumbnail_path;

		if ($this->form_validation->run())
		{
            // We are uploading a new file
			if ( ! empty($_FILES['thumbnail']['name'])){
                // Setup upload config
				$this->load->library('upload', array(
					'upload_path'	=> FCPATH . 'uploads/products/thumbnails/',
					'allowed_types'	=> 'gif|jpg|png',
                    'max_size' => '1024'
				));
                if ($this->upload->do_upload('thumbnail')){
                    $data = $this->upload->data();

                    /* Create the config for image library */
                    $configThumb = array();
                    $configThumb['image_library'] = 'gd2';
                    $configThumb['source_image'] = '';
                    $configThumb['create_thumb'] = false;
                    $configThumb['maintain_ratio'] = TRUE;
                    /* Set the height and width or thumbs */
                    $configThumb['width'] = 273;
                    $configThumb['height'] = 1000;
                    /* Load the image library */
                    $this->load->library('image_lib');
                    $configThumb['source_image'] = $data['full_path'];
                    $this->image_lib->initialize($configThumb);
                    $this->image_lib->resize();

                    $thumbnail_path=$data['file_name'];
                } else {
                    $this->data->messages['error'] = $this->upload->display_errors();
                }
            }

			$result = $this->products_m->update($id, array(
				'product_category_id'		=> $this->input->post('product_category_id'),
				'slug'				=> $this->input->post('slug'),
				'title'				=> $this->input->post('title'),
				'thumbnail_path'	=> $thumbnail_path,
				'description'		=> $this->input->post('description'),
				'body'				=> $this->input->post('body'),
				'status'			=> $this->input->post('status')
			));
			
			if ($result)
			{
				$this->session->set_flashdata(array('success' => sprintf($this->lang->line('products_edit_success'), $this->input->post('title'))));
			}   
			else
			{
				$this->session->set_flashdata(array('error' => $this->lang->line('products_edit_error')));
			}

			// Redirect back to the form or main page
			$this->input->post('btnAction') == 'save_exit' ? redirect('admin/products') : redirect('admin/products/edit/' . $id);
		}

		// Go through all the known fields and get the post values
		foreach (array_keys($this->validation_rules) as $field)
		{
			if (isset($_POST[$field]))
			{
				$product->$field = $this->form_validation->$field;
			}
		}
        $product_images=$this->products_images_m->get_images($product->id);
		
		// Load WYSIWYG editor
		$this->template
				->title($this->module_details['name'], sprintf(lang('products_edit_title'), $product->title))
				->append_metadata($this->load->view('fragments/wysiwyg', $this->data, TRUE))
			    ->append_metadata( css('jquery.fileupload-ui.css', 'products'))
			    ->append_metadata( css('files.css', 'files'))
				->append_metadata(js('jquery.fileupload.js', 'products'))
				->append_metadata(js('jquery.fileupload-ui.js', 'products'))
				->append_metadata(js('products_form.js', 'products'))
				->set('product', $product)
				->set('product_images', $product_images)
				->build('admin/form');
	}

	/**
	 * Preview blog post
	 * @access public
	 * @param int $id the ID of the blog post to preview
	 * @return void
	 */
	public function preview($id = 0)
	{
		$product = $this->products_m->get($id);

		$this->template
				->set_layout('modal', 'admin')
				->set('product', $product)
				->build('admin/preview');
	}

	/**
	 * Helper method to determine what to do with selected items from form post
	 * @access public
	 * @return void
	 */
	public function action()
	{
		switch ($this->input->post('btnAction'))
		{
			case 'publish':
				role_or_die('blog', 'put_live');
				$this->publish();
				break;
			
			case 'delete':
				role_or_die('blog', 'delete_live');
				$this->delete();
				break;
			
			default:
				redirect('admin/products');
				break;
		}
	}

	/**
	 * Publish product
	 * @access public
	 * @param int $id the ID of the blog post to make public
	 * @return void
	 */
	public function publish($id = 0)
	{
		role_or_die('blog', 'put_live');

		// Publish one
		$ids = ($id) ? array($id) : $this->input->post('action_to');

		if ( ! empty($ids))
		{
			// Go through the array of slugs to publish
			$product_titles = array();
			foreach ($ids as $id)
			{
				// Get the current page so we can grab the id too
				if ($product = $this->products_m->get($id))
				{
					$this->products_m->publish($id);

					// Wipe cache for this model, the content has changed
					$this->pyrocache->delete('products_m');
					$product_titles[] = $product->title;
				}
			}
		}

		// Some posts have been published
		if ( ! empty($product_titles))
		{
			// Only publishing one post
			if (count($product_titles) == 1)
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('products_publish_success'), $product_titles[0]));
			}
			// Publishing multiple posts
			else
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('products_mass_publish_success'), implode('", "', $product_titles)));
			}
		}
		// For some reason, none of them were published
		else
		{
			$this->session->set_flashdata('notice', $this->lang->line('products_publish_error'));
		}

		redirect('admin/products');
	}

	/**
	 * Delete blog post
	 * @access public
	 * @param int $id the ID of the blog post to delete
	 * @return void
	 */
	public function delete($id = 0)
	{
		// Delete one
		$ids = ($id) ? array($id) : $this->input->post('action_to');

		// Go through the array of slugs to delete
		if ( ! empty($ids))
		{
			$product_titles = array();
			foreach ($ids as $id)
			{
				// Get the current page so we can grab the id too
				if ($product = $this->products_m->get($id))
				{
					$this->products_m->delete($id);

					// Wipe cache for this model, the content has changed
					$this->pyrocache->delete('products_m');
					$product_titles[] = $product->title;
				}
			}
		}

		// Some pages have been deleted
		if ( ! empty($product_titles))
		{
			// Only deleting one page
			if (count($product_titles) == 1)
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('products_delete_success'), $product_titles[0]));
			}
			// Deleting multiple pages
			else
			{
				$this->session->set_flashdata('success', sprintf($this->lang->line('products_mass_delete_success'), implode('", "', $product_titles)));
			}
		}
		// For some reason, none of them were deleted
		else
		{
			$this->session->set_flashdata('notice', lang('products_delete_error'));
		}

		redirect('admin/products');
	}


	// ------------------------------------------------------------------------

	/**
	 * Upload
	 *
	 * Upload a file to the destination folder
	 *
	 * @params int	The folder id
	 */
	public function upload($product_id = 0){
		$this->load->library('form_validation');
        $this->form_validation->set_rules($this->image_validation_rules);

		if ($this->form_validation->run())
		{
			// Setup upload config
			$this->load->library('upload', array(
				'upload_path'	=> 'uploads/products/images',
				'allowed_types'	=> $this->_ext
			));

			// File upload error
			if ( ! $this->upload->do_upload('userfile'))
			{
				$status		= 'error';
				$message	= $this->upload->display_errors();

				if ($this->is_ajax())
				{
					$data = array();
					$data['messages'][$status] = $message;
					$message = $this->load->view('admin/partials/notices', $data, TRUE);

					return print( json_encode((object) array(
						'status'	=> $status,
						'message'	=> $message
					)) );
				}

				$this->data->messages[$status] = $message;
			}

			// File upload success
			else
			{
				$file = $this->upload->data();
				$data = array(
					'product_id'	=> (int) $product_id,
					'name'			=> $this->input->post('name'),
					'description'	=> $this->input->post('description') ? $this->input->post('description') : '',
					'filename'		=> $file['file_name'],
					'extension'		=> $file['file_ext'],
					'mimetype'		=> $file['file_type'],
					'filesize'		=> $file['file_size'],
					'width'			=> (int) $file['image_width'],
					'height'		=> (int) $file['image_height'],
					'date_added'	=> now()
				);

				// Insert success
				if ($id = $this->products_images_m->insert($data))
				{
					$status		= 'success';
					$message	= lang('product_img_create_success');
				}
				// Insert error
				else
				{
					$status		= 'error';
					$message	= lang('product_img_create_error');
				}

				if ($this->is_ajax())
				{
					$data = array();
					$data['messages'][$status] = $message;
					$message = $this->load->view('admin/partials/notices', $data, TRUE);

					return print( json_encode((object) array(
						'status'	=> $status,
						'message'	=> $message,
						'file'		=> array(
							'name'	=> $file['file_name'],
							'type'	=> $file['file_type'],
							'size'	=> $file['file_size'],
							'thumb'	=> base_url() . 'files/thumb/' . $id . '/80'
						)
					)) );
				}

				if ($status === 'success')
				{
					$this->session->set_flashdata($status, $message);
					redirect('admin/products/edit/' . $product_id);
				}
			}
		}
		elseif (validation_errors())
		{
			// if request is ajax return json data, otherwise do normal stuff
			if ($this->is_ajax())
			{
				$message = $this->load->view('admin/partials/notices', array(), TRUE);

				return print( json_encode((object) array(
					'status'	=> 'error',
					'message'	=> $message
				)) );
			}
		}

		if ($this->is_ajax())
		{
			// todo: debug errors here
			$status		= 'error';
			$message	= 'unknown';

			$data = array();
			$data['messages'][$status] = $message;
			$message = $this->load->view('admin/partials/notices', $data, TRUE);

			return print( json_encode((object) array(
				'status'	=> $status,
				'message'	=> $message
			)) );
		}

		// Loop through each validation rule
		foreach ($this->_validation_rules as $rule)
		{
			$this->data->file->{$rule['field']} = set_value($rule['field']);
		}

		$this->template
			->title()
			->build('admin/products/upload', $this->data);
	}

	// ------------------------------------------------------------------------


	/**
	 * Callback method that checks the title of an post
	 * @access public
	 * @param string title The Title to check
	 * @return bool
	 */
	public function _check_title($title = '')
	{
		if ( ! $this->products_m->check_exists('title', $title, $this->id))
		{
			$this->form_validation->set_message('_check_title', sprintf(lang('products_already_exist_error'), lang('products_title_label')));
			return FALSE;
		}
		
		return TRUE;
	}
	
	/**
	 * Callback method that checks the slug of an post
	 * @access public
	 * @param string slug The Slug to check
	 * @return bool
	 */
	public function _check_slug($slug = '')
	{
		if ( ! $this->products_m->check_exists('slug', $slug, $this->id))
		{
			$this->form_validation->set_message('_check_slug', sprintf(lang('products_already_exist_error'), lang('products_slug_label')));
			return FALSE;
		}

		return TRUE;
	}

	/**
	 * method to fetch filtered results for blog list
	 * @access public
	 * @return void
	 */
	public function ajax_filter()
	{
		$category = $this->input->post('f_category');
		$status = $this->input->post('f_status');
		$keywords = $this->input->post('f_keywords');

		$product_data = array();

		if ($status == 'live' OR $status == 'draft')
		{
			$product_data['status'] = $status;
		}

		if ($category != 0)
		{
			$product_data['product_category_id'] = $category;
		}

		//keywords, lets explode them out if they exist
		if ($keywords)
		{
			$product_data['keywords'] = $keywords;
		}
		$results = $this->products_m->search($product_data);

		//set the layout to false and load the view
		$this->template
				->set_layout(FALSE)
				->set('blog', $results)
				->build('admin/index');
	}
    

    /**
     * Sort images in an existing gallery
     *
     * @author Jerel Unruh - PyroCMS Dev Team
     * @access public
     */
    public function ajax_update_order()
    {
        $ids = explode(',', $this->input->post('order'));

        $i = 1;
        foreach ($ids as $id)
        {
            $this->products_images_m->update($id, array(
                'ordering' => $i
            ));
            ++$i;
        }
    }
    

    /**
     * Validate upload file name and extension.
     */
    function _check_ext()
    {
        if ( ! empty($_FILES['userfile']['name']))
        {
            $ext		= pathinfo($_FILES['userfile']['name'], PATHINFO_EXTENSION);
            $allowed	= array('bmp', 'gif', 'jpeg', 'jpg', 'jpe', 'png', 'tiff', 'tif');

            if (in_array(strtolower($ext), $allowed)){
                $this->_type	= 'i';
                $this->_ext		= implode('|', $allowed);

            }

            if ( ! $this->_ext)
            {
                $this->form_validation->set_message('_check_ext', lang('files.invalid_extension'));
                return FALSE;
            }
        }
        elseif ($this->method === 'upload')
        {
            $this->form_validation->set_message('_check_ext', lang('files.upload_error'));
            return FALSE;
        }

        return TRUE;
    }
}

