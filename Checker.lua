DECK_GUID = Global.getVar('EVENT_DECK_GUID')
ENCOUNTER_DECK = Global.getTable('ENCOUNTER_DECK_GUID')
PLAYER_TILES = Global.getTable('PLAYER_TILES_GUID')

function setUpCards(player, difficulty)
    -- Get the original deck
    local deck = getObjectFromGUID(DECK_GUID)
    getObjectFromGUID(Global.getVar('ITEM_DECK_GUID')).randomize()
    getObjectFromGUID(Global.getVar('ENEMY_DECK_GUID')).randomize()

    if deck == nil then
        print("Error: Unable to get the deck object. Check the GUID.")
        return
    end

    deck.randomize()

    -- Split the deck into two parts
    local parts = deck.split(difficulty + 3)

    for part = difficulty + 2, 1, -1 do
        parts[part].putObject(getObjectFromGUID(ENCOUNTER_DECK[part]))
        parts[part].randomize()
    end

    for part = difficulty + 2, 4, 1 do
        destroyObject(getObjectFromGUID(ENCOUNTER_DECK[part]))
    end

    local final_deck = group(parts)
    final_deck[1].rotate(vector(0, 90, 0))
    getObjectFromGUID(Global.getVar('ITEM_DECK_GUID')).deal(1)

    local players = Player.getPlayers()

    -- Loop through the seated players and check their color
    for _, player in ipairs(players) do
        local color = player.color
        
        print(color)

        if color == "Purple" then
            getObjectFromGUID(PLAYER_TILES[1]).setPosition({x = 0, y = 5, z = -2.3})

        elseif color == "Yellow" then
            getObjectFromGUID(PLAYER_TILES[2]).setPosition({x = 0, y = 5, z = -1.2})

        elseif color == "Blue" then
             getObjectFromGUID(PLAYER_TILES[3]).setPosition({x = 2, y = 5, z = -1.2})

        elseif color == "Orange" then
             getObjectFromGUID(PLAYER_TILES[4]).setPosition({x = 2, y = 5, z = -2.3})
        end
    end

    destroyObject(getObjectFromGUID(self.guid))
end
