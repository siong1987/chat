class ChatController < ApplicationController
  protect_from_forgery :except => :send_data
  
  def index
  end
  
  def send_data
    Juggernaut.send_to_channels_without_sign(params[:chat_input], ['iphone'])
    
    render :juggernaut => {:type => :send_to_channels, :channels => ['web']} do |page|
      page.insert_html :top, 'chat_data', "<li>#{h params[:chat_input]}</li>"
    end
    render :nothing => true
  end
end