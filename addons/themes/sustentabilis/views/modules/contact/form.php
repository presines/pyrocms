    <?php if (validation_errors()): ?>
    <div class="error-box">
        <?php echo validation_errors(); ?>
    </div>
    <?php elseif (isset($messages['error'])): ?>
    <div class="error-box">
        <p><?php echo $messages['error']; ?></p>
    </div>
    <?php endif; ?>
    <?php echo form_open(current_url());?>
        <li>
            <label for="contact_name">nombre:</label>
            <?php echo form_input('contact_name', $form_values->contact_name);?>
        </li>
        <li>
            <label for="contact_email">email:</label>
            <?php echo form_input('contact_email', $form_values->contact_email);?>
        </li>
        <li>
            <label for="company_name">compañía:</label>
            <?php echo form_input('company_name', $form_values->company_name);?>
        </li>
        <li>
            <label for="message">mensaje:</label>
            <?php echo form_textarea('message', $form_values->message, 'id="message"'); ?>
        </li>
        <!-- No nos interesan pero typoCMS lo pide -->
        <input type="hidden" name="subject" value="." />
        <input id="other_subject" name="other_subject" type="hidden"  value="." />
        <li class="form_buttons">
            <input class="submit" type="submit" value="enviar" name="btnSubmit" />
        </li>
    <?php echo form_close(); ?>