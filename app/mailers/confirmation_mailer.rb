class ConfirmationMailer < ApplicationMailer
    def confirm_email(target_email, activation_token)
        @activation_token = activation_token
        mail(:to => target_email,
            :from => "arancarr@gmail.com",
            :subject => "[Activation - Rails 4]") do |format|
                format.html { render 'confirm_email'}
            end
    end
end