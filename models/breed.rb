class Breed < Sequel::Model

  many_to_one :species
  one_to_many :pets
  plugin :validation_helpers

  def validate
    validates_presence :species
    validates_presence :name
    validates_unique   :name
    validates_length_range 3..256, :name unless name.blank?
  end

end
