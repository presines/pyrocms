<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

class Products extends Public_Controller
{
	public $limit = 5; // TODO: PS - Make me a settings option


	private $user_id 			= 0;

    private $validation_rules 	= array();
    private $rs_validation_rules 	= array();
    private $motor_validation_rules 	= array();

	public function __construct()
	{
		parent::Public_Controller();		
		$this->load->model('products_m');
		$this->load->model('products_categories_m');
		$this->load->model('products_images_m');
		$this->load->helper('text');
		$this->lang->load('products');

        //$this->template->append_metadata( css('products.css', 'products') );
	}

	// returns home starred items
	public function index()
	{	
		$this->data->products = $this->products_m->limit(10)->get_many_by(array('status' => 'live','starred'=>'home'));

		// Set meta description based on post titles
		$meta = $this->_posts_metadata($this->data->products);

		$this->template
            ->set_partial('ad_list', 'partials/starred_list')
			->title($this->module_details['name'])
			->set_breadcrumb( lang('products_products_title'))
			->set_metadata('description', $meta['description'])
			->set_metadata('keywords', $meta['keywords'])
			->build('index', $this->data);
	}
	
	public function category($slug = '')
	{	
		$slug OR redirect('products');
		
		// Get category data
		$category = $this->products_categories_m->get_by('slug', $slug) OR show_404();

        $subcategories=$this->products_categories_m->get_children($category->id);
        $products=$this->products_m->get_by_category($category->id);

        // Build the page
        $this->template->title($this->module_details['name'], $category->title )
            ->set_partial('item_list', 'partials/item_list')
            ->set_breadcrumb( lang('products_products_title'), 'products')
            ->set_breadcrumb( $category->title )
            ->set('subcategories', $subcategories)
            ->set('products', $products)
            ->set('category', $category)
            ->build('category', $this->data );
	}
	
	// Public: View an ad
	public function view($slug = '')
	{	
		if ( ! $slug or ! $product = $this->products_m->get_by('slug', $slug))
		{
			show_404();
		}
		
		if ($product->status != 'live' && ! $this->ion_auth->is_admin())
		{
			show_404();
		}

		// Grab its category
		if ($product->product_category_id && ($category = $this->products_categories_m->get($product->product_category_id)))
		{
			$product->category = $category;
		}
		// Set some defaults
		else
		{
			$product->category->id    = 0;
			$product->category->slug	 = '';
			$product->category->title = '';
		}

		if($query	= $this->products_images_m->get_images($product->id)) {
            $product_images=$query->result();
        } else {
            $product_images=array();
        }
		
		$this->session->set_flashdata(array('referrer' => $this->uri->uri_string));

		$this->template->title($product->title, lang('products_products_title'))
			->set_metadata('keywords', $product->category->title.' '.$product->title)
			->set_breadcrumb(lang('products_products_title'), 'products');
		
		if ($product->category->id > 0)
		{
			$this->template->set_breadcrumb($product->category->title, 'products/category/'.$product->category->slug);
		}
		
		$this->template
			->set_breadcrumb($product->title)
            ->set_partial('detail_1_thumbs', 'partials/detail_1_thumbs')
			->set('product', $product)
            ->set('images', $product_images)
			->build('view', $this->data);
	}	

    public function search(){
        // Count total products and work out how many pages exist
        $x= $_SERVER['REQUEST_URI'];
        $pagination = create_pagination('products/search/n', $this->products_m->count_by($_GET), NULL, 4);

        // Get the current page of blog posts
        $products = $this->products_m->limit($pagination['limit'])->get_many_by($_GET);

        // Set meta description based on post titles
        $meta = $this->_posts_metadata($products);


        // Build the page
        $this->template->title($this->module_details['name'], 'Buscar' )
            ->set_partial('ad_list', 'partials/sorted_list')
            ->set_metadata('description', $meta['description'] )
            ->set_breadcrumb( lang('products_products_title'), 'products')
            ->set_breadcrumb( 'Buscar' )
            ->set('products', $products)
            ->set('pagination', $pagination)
            ->build('search', $this->data );

    }

    function create(){
        // set validation rules and load modules
        $this->_set_form_data();
        $upload_errors=null;

        $category_id=$this->input->post('product_category_id');
        if($contract= $this->products_prices_m->get_by_duration_and_category($this->input->post('duration'),$category_id)) {
            $expiration_date= date("Y-m-d",strtotime($this->input->post('start_date') . ' + ' . $contract->days . ' day + ' . $contract->weeks . ' week + ' . $contract->months . ' month'));
            $payment_price=$this->get_ad_price($category_id,$this->input->post('duration'),$this->input->post('starred'));
        } else {
            $expiration_date=null;
            $payment_price=null;
        }


		if ($this->form_validation->run()
            and ($images_data=$this->upload_images())
            and (!$upload_errors=$this->upload->display_errors())){

			$id = $this->products_m->insert(array(
				'product_category_id'    => $category_id,
				'user_id'		    => $this->user_id,
				'title'				=> $this->input->post('title'),
				'body'				=> $this->input->post('body'),
				'first_name'		=> $this->input->post('first_name'),
				'last_name'			=> $this->input->post('last_name'),
				'address_1'			=> $this->input->post('address_1'),
				'address_2'			=> $this->input->post('address_2'),
				'city'	    		=> $this->input->post('city'),
				'state'		    	=> $this->input->post('state'),
				'phone'			    => $this->input->post('phone'),
				'email'			    => $this->input->post('email'),
				'show_address'			=> $this->input->post('show_address'),
				'show_phone'			=> $this->input->post('show_phone'),
				'show_email'			=> $this->input->post('show_email'),
				'start_date'			=> $this->input->post('start_date'),
                'expiration_date'       => $expiration_date,
				'starred'			    => $this->input->post('starred'),
				'payment_type'	    	=> $this->input->post('payment_type'),
                'payment_price'         => $payment_price,
				'ad_price'  			=> $this->input->post('ad_price'),
				'ad_city'	    		=> $this->input->post('ad_city'),
				'ad_state'		    	=> $this->input->post('ad_state'),
				'ad_price'			    => $this->input->post('ad_price'),
				'ad_rs_property_type'	=> $this->input->post('ad_rs_property_type'),
				'ad_rs_offer_type'		=> $this->input->post('ad_rs_offer_type'),
				'ad_motor_make'			=> $this->input->post('ad_motor_make'),
				'ad_motor_model'		=> $this->input->post('ad_motor_model'),
				'ad_motor_year'			=> $this->input->post('ad_motor_year'),
				'created_on'		=> date("Y-m-d",now())
			));

			if ($id)
			{
                //Save uploaded files to database
                foreach($images_data as $img){
                    $this->products_images_m->insert(array(
                        'ad_id'=>$id,
                        //'name'=>
                        'filename'=>$img['file_name'],
                        //'description=>
                        'extension'=>$img['file_ext'],
                        'mimetype'=>$img['file_type'],
                        'width'=>$img['image_width'],
                        'height'=>$img['image_height'],
                        'filesize'=>$img['file_size']
                    ));
                }
				$this->session->set_flashdata('success', sprintf($this->lang->line('products_add_success'), $this->input->post('title')));
			}
			else
			{
				$this->session->set_flashdata('error', $this->lang->line('products_add_error'));
			}

			// Redirect to the payment page
			redirect('products/payment/' . $id);
		}
		else
		{
			// Go through all the known fields and get the post values
			foreach ($this->validation_rules as $key => $field)
			{
				$post->$field['field'] = set_value($field['field']);
			}

            //Manually set some fields that have default values:
            $post->state = set_value('state',"Nuevo León");
            $post->city = set_value('city',"Monterrey");

            $user = $this->ion_auth->get_user();
            $post->first_name = set_value('first_name',$user->first_name);
            $post->last_name = set_value('last_name',$user->last_name);
            $post->phone = set_value('phone',$user->phone);
            $post->email = set_value('email',$user->email);

            $post->ad_state = set_value('ad_state',"Nuevo León");
            $post->ad_city = set_value('ad_city',"Monterrey");

            $post->product_category_id=set_value('product_category_id',1);

            $this->data['category_options']=$this->products_categories_m->options_list();
            $this->data['state_options']=$this->products_fields_m->states_list();
            $this->data['starred_options']=array('no'=>'Sólo en listado','section'=>'Destacado en la categoría','home'=>'Destacado en la portada y categoría');
            $this->data['payment_options']=array('bank'=>'Depósito o transferencia bancaria');
            $this->data['property_type_options']=$this->products_fields_m->values_list('ad_rs_property_type');
            $this->data['offer_type_options']=$this->products_fields_m->values_list('ad_rs_offer_type');
            $this->data['duration_options']=$this->products_prices_m->options_list_by_category($post->product_category_id);
            $this->data['payment_price']=$payment_price;

            $this->data['error_string']=validation_errors().$upload_errors;
		}

		$this->template
				->title($this->module_details['name'],'Contratar')
				->append_metadata(js('products_form.js', 'products'))
                ->set('error_string',validation_errors())
				->set('post', $post)
				->build('create',$this->data);
	}



    /******** images  ********/

    public function thumbnail($filename){
        if($img=$this->products_images_m->get_by('filename',$filename)){
            return $this->image($img->id,273,1000);
        } else {
            header('Content-type: image/gif');
            readfile(FCPATH .'addons/modules/products/img/noimage96.gif');
        }
    }

    public function header_image($filename){
        if($img=$this->products_images_m->get_by('filename',$filename)){
            return $this->image($img->id,585,400);
        } else {
            header('Content-type: image/gif');
            readfile(FCPATH .'addons/modules/products/img/noimage96.gif');
        }
    }

	public function full_image($filename){
        if($img=$this->products_images_m->get_by('filename',$filename)){
            return $this->image($img->id,NULL,NULL);
        } else {
            header('Content-type: image/gif');
            readfile(FCPATH .'addons/modules/products/img/noimage96.gif');
        }
	}

	public function image($id, $width, $height){
		$this->load->model('products_images_m');

		$file = $this->products_images_m->get($id) OR show_404();

		if ( ! is_dir(APPPATH . 'cache/products_images/'))
		{
			mkdir(APPPATH . 'cache/products_images/');
		}

		// Path to image thumbnail
		$image_thumb = APPPATH . 'cache/products_images/' . $height . '_' . $width . '_' . md5($file->filename) . $file->extension;

		if ( ! file_exists($image_thumb))
		{
			// LOAD LIBRARY
			$this->load->library('image_lib');

			// CONFIGURE IMAGE LIBRARY
			$config['image_library']    = 'gd2';
			$config['source_image']     = 'uploproducts/products/images/' . $file->filename;
			$config['new_image']        = $image_thumb;
			$config['maintain_ratio']   = TRUE;
			$config['height']           = $height;
			$config['width']            = $width;
			$this->image_lib->initialize($config);
			$this->image_lib->resize();
			$this->image_lib->clear();
		}

		header('Content-type: ' . $file->mimetype);
		readfile($image_thumb);
	}


	// Private methods not used for display

    private function get_ad_price($category_id, $duration, $starred){
        if($contract= $this->products_prices_m->get_by_duration_and_category($duration,$category_id)) {
            switch($starred){
                case 'no':
                    $payment_price=$contract->price;
                    break;
                case 'section':
                    $payment_price=$contract->price_star_section;
                    break;
                case 'home':
                    $payment_price=$contract->price_star_home;
                    break;
            }
            return $payment_price;
        } else {
            return null;
        }
    }

    private function _set_form_data(){
        // Get the user ID, if it exists
        if($user = $this->ion_auth->get_user())
        {
            $this->user_id = $user->id;
        }

        // The user is not logged in, send them to login page
        if(!$this->ion_auth->logged_in())
        {
            redirect('users/login');
        }

        $this->load->helper('user');
        $this->load->helper('date');

        $this->load->library('form_validation');

        // Validation rules - git is really pissing me off right now
        $this->validation_rules = array(
            array(
                'field' => 'first_name',
                'label' => 'nombre',
                'rules' => 'required|trim|alph_anumeric|callback_ad_valid'
            ),
            array(
                'field' => 'last_name',
                'label' => 'apellido',
                'rules' => 'required|trim|alph_anumeric'
            ),
            array(
                'field' => 'address_1',
                'label' => 'Dirección',
                'rules' => 'trim|xss_clean'
            ),
            array(
                'field' => 'address_2',
                'label' => 'Colonia',
                'rules' => 'trim|xss_clean'
            ),
            array(
                'field' => 'state',
                'label' => 'Estado',
                'rules' => 'trim|alph_anumeric'
            ),
            array(
                'field' => 'city',
                'label' => 'Municipio',
                'rules' => 'trim|alph_anumeric'
            ),
            array(
                'field' => 'phone',
                'label' => 'telefono',
                'rules' => 'required|trim|alpha_numeric|max_length[20]|min_length[10]'
            ),
            array(
                'field' => 'email',
                'label' => 'Email',
                'rules' => 'required|trim|valid_email'
            ),
            array(
                'field' => 'title',
                'label' => 'Articulo',
                'rules' => 'required|trim|xss_clean'
            ),
            array(
                'field' => 'product_category_id',
                'label' => 'categoría',
                'rules' => 'required|trim'
            ),
            array(
                'field' => 'ad_rs_property_type',
                'label' => 'Inmueble',
                'rules' => 'trim'
            ),
            array(
                'field' => 'ad_rs_offer_type',
                'label' => 'Venta/Renta',
                'rules' => 'trim'
            ),
            array(
                'field' => 'ad_state',
                'label' => 'Estado',
                'rules' => 'trim|alph_anumeric'
            ),
            array(
                'field' => 'ad_city',
                'label' => 'Municipio',
                'rules' => 'trim|alph_anumeric'
            ),
            array(
                'field' => 'ad_motor_make',
                'label' => 'Marca',
                'rules' => 'trim|'
            ),
            array(
                'field' => 'ad_motor_model',
                'label' => 'Modelo',
                'rules' => 'trim|'
            ),
            array(
                'field' => 'ad_motor_year',
                'label' => 'Año',
                'rules' => 'trim|is_natural_no_zero|max_length[4]'
            ),
            array(
                'field' => 'ad_price',
                'label' => 'Precio',
                'rules' => 'callback_clean_decimal|decimal'
            ),
            array(
                'field' => 'show_address',
                'label' => 'Mostrar direccion',
                'rules' => 'trim|max_length[1]'
            ),
            array(
                'field' => 'show_phone',
                'label' => 'Mostrar telefono',
                'rules' => 'trim|max_length[1]'
            ),
            array(
                'field' => 'show_email',
                'label' => 'Mostrar correo',
                'rules' => 'trim|max_length[1]'
            ),
            array(
                'field' => 'body',
                'label' => 'Descripcion',
                'rules' => 'trim|max_length[1000]'
            ),
			array(
				'field' => 'start_date',
				'label' => 'Fecha inicio',
				'rules' => 'trim|required'
			),
            array(
                'field' => 'duration',
                'label' => 'Duración',
                'rules' => 'trim'
            ),
            array(
                'field' => 'starred',
                'label' => 'Colocación',
                'rules' => 'trim'
            ),
            array(
                'field' => 'payment_type',
                'label' => 'Modo de pago',
                'rules' => 'trim'
            )
        );

        //Ad special category cases

        // Set the validation rules
        $this->form_validation->set_rules($this->validation_rules);
    }

    function ad_valid($str){
        $ret=true;

        //Checa los campos especiales.
        switch($this->input->post('product_category_id')){
            case 1:
                $s=trim($this->input->post('ad_rs_property_type'));
                if(!$this->input->post('ad_rs_property_type') or empty($s  )){
                    $this->form_validation->set_message('ad_valid','Son requeridos el tipod e inmueble y oferta');
                    $ret=false;
                }
                $s=trim($this->input->post('ad_rs_offer_type'));
                if(!$this->input->post('ad_rs_offer_type') or empty($s  )){
                    $this->form_validation->set_message('ad_valid','Son requeridos el tipod e inmueble y oferta');
                    $ret=false;
                }
                break;
            case 2:
                $s=trim($this->input->post('ad_motor_make'));
                if(!$this->input->post('ad_motor_make') or empty($s  )){
                    $this->form_validation->set_message('ad_valid','Son requeridos el modelo, marca y año del vehiculo');
                    $ret=false;
                }
                $s=trim($this->input->post('ad_motor_model'));
                if(!$this->input->post('ad_motor_model') or empty($s  )){
                    $this->form_validation->set_message('ad_valid','Son requeridos el modelo, marca y año del vehiculo');
                    $ret=false;
                }
                $s=trim($this->input->post('ad_motor_year'));
                if(!$this->input->post('ad_motor_year') or empty($s  )){
                    $this->form_validation->set_message('ad_valid','Son requeridos el modelo, marca y año del vehiculo');
                    $ret=false;
                }
                break;
        }
        //Checa que hayan escogido una duración válida para la categoría.
        if(!$contract= $this->products_prices_m->get_by_duration_and_category($this->input->post('duration'),$this->input->post('product_category_id'))){
            $this->form_validation->set_message('ad_valid','La duración seleccionada no es válida en esta categoría.');
            $ret=false;
        }
        return $ret;
    }

    function clean_decimal($str){
        $str=str_replace(',', '', str_replace('$', '', str_replace(' ', '', $str)));
        if(!strpos($str,'.')){
            $str=$str . '.00';
        }
        return $str;
    }

    private function upload_images(){
      $images_data=array();
      /* Create the config for upload library */
      /* (pretty self-explanatory) */
      $config['upload_path'] = FCPATH .'uploproducts/products_images/'; /* NB! create this dir! */
      $config['allowed_types'] = 'gif|jpg|png|jpeg';
      $config['max_size']  = '2048';
      $config['max_width']  = '0';
      $config['max_height']  = '0';
      /* Load the upload library */
      $this->load->library('upload', $config);

      /* Create the config for image library */
      /* (pretty self-explanatory) */
      $configThumb = array();
      $configThumb['image_library'] = 'gd2';
      $configThumb['source_image'] = '';
      $configThumb['create_thumb'] = false;
      $configThumb['maintain_ratio'] = TRUE;
      /* Set the height and width or thumbs */
      /* Do not worry - CI is pretty smart in resizing */
      /* It will create the largest thumb that can fit in those dimensions */
      /* Thumbs will be saved in same upload dir but with a _thumb suffix */
      /* e.g. 'image.jpg' thumb would be called 'image_thumb.jpg' */
      $configThumb['width'] = 600;
      $configThumb['height'] = 480;
      /* Load the image library */
      $this->load->library('image_lib');

      for($i = 1; $i <=8; $i++) {
        /* Handle the file upload */
        if (empty($_FILES['image'.$i]['name'])){
            continue;
        }
        $upload = $this->upload->do_upload('image'.$i);
        /* File failed to upload - continue */
        if($upload === FALSE) continue;
        /* Get the data about the file */
        $data = $this->upload->data();
        $images_data[]=$data;

        $uploadedFiles[$i] = $data;
        /* If the file is an image - resize it */
        if($data['is_image'] == 1) {
          $configThumb['source_image'] = $data['full_path'];
          $this->image_lib->initialize($configThumb);
          $this->image_lib->resize();
        }
      }
      return $images_data;
    }



	// Private methods not used for display
	private function _posts_metadata(&$posts = array())
	{
		$keywords = array();
		$description = array();

		// Loop through posts and use titles for meta description
		if(!empty($posts))
		{
			foreach($posts as &$post)
			{
				if($post->category_title)
				{
					$keywords[$post->product_category_id] = $post->category_title .', '. $post->category_slug;
				}
				$description[] = $post->title;
			}
		}

		return array(
			'keywords' => implode(', ', $keywords),
			'description' => implode(', ', $description)
		);
	}

}