class RzjcTeam < ActiveRecord::Base
  belongs_to :question

  def player1
    RzjcPlayer.find(self.player1_id)
  end

  def player2
    RzjcPlayer.find(self.player2_id)
  end
end
