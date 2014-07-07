class RzjcMailer < ActionMailer::Base
  default from: "noreply@rzjc.vs-seed.net"

  def confirmation_for_team(params, team_id)
    @params = params
    @link = "http://rzjc.vs-seed.net/priv/confirmation_for_team?team-id=#{team_id}"
    mail(to: params['team-address'], subject: '【RZJC2014】 参加確認')
  end

  def confirmation_for_solo_player(params, solo_player_id)
    @params = params
    @link = "http://rzjc.vs-seed.net/priv/confirmation_for_solo_player?solo-player-id=#{solo_player_id}"
    mail(to: params['player-address'], subject: '【RZJC2014】 斡旋登録確認')
  end
end
