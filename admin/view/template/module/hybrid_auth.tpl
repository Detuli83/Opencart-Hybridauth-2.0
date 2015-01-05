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

 ?>

<?php echo $header; ?><?php echo $column_left; ?>

<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <div class="pull-right">
        <button type="submit" form="form-category" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
        <a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
      <h1><?php echo $heading_title; ?></h1>
      <ul class="breadcrumb">
        <?php foreach ($breadcrumbs as $breadcrumb) { ?>
        <li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
        <?php } ?>
      </ul>
	</div>
  </div>

  <div class="container-fluid">
    <?php if ($error_warning) { ?>
    <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
      <button type="button" class="close" data-dismiss="alert">&times;</button>
    </div>
    <?php } ?>
	
    <div class="panel panel-default">
      <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
      </div>
      <div class="panel-body">
        <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-hybrid-auth" class="form-horizontal">
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-status"><?php echo $entry_status; ?></label>
            <div class="col-sm-10">
              <select name="hybrid_auth_status" id="input-status" class="form-control">
                <?php if ($hybrid_auth_status) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
          <div class="form-group">
            <label class="col-sm-2 control-label" for="input-debug"><?php echo $entry_debug; ?></label>
            <div class="col-sm-10">
              <select name="hybrid_auth_debug" id="input-debug" class="form-control">
                <?php if ($hybrid_auth_debug) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                <?php } ?>
              </select>
            </div>
          </div>
		  
		  <table id="module" class="table table-striped table-bordered table-hover">
            <thead>
              <tr>
                <td class="col-sm-1 text-left"><?php echo $entry_provider; ?></td>
                <td class="col-sm-1 text-left"><?php echo $entry_status; ?></td>
                <td class="col-sm-2 text-left"><?php echo $entry_key; ?></td>
                <td class="col-sm-2 text-left"><?php echo $entry_secret; ?></td>
                <td class="col-sm-3 text-left"><?php echo $entry_scope; ?></td>
                <td class="col-sm-1 text-left"><?php echo $entry_css_class; ?></td>
                <td class="col-sm-1 text-right"><?php echo $entry_sort_order; ?></td>
				<td></td>
  			  </tr>
            </thead>
			
            <tbody>
              <?php foreach ($hybrid_auth_items as $key => $hybrid_auth) { ?>
              <tr id="module-row<?php echo $key; ?>">
			    <td class="text-left">
                  <select name="hybrid_auth_module[<?php echo $key; ?>][provider]" class="form-control" >
                     <?php foreach ($providers as $provider) { ?>
                       <?php if ($provider == $hybrid_auth['provider']) { ?>
                         <option value="<?php echo $provider; ?>" selected="selected"><?php echo $provider; ?></option>
                       <?php } else { ?>
                         <option value="<?php echo $provider; ?>"><?php echo $provider; ?></option>
                       <?php } ?>
                     <?php } ?>
                  </select>
				</td>
                <td class="text-left">
                  <select name="hybrid_auth_module[<?php echo $key; ?>][enabled]" class="form-control" >
                    <?php if ($hybrid_auth['enabled']) { ?>
                       <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                       <option value="0"><?php echo $text_disabled; ?></option>
                    <?php } else { ?>
                       <option value="1"><?php echo $text_enabled; ?></option>
                       <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                    <?php } ?>
                  </select>
                </td>
                <td class="text-left"><input type="text" name="hybrid_auth_module[<?php echo $key; ?>][key]" value="<?php echo $hybrid_auth['key']; ?>" class="form-control" /></td>
                <td class="text-left"><input type="text" name="hybrid_auth_module[<?php echo $key; ?>][secret]" value="<?php echo $hybrid_auth['secret']; ?>" class="form-control" /></td>
                <td class="text-left"><input type="text" name="hybrid_auth_module[<?php echo $key; ?>][scope]" value="<?php echo $hybrid_auth['scope']; ?>" class="form-control" /></td>
                <td class="text-left"><input type="text" name="hybrid_auth_module[<?php echo $key; ?>][css_class]" value="<?php echo $hybrid_auth['css_class']; ?>" class="form-control" /></td>
                <td class="text-left"><input type="text" name="hybrid_auth_module[<?php echo $key; ?>][sort_order]" value="<?php echo $hybrid_auth['sort_order']; ?>" class="form-control" /></td>
				<td class="text-left">
				   <button type="button" onclick="$('#module-row<?php echo $key; ?>').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger">
				     <i class="fa fa-minus-circle"></i>
				   </button>
				</td>
              </tr>
              <?php } ?>
            </tbody>
            <tfoot>
              <tr>
                <td colspan="6"></td>
                <td class="text-left"><button type="button" onclick="addRow();" data-toggle="tooltip" title="<?php echo $button_add_row; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
              </tr>
            </tfoot>
		  </table>
        </form>
      </div>
    </div>
  </div>  
</div>

<script type="text/javascript"><!--
function addRow() {

	var token = Math.random().toString(36).substr(2);
	
	html  = '<tr id="module-row' + token + '">';
	html += '    <td class="text-left">';
    html += '      <select name="hybrid_auth_module[' + token + '][provider]" class="form-control">';
                   <?php foreach ($providers as $provider) { ?>
    html += '        <option value="<?php echo $provider; ?>"><?php echo $provider; ?></option>';
                   <?php } ?>
    html += '      </select>';
    html += '    </td>';
	html += '    <td class="text-left">';
    html += '      <select name="hybrid_auth_module[' + token + '][enabled]" class="form-control">';
    html += '        <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '        <option value="0"><?php echo $text_disabled; ?></option>';
    html += '      </select>';
    html += '    </td>';
	html += '    <td class="text-left"><input type="text" name="hybrid_auth_module[' + token + '][key]" class="form-control" /></td>';
	html += '    <td class="text-left"><input type="text" name="hybrid_auth_module[' + token + '][secret]" class="form-control" /></td>';
	html += '    <td class="text-left"><input type="text" name="hybrid_auth_module[' + token + '][scope]" class="form-control" /></td>';
	html += '    <td class="text-left"><input type="text" name="hybrid_auth_module[' + token + '][css_class]" class="form-control" /></td>';
	html += '    <td class="text-left"><input type="text" name="hybrid_auth_module[' + token + '][sort_order]" class="form-control" /></td>';
	html += '    <td class="text-left"><button type="button" onclick="$(\'#module-row' + token + '\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button></td>';
	html += '</tr>';
	
	$('#module tbody').append(html);

}
//--></script>

<?php echo $footer; ?>