class WorkshopScheduleSubscribed < ApplicationRecord
  
  include Destroyable

  #--------------------------------------------- RELATION
  belongs_to :workshop_schedule
  belongs_to :normal_profile
  has_one :workshop, through: :workshop_schedule

  #--------------------------------------------- MISC

  #--------------------------------------------- VALIDATION

  #--------------------------------------------- CALLBACK

  #--------------------------------------------- SCOPES

  #--------------------------------------------- METHODS
  after_create :create_notification_subscribed
  after_destroy :create_notification_unsubscribed

  def create_notification_subscribed
    Notification.create(normal_profile: workshop.normal_profile, kind: 'workshop_subscribed', content: "#{normal_profile.to_s} se incorporó a tu taller '#{workshop.activity_title}'")
  end

  def create_notification_unsubscribed
    Notification.create(normal_profile: workshop.normal_profile, kind: 'workshop_unsubscribed', content: "#{normal_profile.to_s} ha salido de tu taller '#{workshop.activity_title}'")
  end
  

end



