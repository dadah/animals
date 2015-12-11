class Account < Sequel::Model
  plugin :geocoder
  plugin :validation_helpers
  plugin :dirty
  one_to_many :pets

  geocoded_by :address, &:set_location
  reverse_geocoded_by :latitude, :longitude, &:set_location

  attr_accessor :password, :password_confirmation

  def set_location(results)
    if geo = results.first
      self.latitude = geo.latitude
      self.longitude = geo.longitude
      self.street = [geo.street, geo.postal_code].compact.join(', ')
      self.city    = geo.city
      self.region = geo.state
      self.country = geo.country
      self.country_code = geo.country_code
    end
  end

  def address
    [self.street, self.city, self.region, self.country].compact.join(', ')
  end

  def validate
    validates_presence     :email
    validates_presence     :role
    validates_presence     :password if password_required
    validates_presence     :password_confirmation if password_required
    validates_length_range 4..40, :password unless password.blank?
    errors.add(:password_confirmation, 'must confirm password') if !password.blank? && password != password_confirmation
    validates_length_range 3..100, :email unless email.blank?
    validates_unique       :email unless email.blank?
    validates_format       /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i, :email unless email.blank?
    validates_format       /[A-Za-z]/, :role unless role.blank?
    validates_format       /(\+)?(\d|\s)+/, :phone_number unless phone_number.blank?
  end

  # Callbacks
  def before_save
    if address_changed?
      self.geocode
    elsif self.coordinates_changed?
      self.reverse_geocode
    end
    encrypt_password
    self.pets_count ||= 0
  end

  ##
  # This method is for authentication purpose.
  #
  def self.authenticate(email, password)
    account = filter(Sequel.function(:lower, :email) => Sequel.function(:lower, email)).first
    account && account.has_password?(password) ? account : nil
  end

  def address_changed?
    columns_changed? [:street, :city, :region, :country]
  end

  def coordinates_changed?
    columns_changed? [:latitude, :longitude]
  end

  ##
  # Replace ActiveRecord method.
  #
  def self.find_by_id(id)
    self[id] rescue nil
  end

  def has_password?(password)
    ::BCrypt::Password.new(self.crypted_password) == password
  end

  private

  def encrypt_password
    self.crypted_password = ::BCrypt::Password.create(password) if password.present?
  end

  def password_required
    self.crypted_password.blank? || password.present?
  end

  def columns_changed? columns
    columns.find{|column| column_changed?(column)}.present?
  end
end
