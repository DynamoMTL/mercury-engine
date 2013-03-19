require 'spec_helper'

describe Page do
  context 'validity' do
    it { should validate_presence_of   :title }
    it { should validate_uniqueness_of :title }
  end

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

    context 'find by path' do
      context "found" do
        specify("root")                  { Page.find_by_path("").should == root }
        specify("root with slash")       { Page.find_by_path("/").should == root }
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

  def create_page(attrs = {})
    default_attrs = {}
    Page.create(default_attrs.merge(attrs))
  end
end
