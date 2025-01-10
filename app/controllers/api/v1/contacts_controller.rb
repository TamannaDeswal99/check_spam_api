class Api::V1::ContactsController < ApplicationController
    before_action :authenticate_user!

		# GET /api/v1/contacts
    # Retrieves all contacts for the authenticated user.
    def index
			contacts = current_user.contacts
			render json: contacts, status: :ok
    end

		# POST /api/v1/contacts
    # Creates a new contact associated with the authenticated user.
    def create
			contact = current_user.contacts.new(contact_params)
			if contact.save
					render json: contact, status: :created 
			else
					render json: contact.errors, status: :unprocessable_entity
			end
    end

		# PUT /api/v1/contacts/:id
    # Updates an existing contact for the authenticated user.
    def update
			contact = current_user.contacts.find_by(id: params[:id])
			if contact && contact.update(contact_params)
					render json: contact, status: :ok
			else
					render json: { error: 'Contact not found or update failed'}, status: :unprocessable_entity
			end
    end

		# GET /api/v1/contacts/:id
    # Retrieves a specific contact for the authenticated user
		def show
			contact = current_user.contacts.find_by(id: params[:id])
			if contact
				contact_details = contact.as_json(only: [:id, :name, :phone_number, :spam])
				contact_details[:email] = contact.email if user&.in_contact_list?(contact)
				render json: contact_details, status: :ok
			else
				render json: { error: 'Contact not found' }, status: :not_found
		end
  
		# DELETE /api/v1/contacts/:id
    # Deletes a specific contact for the authenticated user.
    def destroy
			contact = current_user.contacts.find_by(id: params[:id])
			if contact
				contact.destroy
				head :no_content
			else
				render json: { error: 'Contact not found'},status: :not_found
			end
    end

		# POST /api/v1/contacts/mark_as_spam
    # Marks a phone number as spam.
    def mark_as_spam
      phone_number = params[:phone_number]
      contact = Contact.find_or_initialize_by(phone_number: phone_number)
      contact.spam = true
      contact.save

      render json: { message: "#{phone_number} marked as spam."}, status: :ok
    end

		# GET /api/v1/contacts/search
    # Searches for contacts by name or phone number.
    def search
			if params[:name].present?
					contacts = Contact.where("name LIKE ?", "%#{params[:name]}%")
					contacts = contacts.sort_by{ |c| [c.name.start_with?(params[:name]), c.name]}
			elsif params[:phone_number].present?
					contacts = Contact.where(phone_number: params[:phone_number])
					if contacts.empty?
							contacts = Contact.where("phone_number LIKE ?", "%#{params[:phone_number]}%")
					end
			else
					contacts = []
			end 
			render json: contacts.as_json(only: [:id, :name, :phone_number, :spam]), status: :ok
    end

    private 

    def contact_params
      params.require(:contact).permit(:name, :phone_number, :spam)
    end
end
