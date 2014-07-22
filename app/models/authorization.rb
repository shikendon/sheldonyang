class Authorization < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid, :scope => :provider

  def self.find_by_oauth(auth)
    provider = auth.provider
    uid = auth.uid
    self.find_by(provider: provider, uid: uid)
  end
end
