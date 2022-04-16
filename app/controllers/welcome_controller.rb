class WelcomeController < ApplicationController
  def index
    @banner_image = GalleryImage.active.where(section: 'banner').last
    @slider_images = GalleryImage.active.where(section: 'slider')
    @about_image = GalleryImage.active.where(section: 'about_section').last
    @photos = GalleryImage.active.where(section: 'photo_gallery')
  end

  def gallery
  	@photos = GalleryImage.active.where(section: 'photo_gallery')
  end
  
  def about_us
  	
  end
  def mission
  	
  end
  def chairman_message
  	
  end
  def principal_message
  	
  end
  def mandatory_public_disclosure
  end

  def contact
    
  end
end
