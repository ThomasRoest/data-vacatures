class Job < ActiveRecord::Base
	belongs_to :user
	has_many :jobapplications, dependent: :destroy
	before_save { self.place = place.downcase }
	has_attached_file :avatar, :styles => { :large => "155x155>", :medium => "85x85>", :small=> "65X65>", :thumb => "45x45>" }
	validates :user_id, presence: true
	validates :company, presence: true
  validates :job_type, presence: true
	validates :place, :presence => { :message => ", Voeg een plaatsnaam toe"}
	validates :title, presence: true
	validates :summary, presence: true, length: { maximum: 250 }
	validates :description, :presence => { :message => ", Voeg een functie omschrijving toe"}
	# validates :markdown, :presence => {:message => ", Voeg een functie omschrijving toe"}
	validates :guid, presence: true 
	validates :guid, :uniqueness => { :message => ", Er is al een vacature geplaatst met deze aankoop" }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates :email, format: { with: VALID_EMAIL_REGEX }, allow_blank: true
	validates_attachment :avatar, 
	                      # :presence => { :message => ", Voeg een bedrijfslogo toe" }, 
	                      :content_type => { :content_type => ["image/jpeg", "image/png"] },
	 					            :file_name => { :matches => [/png\Z/, /jpe?g\Z/] },
	 					            :size => { :in => 0..10.megabytes }
    
  default_scope { order('created_at DESC')}

    def slug
      title.downcase.parameterize
    end

    def to_param
    	"#{id}-#{slug}"
    end

end
