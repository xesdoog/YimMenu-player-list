local playerList = gui.get_tab("Player List Test")
local playerIndex = 0
local function updatePlayerList()
    local players = entities.get_all_peds_as_handles()
    filteredPlayers = {}
    for _, ped in ipairs(players) do
      if PED.IS_PED_A_PLAYER(ped) then
        if NETWORK.NETWORK_IS_PLAYER_ACTIVE(ped) then
          table.insert(filteredPlayers, ped)
        end
      end
    end
end
local function displayPlayerList()
    updatePlayerList()
    local playerNames = {}
    for _, player in ipairs(filteredPlayers) do
      playerName = PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(player))
      table.insert(playerNames, playerName)
    end
    playerIndex, used = ImGui.Combo("##playerList", playerIndex, playerNames, #filteredPlayers)
end
playerList:add_imgui(function()
  local playerCount = NETWORK.NETWORK_GET_NUM_CONNECTED_PLAYERS()
  ImGui.Text("Total Players:  ["..playerCount.."]")
  ImGui.PushItemWidth(250)
  displayPlayerList()
  ImGui.PopItemWidth()
  local selectedPlayer = filteredPlayers[playerIndex + 1]
  local player_name = PLAYER.GET_PLAYER_NAME(NETWORK.NETWORK_GET_PLAYER_INDEX_FROM_PED(selectedPlayer))
  ---------------test to see if it's grabbing the correct player------------------
  if ImGui.Button("Get Player Coords") then
    local playerCoords = ENTITY.GET_ENTITY_COORDS(selectedPlayer)
    log.debug(tostring(player_name.."'s coordinates: "..playerCoords))
  end
end)
