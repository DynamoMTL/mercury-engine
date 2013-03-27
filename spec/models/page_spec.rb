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
      specify { root.path.should be_a(Pathname)}
      specify { root.path.to_s.should == '/'}
      specify { about.path.to_s.should == '/about' }
      specify { company.path.to_s.should == '/about/company' }
      specify { services.path.to_s.should == '/about/company/services' }
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

    context "#find_by_path!" do
      context "not found" do
        it("raises error") do
          expect {
            Page.find_by_path!('aint/nobody/got/time/4/that.aspx')
          }.to raise_error(ActiveRecord::RecordNotFound)
        end
      end
      context "found" do
        it("returns page") { Page.find_by_path!('about').should == about }
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
      specify('url empty')    { Page.find_or_create_by_path("").path.to_s.should == "/" }
      specify('url is slash') { Page.find_or_create_by_path("/").path.to_s.should == "/" }
      specify('url is nil')   { Page.find_or_create_by_path(nil).path.to_s.should == "/" }
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
        specify               { Page.find_or_create_by_path("about").path.to_s.should == '/about' }
        specify("with slash") { Page.find_or_create_by_path("/about").path.to_s.should == '/about' }
      end

      context "root not found" do
        specify               { Page.find_or_create_by_path("about").path.to_s.should == '/about' }
        specify("with slash") { Page.find_or_create_by_path("/about").path.to_s.should == '/about' }
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
      specify               { Page.find_or_create_by_path("about/company").path.to_s.should == '/about/company' }
      specify("with slash") { Page.find_or_create_by_path("/about/company").path.to_s.should == '/about/company' }
    end
  end

  def create_page(attrs = {})
    default_attrs = {}
    Page.create(default_attrs.merge(attrs))
  end
end
