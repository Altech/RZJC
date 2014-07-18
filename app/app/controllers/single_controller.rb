class SingleController < ApplicationController
  skip_before_filter :verify_authenticity_token

  before_action :set_common_data

  def set_common_data
    @valid_mechas = valid_mechas
  end

  def submit
  end

  def submit_post(p = params)
    blankable_fields = %w[team-name team-address team-address-confirm player1-name player1-mecha-id player1-force-type player1-pilot player2-name player2-mecha-id player2-force-type player2-pilot]
    blankable_fields.each do |f|
      binding.pry if p[f].nil?
    end
    unless blankable_fields.all?{|f| p[f].present?}
      render :text => "全ての空欄を埋めてください" and return
    end
    unless p['team-address'] == p['team-address-confirm']
      render :text => "確認用のメールアドレスが異なっています" and return
    end
    p.delete('team-address-confirm')
    if p['player1-name'] == p['player2-name']
      render :text => "プレイヤーの名前は別名としてください" and return
    end
    if p['team-name'].size < 3
      render :text => "チーム名は3文字以上でお願いします" and return
    end
    unless Mecha.find(p['player1-mecha-id']).cost + Mecha.find(p['player2-mecha-id']).cost < 1000
      render :text => "オーバーコストは禁止です" and return
    end

    # pre-save
    player1 = RzjcPlayer.create!(name: p['player1-name'], mecha_id: p['player1-mecha-id'], force_type: p['player1-force-type'], pilot: p['player1-pilot'])
    player2 = RzjcPlayer.create!(name: p['player2-name'], mecha_id: p['player2-mecha-id'], force_type: p['player2-force-type'], pilot: p['player2-pilot'])

    if Mecha.find(p['player1-mecha-id']).cost < Mecha.find(p['player2-mecha-id']).cost
      player1, player2 = player2, player1
    end

    question = RzjcQuestion.create!(exhibition: p['question-exhibition'])
    team = RzjcTeam.create!(name: p['team-name'], address: p['team-address'], region: p['team-region'], player1_id: player1.id, player2_id: player2.id, question_id: question.id, confirmed: false)

    # confirm
    RzjcMailer.confirmation_for_team(p,team.id).deliver

    render :text => "確認メールを送信しました。添付されたリンクを開いてください。"
  end

  def confirmation_for_team
    if params['team-id']
      team = RzjcTeam.find(params['team-id'])
      if not team.confirmed
        team.confirmed = true
        team.save!
        @msg = '登録が完了しました。'
        @teams = RzjcTeam.where(confirmed: true)
        render action: 'teams'
      else
        @msg = "既に「#{team.name}」の登録を確認済みです。"
        @teams = RzjcTeam.where(confirmed: true)
        render action: 'teams'
      end
    end
  end

  def teams
    @teams = RzjcTeam.where(confirmed: true)
  end

  def mediation_post(p = params)
    blankable_fields = %w[player-name player-region player-address player-address-confirm player-pilot]
    unless blankable_fields.all?{|f| p[f].present?}
      render :text => "全ての空欄を埋めてください" and return
    end
    unless p['player-address'] == p['player-address-confirm']
      render :text => "確認用のメールアドレスが異なっています" and return
    end
    p.delete('player-address-confirm')

    # pre-save
    player = RzjcSoloPlayer.create!(name: p['player-name'], address: p['player-address'], force_type: p['player-force-type'], pilot: p['player-pilot'], region: p['player-region'], mecha_good_1_id: p['player-mecha-id-good-1'], mecha_good_2_id: p['player-mecha-id-good-2'], mecha_good_3_id: p['player-mecha-id-good-3'], mecha_wanted_1_id: p['player-mecha-id-wanted-1'], mecha_wanted_2_id: p['player-mecha-id-wanted-2'], mecha_wanted_3_id: p['player-mecha-id-wanted-3'], confirmed: false)

    # confirm
    RzjcMailer.confirmation_for_solo_player(p,player.id).deliver

    render :text => "確認メールを送信しました。添付されたリンクを開いてください。"
  end

  def confirmation_for_solo_player
    if params['solo-player-id']
      player = RzjcSoloPlayer.find(params['solo-player-id'])
      if not player.confirmed
        player.confirmed = true
        player.save!
        render :text => '登録が完了しました。'
      else
        render :text => "既に「#{team.name}」の登録を確認済みです。"
      end
    end
  end

  private

  def valid_mechas
    Mecha.all.select{|m| m.full_name != 'プロヴィデンス' and m.full_name != 'ランチャーストライク' and m.full_name != 'ストライクノワール'}
  end
end
