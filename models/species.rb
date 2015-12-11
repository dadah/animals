class Species < Sequel::Model

  one_to_many :breeds
  plugin :validation_helpers

  def validate
    validates_presence :name
    validates_unique   :name
    validates_length_range 3..256, :name unless name.blank?
  end

end
