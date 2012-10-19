require 'spec_helper'


describe "Static Pages" do
  describe "Home page" do
    before { visit '/static_pages/home' }

    it "should have the content 'Sample App'" do
      page.should have_selector('h1', :text => 'Sample App') 
    end
    
    it "should have the right title" do
      page.should have_selector('title',
                                :text => " | Home") 
    end
  end

  describe "Contact page" do
    it "should have the content 'Contact'" do
      visit 'static_pages/contact'
      page.should have_selector('h1', :text => 'Contact')
    end
  end

  describe "Help page" do
    it "should have the content 'Help'" do
      visit '/static_pages/help'
      page.should have_selector('h1', :text => 'Help') 
    end
    it "should have the right title" do
      visit '/static_pages/help'
      page.should have_selector('title',
                                :text => " | Help") 
    end
  end
  
  describe "About page" do
    it "should have the content 'About Us'" do
      visit '/static_pages/about'
      page.should have_content('About Us') 
    end
  
    it "should have the right title" do
      visit '/static_pages/about'
      page.should have_selector('title',
                                :text => " | About Us") 
    end
  end
end
