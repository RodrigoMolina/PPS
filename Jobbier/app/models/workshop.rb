class Workshop < ApplicationRecord


  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :country
  belongs_to :province
  belongs_to :city
  belongs_to :workshop_category

  belongs_to :normal_profile
  

  has_many :workshop_comments, dependent: :destroy
  has_many :workshop_steps, dependent: :destroy
  has_many :workshop_favorites, dependent: :destroy

  has_many :workshop_images, dependent: :destroy
  accepts_nested_attributes_for :workshop_images, allow_destroy: true, reject_if: proc { |attributes| attributes['image_attributes'].blank? }

  has_many :workshop_schedules, dependent: :destroy
  accepts_nested_attributes_for :workshop_schedules, allow_destroy: true

  has_many :workshop_schedule_subscribeds, through: :workshop_schedules
  has_many :subscribed_normal_profiles, through: :workshop_schedule_subscribeds


  #--------------------------------------------- MISC
  attr_accessor :step

  #--------------------------------------------- VALIDATION
  #STEP 1
  validates :country_id, :province_id, :city_id, :workshop_category_id, presence: true, if: lambda {self.step == 'step1' || self.step == 'step_final'}

  #STEP 2
  validates :place, presence: true, if: lambda {self.step == 'step2' || self.step == 'step_final'}
  validates :street, :number, presence: true, if: lambda {(self.step == 'step2' || self.step == 'step_final') && self.place.present? && [:institucion, :casa, :aire_libre, :pub].include?(self.place.to_sym)}
  validate :finish_step1, if: lambda {(self.step == 'step2' || self.step == 'step_final') && self.place.present? && [:institucion, :casa, :aire_libre, :pub].include?(self.place.to_sym)}

  #STEP 3
  validates :activity_title, :activity_description, :gender, :level, presence: true, if: lambda {self.step == 'step3' || self.step == 'step_final'}

  #STEP 4 
  validate :at_least_one_workshop_schedules, if: lambda {(self.step == 'step4' || self.step == 'step_final')}


  #STEP 5 NADA

  #STEP 6
  validates :price, presence: true, if: lambda {(self.step == 'step6' || self.step == 'step_final')}
  validate :finish_step1, if: lambda {(self.step == 'step6' || self.step == 'step_final')}

  #STEP 7 NADA
  #validates :charge_method_transfer_bank, :charge_method_transfer_subsidiary, :charge_method_transfer_owner, :charge_method_transfer_dni, :charge_method_transfer_account_number, :charge_method_transfer_cbu, presence: true, if: lambda {(self.step == 'step7' || self.step == 'step_final') && ActiveRecord::Type::Boolean.new.cast(self.charge_method_transfer) == true}


  #STEP 8 NADA



  def at_least_one_workshop_schedules
    if workshop_schedules.reject { |x| x._destroy }.empty?
      errors.add(:workshop_schedules, 'Al menos debe haber alguna cita')
    end
  end

  def finish_step1
    unless step?('step1')
      errors.add(:step, 'Debe completar el paso previo')
    end
  end

  #--------------------------------------------- CALLBACK
  after_create :generate_workshop_steps
  after_save :set_lat_and_lng

  def set_lat_and_lng
    if latitude.nil? and longitude.nil?
      if place == 'a_domicilio' || place == 'omitir'
        if country_id.present? && province_id.present? && city_id.present?
          require 'net/http'
          require 'json'

          new_label = "#{city} #{province} #{country}"
          uri = URI("https://maps.googleapis.com/maps/api/geocode/json?address=#{new_label}&key=#{Const::GMAPS_KEY}")
          response = Net::HTTP.get uri
          locations_json = JSON.parse(response)
          if locations_json['results'].any?
            latitude = locations_json['results'][0]['geometry']['location']['lat']
            longitude = locations_json['results'][0]['geometry']['location']['lng']
            update_columns(latitude: latitude, longitude: longitude)
          end


        end
      end
    end
  end

  #--------------------------------------------- SCOPES
  scope :filter_state, -> (state) { where(state: state) }
  scope :filter_state_draft, -> { filter_state(:draft) }
  

  scope :filter_state_open, -> { filter_state(:open).joins(:workshop_schedules).where('((workshop_schedules.start_publication >= :date) AND (workshop_schedules.always_open = false) OR (workshop_schedules.always_open = true))', date: Date.today) } 
  
  

  scope :filter_state_in_progress, -> { filter_state(:open).joins(:workshop_schedules).where('((workshop_schedules.always_open = false AND workshop_schedules.never_close = false) AND (workshop_schedules.start_publication < :date AND workshop_schedules.closing_of_registrations >= :date)) OR
                                                                                              ((workshop_schedules.always_open = false AND workshop_schedules.never_close = true) AND (workshop_schedules.start_publication < :date))', date: Date.today) }
  


  scope :filter_state_finsh, -> { filter_state(:open).joins(:workshop_schedules).where('((workshop_schedules.never_close = false) AND (workshop_schedules.closing_of_registrations < :date))', date: Date.today) }






  scope :filter_state_to_show, -> { filter_state(:open).joins(:workshop_schedules).where('(((workshop_schedules.always_open = false AND workshop_schedules.never_close = false) AND (workshop_schedules.start_publication < :date AND workshop_schedules.closing_of_registrations >= :date)) OR
                                                                                          ((workshop_schedules.always_open = false AND workshop_schedules.never_close = true) AND (workshop_schedules.start_publication < :date))) OR ((workshop_schedules.start_publication >= :date) AND (workshop_schedules.always_open = false) OR (workshop_schedules.always_open = true))', date: Date.today) }


  #--------------------------------------------- METHODS

  PRICE_UNITS = [:por_hora, :por_clase, :por_mes, :taller_completo]


  def generate_workshop_steps
    self.workshop_steps = [WorkshopStep.new(step: 'step1'),
                           WorkshopStep.new(step: 'step2'),
                           WorkshopStep.new(step: 'step3'),
                           WorkshopStep.new(step: 'step4'),
                           WorkshopStep.new(step: 'step5'),
                           WorkshopStep.new(step: 'step6')]
                           #WorkshopStep.new(step: 'step7')
  end

  def step?(step)
    workshop_steps.filter_step(step).take.ok?
  end

  def steps?(steps)
    workshop_steps.filter_steps(steps).all?{|x| x.ok?}
  end

  def all_steps_finish?
    steps?(['step1','step2','step3','step4','step5','step6']) #,'step7','step8'
  end

  def avg_score
    workshop_comments.average(:score).to_f.ceil
  end

  def address_to_s
    unless [:omitir, :a_domicilio].include?(place.to_sym)
      "#{I18n.t(place, scope: :workshop_place)}: #{(street.present?)? "Calle #{street}" : ''} #{(number.present?)? "N° #{number}" : ''} #{(floor.present?)? "piso #{floor}" : ''} #{(apartment.present?)? "dpto #{apartment}" : ''}"
    else
      "#{I18n.t(place, scope: :workshop_place)}: #{description_place}"
    end
  end


  def set_step_true(step)
    unless step?(step)
      workshop_step = workshop_steps.filter_step(step).take
      if workshop_step.nil?
        false
      else
        workshop_step.ok_true
      end
    end
  end



  GENDER_TYPES = [:male, :female, :other]
  LEVEL_TYPES = [:beginners, :medium, :advanced]
  PLACE_TYPES = [:omitir, :institucion, :pub, :casa, :aire_libre, :a_domicilio, :other]

  def favorite?(normal_profile)
    workshop_favorites.where(normal_profile: normal_profile).any?
  end

  def to_s
    activity_title
  end

  def last_checkpoint_step
    aux_step = workshop_steps.reject{|x| x.ok}.first
    (aux_step.nil?)? nil : aux_step.step
  end

  def next_step
    step.slice!(0..3)
    "step#{(step.to_i + 1)}"
  end



  def price
    price_in_cents.to_d / 100 if price_in_cents
  end

  def price=(value)
    self.price_in_cents = (value.present?)? value.to_d * 100 : nil
  end


  STATES = [:draft, :open]

  def state_draft?
    (state.to_sym == :draft)
  end

  def state_open?
    (state.to_sym == :open)
  end

  def state_in_progress?
    state_open? && workshop_schedules.any?{|ws| ws.state_in_progress?}
  end

  def state_finsh?
    state_open? && workshop_schedules.all?{|ws| ws.state_finsh? }
  end

  def get_state
    case true
    when state_finsh?
      :finish
    when state_in_progress?
      :in_progress
    else
      state.to_sym
    end
  end

  def set_state_open
    update_column(:state, :open) if state_draft?
  end

  def main_workshop_image
    workshop_images.kind_place.first
  end

  def main_get_image
    (main_workshop_image.nil?)? 'workshop_default.png' : main_workshop_image.get_image
  end

  def main_get_image_thumb
    (main_workshop_image.nil?)? 'workshop_default.png' : main_workshop_image.get_image_thumb
  end

  def main_high_or_wide
    (main_workshop_image.nil?)? 'high' : main_workshop_image.high_or_wide
  end



  def destroyable?
    workshop_schedules.all?{|x| x.destroyable? }
  end


end

