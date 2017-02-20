class Article < ActiveRecord::Base
    validates :title, presence: true, length: { minimum: 5 }
    validates :content, presence: true, length: { minimum: 10 }
    validates :status, presence: true

    #name relation must plural
    has_many :comments, dependent: :destroy
    
    default_scope {where(status: 'active')}
end
