require "rails_helper"

RSpec.describe PermittedContactsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/permitted_contacts").to route_to("permitted_contacts#index")
    end

    it "routes to #new" do
      expect(get: "/permitted_contacts/new").to route_to("permitted_contacts#new")
    end

    it "routes to #show" do
      expect(get: "/permitted_contacts/1").to route_to("permitted_contacts#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/permitted_contacts/1/edit").to route_to("permitted_contacts#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/permitted_contacts").to route_to("permitted_contacts#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/permitted_contacts/1").to route_to("permitted_contacts#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/permitted_contacts/1").to route_to("permitted_contacts#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/permitted_contacts/1").to route_to("permitted_contacts#destroy", id: "1")
    end
  end
end
