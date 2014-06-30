class RzjcMailer < ActionMailer::Base
  default from: "noreply@rzjc.vs-seed.net"

  def confirmation_for_team(params, team_id)
    @params = params
    @link = "http://rzjc.vs-seed.net/priv/confirmation_for_team?team-id=#{team_id}"
    mail(to: params['team-address'], subject: '【RZJC2014】 参加確認')
  end
end
