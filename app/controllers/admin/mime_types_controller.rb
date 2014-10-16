class Admin::MimeTypesController < Admin::BaseController
  def index
    @mime_type_categories = MimeTypeCategory.all
  end

  def update
    begin
      mime_type = MimeType.find(params[:id])
      mime_type.update_attributes!(params[:mime_type])
      mime_type.stored_files.each(&:index)
      Sunspot.commit
      render :json => "Successfully updated!"
    rescue Exception => e
      render :json => e.to_s, :status => :error
      log_exception e
    end
  end
end
