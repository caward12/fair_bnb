class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  self.abstract_class = true
end
