local playerList = gui.get_tab("Player List Test")
local playerIndex = 0
local function updatePlayerList()
  local players = entities.get_all_peds_as_handles()
  filteredPlayers = {}
  for _, ped in ipairs(players) do
    if PED.IS_PED_A_PLAYER(ped) then
      if NETWORK.NETWORK_IS_PLAYER_ACTIVE(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(ped)) then
        table.insert(filteredPlayers, ped)
      end
    end
  end
end
local function displayPlayerList()
    updatePlayerList()
    local playerNames = {}
    for _, player in ipairs(filteredPlayers) do
      local playerName = PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(player))
      local playerHost = NETWORK.NETWORK_GET_HOST_PLAYER_INDEX()
      local friendCount = NETWORK.NETWORK_GET_FRIEND_COUNT()
      if NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(player) == PLAYER.PLAYER_ID() then
        playerName = playerName.."  [You]"
      end
      if friendCount > 0 then
        for i = 0, friendCount do
          if playerName == NETWORK.NETWORK_GET_FRIEND_NAME(i) then
            playerName = playerName.."  [Friend]"
          end
        end
      end
      if playerHost == NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(player) then
        playerName = playerName.."  [Host]"
      end
      table.insert(playerNames, playerName)
    end
    playerIndex, used = ImGui.Combo("##playerList", playerIndex, playerNames, #filteredPlayers)
end
playerList:add_imgui(function()
  if NETWORK.NETWORK_IS_SESSION_ACTIVE() then
    local playerCount = NETWORK.NETWORK_GET_NUM_CONNECTED_PLAYERS()
    ImGui.Text("Total Players:  [ "..playerCount.." ]")
    ImGui.PushItemWidth(300)
    displayPlayerList()
    ImGui.PopItemWidth()
    local selectedPlayer = filteredPlayers[playerIndex + 1]
    local player_name = PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(selectedPlayer))
    if ImGui.Button("Get Player Coords") then
      local playerCoords = ENTITY.GET_ENTITY_COORDS(selectedPlayer)
      log.info(player_name.."'s coordinates: "..tostring(playerCoords))
    end
  else
    ImGui.Text("You are currently in Single Player.")
  end
end)
