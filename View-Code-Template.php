		    <?php if($hybrid_auth_enabled) { ?>
			  <div class="well">
				<?php foreach($providers as $provider) { ?>
					<div class="row">
					  <p>
			            <div class="col-sm-6">
					      <a class="<?php echo $provider['aClass']; ?>" href="<?php echo $provider['href']; ?>">  
					        <i class="<?php echo $provider['iClass']; ?>"></i>
					        <?php echo $provider['loginText']; ?>  
					      </a>
					    </div>
				      </p> 	
				    </div>  
			    <?php } ?>
			  </div>  
			<?php } ?>
