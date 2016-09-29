App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    # Called when the subscription is ready for use on the server
    @printMessage("waiting for opponent......")

  received: (data) ->
    switch data.action
      when "game_start"
        App.board.position("start")
        App.board.orientation(data.msg)
        @printMessage("Game started! You play as #{data.msg}.")
      when "make_move"
        [source, target] = data.msg.split("-")
        App.chess.move
          from: source
          to: target
          promotion: "q"
          # @printMessage("#{source}-->#{target}")
        App.board.position(App.chess.fen())

      when "opponent_forfeits"
        @printMessage("Opponent forfeits. You win!")

  printMessage: (message) ->
    $("#messages").append("<p>#{message}</p>")
