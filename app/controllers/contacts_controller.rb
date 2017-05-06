class ContactsController < ApplicationController
  
  # Get request to /contact-us
  # Show new contact form
  def new
    @contact = Contact.new
  end
  
  # Post request /contacts
  def create
    # Mass assignment of form fields into Contact object
    @contact = Contact.new(contact_params)
    # Save the Contact object to the database
    if @contact.save
      # Store form fields via paramaters, into variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Plug variables into Contact Mailer
      # Email method messafe ub flash hash
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message in flash hash
      # And redirect to the new action
      flash[:success] = "Message sent."
       redirect_to new_contant_path #this should be contact path I think, but c9 error suggested this instead
    else
      # If Contact object doesn't save,
      # Store errors in flash hash,
      # And redirect to the new action
      flash[:danger] = @contact.errors.full_messages.join(", ")
       redirect_to new_contact_path
    end  
  end
  
  private
    # To collect data from form, we need to use
    # Strong parameters and whitelist the form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end