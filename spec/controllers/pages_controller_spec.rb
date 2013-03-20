require 'spec_helper'

describe PagesController do

  context "show" do
    let(:page) { stub(:page, template_path: 'test') }

    context "without params" do
      before do
        Page.should_receive(:find_by_path!).with(nil).and_return(page)
        get :show
      end

      specify { response.should be_success    }
      specify { assigns(:page).should == page }
    end

    context "with params" do
      before do
        Page.should_receive(:find_by_path!).with('about/company/services').and_return(page)
        get :show, path: 'about/company/services'
      end

      specify { response.should be_success    }
      specify { assigns(:page).should == page }
    end
  end

  context "update" do
    let(:page) { mock(:page) }

    before do
      Page.should_receive(:find_by_path!).and_return(page)
      page.should_receive(:update_attributes).with(content: {title: 'About Us', summary: 'lorem ipsum'})

      post :update, content: {title:   {value: "About Us"},
                              summary: {value: "lorem ipsum"}}
    end

    specify { response.should be_success }
  end
end
