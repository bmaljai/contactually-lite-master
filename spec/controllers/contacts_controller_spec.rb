require 'spec_helper'
require 'rails_helper'

describe ContactsController do
  describe "GET index" do
    it "gets the index view" do
      get "index"
      response.status.should be 200
    end
 
    it "gets the correct index view template" do
      get "index"
      response.should render_template("contacts/index")
    end
  end
end