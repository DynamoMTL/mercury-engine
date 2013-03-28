require 'spec_helper'

describe PagesController do
  include Devise::TestHelpers

  def mock_user(stubs={})
    @mock_user ||= mock_model(AdminUser, stubs).as_null_object
  end

  context "show" do
    let(:page) { stub(:page) }

    context "without params" do
      before do
        Page.should_receive(:find_by_path).with('').and_return(page)
        get :show, path: ''
      end

      specify { response.should be_success }
      specify { response.should render_template("index") }
      specify { assigns(:page).should == page }
    end

    context "with params" do
      before do
        Page.should_receive(:find_by_path).with('about/company/services').and_return(page)
        get :show, path: 'about/company/services'
      end

      specify { response.should be_success    }
      specify { assigns(:page).should == page }
    end
  end

  context "update" do
    let(:page) { mock(:page) }

    before do
      # mock up an authentication in the underlying warden library
      request.env['warden'] = mock(Warden, :authenticate => mock_user, 
                                   :authenticate! => mock_user)

      Page.should_receive(:find_or_create_by_path).with('about').and_return(page)
      page.should_receive(:update_attributes).with(content: {'title' => 'About Us', 'summary' => 'lorem ipsum'})

      post :update, path: 'about', content: {title:   {value: "About Us"},
                              summary: {value: "lorem ipsum"}}
    end

    specify { response.should be_success }
  end
end
