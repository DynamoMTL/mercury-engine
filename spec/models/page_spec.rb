require 'spec_helper'

describe Page do
  context "with hierarchy" do
    let!(:root)    { create_page(title: 'Home') }
    let!(:about)   { create_page(title: 'About', parent: root) }
    let!(:company) { create_page(title: 'Company', parent: about) }
    let(:services) { create_page(title: 'Services', parent: company) }

    context 'path' do
      specify { root.path.should == '/'}
      specify { about.path.should == '/about' }
      specify { company.path.should == '/about/company' }
      specify { services.path.should == '/about/company/services' }
    end

    context '#find_by_path' do
      context "found" do
        specify("root")                  { Page.find_by_path("").should == root }
        specify("root with slash")       { Page.find_by_path("/").should == root }
        specify("root with nil")         { Page.find_by_path(nil).should == root }
        specify("child")                 { Page.find_by_path("about").should == about }
        specify("child with slash")      { Page.find_by_path("/about").should == about }
        specify("grandchild")            { Page.find_by_path("about/company").should == company }
        specify("grandchild with slash") { Page.find_by_path("/about/company").should == company }
      end

      context "not found" do
        specify { Page.find_by_path('page-not-found').should be_nil }
      end
    end
  end

  context "#find_or_create_by_path" do
    context "root found" do
      let!(:root) { create_page(title: 'Home') }

      specify('url empty')    { Page.find_or_create_by_path("").should == root }
      specify('url is slash') { Page.find_or_create_by_path("/").should == root }
      specify('url is nil')   { Page.find_or_create_by_path(nil).should == root }
    end

    context "root no found" do
      specify('url empty')    { Page.find_or_create_by_path("").path.should == "/" }
      specify('url is slash') { Page.find_or_create_by_path("/").path.should == "/" }
      specify('url is nil')   { Page.find_or_create_by_path(nil).path.should == "/" }
    end

    context "child page found" do
      let!(:root)  { create_page(title: 'Home') }
      let!(:about) { create_page(title: 'About', parent: root) }

      specify               { Page.find_or_create_by_path("about").should == about }
      specify("with slash") { Page.find_or_create_by_path("/about").should == about }
    end

    context "child page not found" do
      context "root found" do
        let!(:root) { create_page(title: 'Home') }

        specify               { Page.find_or_create_by_path("about").parent.should == root }
        specify               { Page.find_or_create_by_path("about").path.should == '/about' }
        specify("with slash") { Page.find_or_create_by_path("/about").path.should == '/about' }
      end

      context "root not found" do
        specify               { Page.find_or_create_by_path("about").path.should == '/about' }
        specify("with slash") { Page.find_or_create_by_path("/about").path.should == '/about' }
      end
    end

    context "grandchild page found" do
      let!(:root)    { create_page(title: 'Home') }
      let!(:about)   { create_page(title: 'About', parent: root) }
      let!(:company) { create_page(title: 'Company', parent: about) }

      specify               { Page.find_or_create_by_path("about/company").parent.should == about }
      specify               { Page.find_or_create_by_path("about/company").should == company }
      specify("with slash") { Page.find_or_create_by_path("/about/company").should == company }
    end

    context "grandchild page not found" do
      specify               { Page.find_or_create_by_path("about/company").path.should == '/about/company' }
      specify("with slash") { Page.find_or_create_by_path("/about/company").path.should == '/about/company' }
    end
  end

  def create_page(attrs = {})
    default_attrs = {}
    Page.create(default_attrs.merge(attrs))
  end
end
