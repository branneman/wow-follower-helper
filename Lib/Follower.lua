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
