class AboutUsController < ApplicationController
  def index
    @about = About.first
  end

  def contact
    @about = About.first
  end
end
