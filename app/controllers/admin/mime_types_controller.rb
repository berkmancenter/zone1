class Admin::MimeTypesController < Admin::BaseController
  def index
    @mime_type_categories = MimeTypeCategory.all
  end

  def update
    begin
      MimeType.find(params[:id]).update_attributes!(params[:mime_type])
      render :json => "Successfully updated!"
    rescue Exception => e
      render :json => e.to_s, :status => :error
      log_exception e
    end
  end
 
end
