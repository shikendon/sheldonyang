class Tag < ActiveRecord::Base
  belongs_to :example
  belongs_to :tag_i18n
end
