class WelcomeController < ApplicationController
  def index
    @banner_image = GalleryImage.active.where(section: 'banner').last
    @slider_images = GalleryImage.active.where(section: 'slider')
    @about_image = GalleryImage.active.where(section: 'about_section').last
    @photos = GalleryImage.active.where(section: 'photo_gallery')
    @slider_one = Content.where(content_type: 'slider_one').last
    @slider_two = Content.where(content_type: 'slider_two').last
    @slider_three = Content.where(content_type: 'slider_three').last
    @activity = Content.where(content_type: 'activities').last
    @infrastructure = Content.where(content_type: 'infrastructure').last
    @facilities = Content.where(content_type: 'facilities').last
    @welcome_section = Content.where(content_type: 'welcome_section').last
    @salient_features = Content.where(content_type: 'salient_features').last
    @teacher_count = Content.where(content_type: 'teacher_count').last
    @student_count = Content.where(content_type: 'student_count').last
    @room_count = Content.where(content_type: 'room_count').last
    @president_message = Content.where(content_type: 'president_message').last
    @director_message = Content.where(content_type: 'director_message').last
    @principal_message = Content.where(content_type: 'principal_message').last
    @principal_photo = GalleryImage.active.where(section: 'principal_photo').last
    @manager_photo = GalleryImage.active.where(section: 'manager_photo').last
    @director_photo = GalleryImage.active.where(section: 'director_photo').last
  end

  def gallery
  	@photos = GalleryImage.active.where(section: 'photo_gallery')
  end
  
  def about_us
  	@about_us = Content.where(content_type: 'about_us').last
  end

  def mission
  	
  end
  def chairman_message
  	@president_message = Content.where(content_type: 'president_message').last
  end

  def principal_message
  	@principal_message = Content.where(content_type: 'principal_message').last
  end

  def director
    @director_message = Content.where(content_type: 'director_message').last
  end

  def mandatory_public_disclosure
  end

  def contact
    
  end

  def academic_calendar
    
  end
end
