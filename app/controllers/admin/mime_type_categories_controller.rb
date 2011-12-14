class Admin::MimeTypeCategoriesController < Admin::BaseController
  def index
    @mime_type_categories = MimeTypeCategory.all
    @mime_type_category = MimeTypeCategory.new
  end

  def create
    begin
      mime_type_category = MimeTypeCategory.new(params[:mime_type_category])
      if mime_type_category.save
        flash[:notice] = "created!"
        redirect_to edit_admin_mime_type_category_path(mime_type_category)
      else
        flash[:error] = "Errors #{mime_type_category.errors.full_messages.join(', ')}"
        redirect_to admin_mime_type_categories_path
      end
    rescue Exception => e
      flash[:error] = "problems creating. try again."
      log_exception e
      redirect_to admin_mime_type_categories_path
    end
  end

  def update
    begin
      mime_type_category = MimeTypeCategory.find(params[:id])
      mime_type_category.icon = params[:icon] if params[:icon].present?
      mime_type_category.update_attributes(params[:mime_type_category])
      flash[:notice] = "updated!"
      #TODO can't we just render :edit here if we also set @mime_type_category and get @right ?
      redirect_to edit_admin_mime_type_category_path(mime_type_category)
    rescue Exception => e
      flash[:error] = "Problems updating! Please try again. #{e}"
      log_exception e
      redirect_to edit_admin_mime_type_category_path(mime_type_category)
    end
  end

  def show
    redirect_to edit_admin_mime_type_category_path(params[:id])
  end

  def edit
    @mime_type_category = MimeTypeCategory.find(params[:id])
    @right = Right.find_by_action("toggle_#{@mime_type_category.name.downcase}")
  end

  def destroy
    MimeTypeCategory.delete(params[:id])
    flash[:notice] = "Deleted mime_type_category."
    redirect_to admin_mime_type_categories_path
  end
end
