class ContactsController < ApiController
  
    # POST /contacts
    def create
        @contact = Contact.new(contact_params)
          if @contact.save
            render json: @contact, status: :created
          else
            render json: {:error => "All fields are required!"}, status: :unprocessable_entity
          end
    end
  
    private
      # Only allow a trusted parameter "white list" through.
      def contact_params
        params.require(:contact).permit(:name, :email, :message, :phone)
      end

  end
  