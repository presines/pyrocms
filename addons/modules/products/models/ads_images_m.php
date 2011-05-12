<?php  defined('BASEPATH') OR exit('No direct script access allowed');
class Ads_images_m extends MY_Model {

	protected $_table = 'ads_images';
    protected $images_folder='uploads/ads_images';


    public function get_ad_first($ad_id){
		$this->db->where(array('ad_id' => $ad_id));
		return $this->db->get($this->_table)->row();
    }

    public function get_images_by_ad($ad_id){
		$this->db->where(array('ad_id' => $ad_id));
		return $this->db->get($this->_table);
    }
	// ------------------------------------------------------------------------

	/**
	 * Exists
	 *
	 * Checks if a given file exists.
	 *
	 * @access	public
	 * @param	int		The file id
	 * @return	bool	If the file exists
	 */
	public function exists($file_id)
	{
		return (bool) (parent::count_by(array('id' => $file_id)) > 0);
	}

	// ------------------------------------------------------------------------

	/**
	 * Delete a file
	 *
	 * Deletes a single file by its id and remove it from the db.
	 *
	 * @params	int	The file id
	 * @return 	bool
	 */
	public function delete($id)
	{
		$this->load->helper('file');

		if ( ! $image = parent::get($id))
		{
			return FALSE;
		}

		@unlink(FCPATH.'/' . $this->images_folder.'/'.$image->filename);

		parent::delete($image->id);

		return TRUE;
	}

	// ------------------------------------------------------------------------

	/**
	 * Delete a file
	 *
	 * Deletes a single file by its id
	 *
	 * @params	int	The file id
	 * @return 	bool
	 */
	public function delete_file($id)
	{
		$this->load->helper('file');

		if ( ! $image = parent::get($id))
		{
			return FALSE;
		}

		@unlink(FCPATH.'/' . $this->images_folder.'/'.$image->filename);

		return TRUE;
	}

	// ------------------------------------------------------------------------

	/**
	 * Delete multiple files
	 *
	 * Delete all files contained within a folder.
	 *
	 * @params int	Folder id
	 * @return void
	 */
	public function delete_files($folder_id)
	{
		$this->load->helper('file');

		$image = parent::get_many_by(array('folder_id' => $folder_id));

		if ( ! $image)
		{
			return FALSE;
		}

		foreach ($image as $item)
		{
			@unlink(FCPATH.'/' . $this->images_folder.'/'.$item->filename);
			parent::delete($item->id);
		}

		return TRUE;
	}
}

/* End of file ads_images_m.php */