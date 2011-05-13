<?php if ($products): ?>

	<?php echo form_open('admin/products/action'); ?>

	<table border="0" class="table-list">
		<thead>
			<tr>
				<th width="20"><?php echo form_checkbox(array('name' => 'action_to_all', 'class' => 'check-all')); ?></th>
				<th><?php echo lang('products_product_label'); ?></th>
				<th><?php echo lang('products_category_label'); ?></th>
				<th><?php echo lang('products_status_label'); ?></th>
				<th width="320" class="align-center"><span><?php echo lang('products_actions_label'); ?></span></th>
			</tr>
		</thead>
		<tfoot>
			<tr>
				<td colspan="6">
					<div class="inner"><?php $this->load->view('admin/partials/pagination'); ?></div>
				</td>
			</tr>
		</tfoot>
		<tbody>
			<?php foreach ($products as $product): ?>
				<tr>
					<td><?php echo form_checkbox('action_to[]', $product->id); ?></td>
					<td><?php echo $product->title; ?></td>
					<td><?php echo $product->category_title; ?></td>
					<td><?php echo lang('products_'.$product->status.'_label'); ?></td>
					<td class="align-center buttons buttons-small">
						<?php echo anchor('admin/products/preview/' . $product->id, lang($product->status == 'live' ? 'products_view_label' : 'products_preview_label'), 'rel="modal-large" class="iframe button preview" target="_blank"'); ?>
						<?php echo anchor('admin/products/edit/' . $product->id, lang('products_edit_label'), 'class="button edit"'); ?>
						<?php echo anchor('admin/products/delete/' . $product->id, lang('products_delete_label'), array('class'=>'confirm button delete')); ?>
					</td>
				</tr>
			<?php endforeach; ?>
		</tbody>
	</table>

	<div class="buttons align-right padding-top">
		<?php $this->load->view('admin/partials/buttons', array('buttons' => array('delete', 'publish'))); ?>
	</div>

	<?php echo form_close(); ?>

<?php else: ?>
	<div class="blank-slate">
		<h2><?php echo lang('products_currently_no_products'); ?></h2>
	</div>
<?php endif; ?>