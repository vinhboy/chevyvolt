class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  before_filter :load_messages
  
  def load_messages
    @messages = Message.paginate :conditions => ['is_approved', 1], :page => params[:page], :per_page => 5, :order => 'created_at DESC' 
  end
   
  def index
    @message = Message.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @message = Message.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @message }
    end
  end

  # POST /messages
  # POST /messages.xml
  def create
    @message = Message.new(params[:message])
    respond_to do |format|
      if @message.save && verify_recaptcha(:model => @message)
        flash[:notice] = 'Message posted.'
        format.html { redirect_to root_url }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "index" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

end
