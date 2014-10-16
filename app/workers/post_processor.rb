class PostProcessor
  @queue = :post_processor

  def self.perform(id)
    StoredFile.find(id).post_process
  end

end
