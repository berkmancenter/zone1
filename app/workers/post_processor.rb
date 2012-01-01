class PostProcessor
  @queue = :post_processor

  def self.perform(file_id)
    StoredFile.find(file_id).post_process
  end

end
