DECK_GUID = Global.getVar('EVENT_DECK_GUID')
ENCOUNTER_DECK = Global.getTable('ENCOUNTER_DECK_GUID')

function setUpCards(player, difficulty)
    -- Get the original deck
    local deck = getObjectFromGUID(DECK_GUID)

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

    group(parts)
  
end