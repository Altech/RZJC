class RzjcSoloPlayer < ActiveRecord::Base
  belongs_to :mecha_good_1
  belongs_to :mecha_good_2
  belongs_to :mecha_good_3
  belongs_to :mecha_wanted_1
  belongs_to :mecha_wanted_2
  belongs_to :mecha_wanted_3
end
