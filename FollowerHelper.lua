SLASH_FollowerHelper1, SLASH_FollowerHelper2 = '/fh', '/followerhelper'

function SlashCmdList.FollowerHelper(msg)

    -- Grab all followers
    local followers = C_Garrison.GetFollowers()

    -- Filter out ususable followers and sort
    followers = filter(followers, isUsableFollower)
    followers = sort(followers, sortFollowers)

    -- Decorate followers with stringify methods
    followers = map(followers, abilityDecorator)
    followers = map(followers, levelDecorator)

    -- Concat stringified follower properties
    local abilities = map(followers, fn('stringifyAbilities'))
    local levels = map(followers, fn('stringifyLevel'))
    local names = map(followers, get('name'))

    -- Add stringified follower properties to Ui
    columnAbilities:SetText(join(abilities))
    columnLevels:SetText(join(levels))
    columnNames:SetText(join(names))

    -- Resize frame to contents and show frame
    scaleFrameToText(FH_Window, columnAbilities, 20)
    FH_Window:Show();

end
