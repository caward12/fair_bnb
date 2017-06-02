require 'fair_bnb/api_helpers'

class ApplicationRecord < ActiveRecord::Base
  include ActionView::Helpers::TextHelper
  self.abstract_class = true
end
