class PatronController < ApplicationController
  include Blacklight::Catalog
  

  before_filter :by_source_config
  before_filter :authenticate_user!
  before_filter :impersonate_user?
  layout 'no_sidebar'

  def index
    find_patron

    if params['commit'] && params['loans_renew'] && !params['loans_renew'].empty?
      @debug_entries['loans'] = []
      successful = 0
      total = params['loans_renew'].length
      params['loans_renew'].each do |db_item_key|
        resp = @patron.renew_loan(db_item_key)
        
        if resp['response']['reply_text'] == 'ok'
          successful += 1
        end
        @debug_entries['loans'] << resp
       
      end

      if total == successful
        flash[:success] = "#{total} renewed successfully."
      elsif successful > 0
        flash[:notice] = "#{successful} of #{total} renewed successfully."
      else
        flash[:error] = "Renewal failed."
      end

      @patron.reload_loans!
    end



  end


  def record_request
    find_patron

    if params['commit']
      if params['commit'].include?('recall')
        flash[:notice] = "Recall placed with #{params['recall'].inspect}"
        # do recall logic here
      elsif params['commit'].include?('hold')
        flash[:notice] = "Hold placed with #{params['hold'].inspect}"
        # do hold logic here
      end
    end

    @record_request = @patron.request_for_record(params['record_id'])
    
    params['request_type'] ||= 'recall'

    if @record_request.nil? || @record_request == {}
      flash[:error] = "Record not found."
      redirect_to patron_index_path
    else
      render
    end

  end

  private

  def find_patron
    @voyager_connection = Voyager::Connection.new(APP_CONFIG['voyager_connection'])
    @patron = Voyager::Patron.new(uni: @uni_to_lookup,  connection: @voyager_connection)

  end


  def impersonate_user?
    @uni_to_lookup = current_user.login

    if params['impersonate'] && can?(:impersonate, User)
      @uni_to_lookup = params['impersonate']
    end
  end
end
