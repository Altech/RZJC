class RzjcSoloPlayer < ActiveRecord::Base
  def mecha_good(i)
    if not (1..3).include?(i)
      raise "A mechas_good argument is in range of 1..3"
    end
    Mecha.find(self.send("mechas_good_#{i+1}"))
  end

  def mechas_good
    [mecha_good_1_id, mecha_good_2_id, mecha_good_3_id].map{|id| Mecha.find(id)}
  end

  def mecha_wanted(i)
    if not (1..3).include?(i)
      raise "A mechas_wanted argument is in range of 1..3"
    end
    Mecha.find(self.send("mechas_wanted_#{i+1}"))
  end

  def mechas_wanted
    [mecha_wanted_1_id, mecha_wanted_2_id, mecha_wanted_3_id].map{|id| Mecha.find(id)}
  end
end
