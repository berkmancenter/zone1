class Tag < ActiveRecord::Base
  
  def self.tag_list
    # TODO: Move this to Tag model, along with cache clearer
    Rails.cache.fetch("tag-list") do
      Tag.find_by_sql("SELECT ts.tag_id AS id, t.name
        FROM taggings ts
        JOIN tags t ON ts.tag_id = t.id
        WHERE ts.context = 'tags'
        GROUP BY ts.tag_id, t.name
        ORDER BY COUNT(*) DESC LIMIT 10")
    end
  end

end
