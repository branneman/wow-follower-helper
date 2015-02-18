function sortFollowers(func, follower1, follower2)
    if (follower1 == nil and follower2 == nil) then
        return false
    elseif (follower1 == nil) then
        return true
    elseif (follower2 == nil) then
        return false
    end
    return func(follower1, follower2)
end

function sortFollowersByLevel(follower1, follower2)
    if (follower1.level ~= follower2.level) then
        return follower1.level > follower2.level
    end
    if (follower1.iLevel ~= follower2.iLevel) then
        return follower1.iLevel > follower2.iLevel
    end
    return sortFollowersByQuality(follower1, follower2)
end

function sortFollowersByQuality(follower1, follower2)
    if (follower1.quality ~= follower2.quality) then
        return follower1.quality > follower2.quality
    end
    return strcmputf8i(follower1.name, follower2.name) < 0;
end

function abilityDecorator(follower)
    follower.stringifyAbilities = function()
        return getAbilityIcons(follower.followerID)
    end
    return follower
end

function levelDecorator(follower)
    follower.stringifyLevel = function()
        return colorize(follower.quality, getDisplayLevel(follower))
    end
    return follower
end

function isUsableFollower(follower)
    local collected = follower.isCollected
    local active    = follower.status ~= GARRISON_FOLLOWER_INACTIVE
    local working   = follower.status == GARRISON_FOLLOWER_WORKING
    return collected and active and not working
end

function getAbilityIcons(followerID)
    local iconString = ''
    local abilities = C_Garrison.GetFollowerAbilities(followerID)
    for i = 1, #abilities do
        local ability = abilities[i];
        if (not ability.isTrait) then
            for id, counter in pairs(ability.counters) do
                iconString = iconString .. getIconString(counter.icon) .. ' '
            end
        end
    end
    return iconString
end

function getDisplayLevel(follower)
    if follower.level >= 100 then
        return 'i' .. follower.iLevel
    end
    return follower.level
end
