class Pet < Sequel::Model
  plugin :validation_helpers

  many_to_one :accounts
  many_to_one :breeds

  def validate
    validates_presence :name
    validates_presence :breed
    validates_presence :account
    validates_length_range 2..256, :name
  end
end
