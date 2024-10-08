require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/permitted_contacts", type: :request do
  
  # This should return the minimal set of attributes required to create a valid
  # PermittedContact. As you add validations to PermittedContact, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      PermittedContact.create! valid_attributes
      get permitted_contacts_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      permitted_contact = PermittedContact.create! valid_attributes
      get permitted_contact_url(permitted_contact)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_permitted_contact_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "renders a successful response" do
      permitted_contact = PermittedContact.create! valid_attributes
      get edit_permitted_contact_url(permitted_contact)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new PermittedContact" do
        expect {
          post permitted_contacts_url, params: { permitted_contact: valid_attributes }
        }.to change(PermittedContact, :count).by(1)
      end

      it "redirects to the created permitted_contact" do
        post permitted_contacts_url, params: { permitted_contact: valid_attributes }
        expect(response).to redirect_to(permitted_contact_url(PermittedContact.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new PermittedContact" do
        expect {
          post permitted_contacts_url, params: { permitted_contact: invalid_attributes }
        }.to change(PermittedContact, :count).by(0)
      end

    
      it "renders a response with 422 status (i.e. to display the 'new' template)" do
        post permitted_contacts_url, params: { permitted_contact: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested permitted_contact" do
        permitted_contact = PermittedContact.create! valid_attributes
        patch permitted_contact_url(permitted_contact), params: { permitted_contact: new_attributes }
        permitted_contact.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the permitted_contact" do
        permitted_contact = PermittedContact.create! valid_attributes
        patch permitted_contact_url(permitted_contact), params: { permitted_contact: new_attributes }
        permitted_contact.reload
        expect(response).to redirect_to(permitted_contact_url(permitted_contact))
      end
    end

    context "with invalid parameters" do
    
      it "renders a response with 422 status (i.e. to display the 'edit' template)" do
        permitted_contact = PermittedContact.create! valid_attributes
        patch permitted_contact_url(permitted_contact), params: { permitted_contact: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested permitted_contact" do
      permitted_contact = PermittedContact.create! valid_attributes
      expect {
        delete permitted_contact_url(permitted_contact)
      }.to change(PermittedContact, :count).by(-1)
    end

    it "redirects to the permitted_contacts list" do
      permitted_contact = PermittedContact.create! valid_attributes
      delete permitted_contact_url(permitted_contact)
      expect(response).to redirect_to(permitted_contacts_url)
    end
  end
end
