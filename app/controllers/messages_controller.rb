class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  before_filter :load_messages
  
  def load_messages
    @messages = Message.paginate :conditions => ['is_approved', 1], :page => params[:page], :per_page => 20, :order => 'created_at DESC' 
  end
   
  def index
    @message = Message.new

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end
  
  # GET /messages/1
  # GET /messages/1.xml
  def show
    @message = Message.find(params[:id])
    @title = @message.subject
    
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @message }
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
        flash[:notice] = 'Thank you! Message posted. Awaiting approval...'
        format.html { redirect_to(@message) }
        format.xml  { render :xml => @message, :status => :created, :location => @message }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
      end
    end
  end

end
