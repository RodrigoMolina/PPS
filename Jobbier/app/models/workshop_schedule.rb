class WorkshopSchedule < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :workshop
  has_many :workshop_schedule_subscribeds
  has_many :subscribed_normal_profiles, through: :workshop_schedule_subscribeds, source: :normal_profile
  has_many :workshop_schedule_messages, dependent: :destroy
  has_many :workshop_schedule_message_observers, through: :workshop_schedule_messages
  
  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION
  validates :maximun_quota, presence: true, if: lambda {ActiveRecord::Type::Boolean.new.cast(self.unlimited_quota) == false}
  validates :start_publication, presence: true, if: lambda {ActiveRecord::Type::Boolean.new.cast(self.always_open) == false}
  validates :closing_of_registrations, presence: true, if: lambda {ActiveRecord::Type::Boolean.new.cast(self.never_close) == false}
  validates :schedule_info, presence: true
  validate :start_publication_minor_than_closing_of_registrations

  def start_publication_minor_than_closing_of_registrations
    if start_publication.present? && closing_of_registrations.present?
      if start_publication > closing_of_registrations
        errors.add(:start_publication, 'La fecha debe ser menor a la de cierre')
      end
    end
  end


  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS

  def state_in_progress?
    if always_open
      false
    else
      if never_close
        Date.today > start_publication
      else
        (Date.today > start_publication) && (Date.today <= closing_of_registrations)
      end
    end
  end


  def state_finsh?
    if never_close
      false
    else
      Date.today > closing_of_registrations
    end
  end

  def get_state
    case true
    when state_finsh?
      :finish
    when state_in_progress?
      :in_progress
    else
      :open
    end
  end


  def subscribed?(normal_profile)
    workshop_schedule_subscribeds.where(normal_profile: normal_profile).any?
  end
  
  def available_quota
    maximun_quota - actual_quota
  end

  def days_to_start
    if always_open
      '-'
    else
      if Date.today < start_publication
        "#{(start_publication - Date.today).to_i} días"
      else
        'Comenzado'
      end
    end
  end

  def destroyable?
    workshop_schedule_subscribeds.empty?
  end


end



