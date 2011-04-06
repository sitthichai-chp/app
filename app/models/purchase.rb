class Purchase < ActiveRecord::Base

  has_many :orders

  accepts_nested_attributes_for :orders

  before_create :generate_purchase_number

  scope :by_number, lambda {|number| where("purchases.number = ?", number)}


  # purchase state machine (see http://github.com/pluginaweek/state_machine/tree/master for details)
  state_machine :initial => 'waiting', :use_transactions => false do

    event :next do
      transition :from => 'waiting',   :to => 'complete'
    end

    event :cancel do
      transition :to => 'canceled', :if => :allow_cancel?
    end

    after_transition :to => 'complete', :do => :finalize!
    after_transition :to => 'canceled', :do => :after_cancel

  end

  # FIXME refactor this method and implement validation using validates_* utilities
  def generate_purchase_number
    record = true
    while record
      random = "P#{Array.new(9){rand(9)}.join}"
      record = self.class.find(:first, :conditions => ["number = ?", random])
    end
    self.number = random if self.number.blank?
    self.number
  end

end