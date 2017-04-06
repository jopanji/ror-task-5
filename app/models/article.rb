class Article < ActiveRecord::Base
    validates :title, presence: true, length: { minimum: 5 }
    validates :content, presence: true, length: { minimum: 10 }
    validates :status, presence: true

    #name relation must plural
    has_many :comments, dependent: :destroy
    
    default_scope {where(status: 'active')}


     def as_xls(option= {})

       {

        "Id" => id.to_s,
        "Title" => title,
        "Content" => content
      
       }
    end

    def self.import(file)
 	   	 spreadsheet = open_spreadsheet(file)
 	   	 header = spreadsheet.row(1)
 	   	 (2..spreadsheet.last_row).each	do |i|
 	   	 	row = Hash[[header, spreadsheet.row(i)].transpose]
 	   	 	article = Article.find_by_id(row["id"]) || new
 	   	 	article.attributes = row.to_hash
 	   	 	article.save!
 	 end
  end

  def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
   when '.csv' then Roo::CSV.new(file.path, nil, :ignore)
   when '.xls' then Roo::Excel.new(file.path, packed: false,file_warning: :ignore)
   when '.xlsx' then Roo::Excelx.new(file.path, nil, :ignore)
   else raise "Unknown file type: #{file.original_filename}"
  
  end
end

end
