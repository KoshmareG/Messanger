class Message < ApplicationRecord

    attr_accessor :name, :avatar

    belongs_to :user
    belongs_to :room

end
