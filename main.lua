SLASH_FollowerHelper1, SLASH_FollowerHelper2 = '/fh', '/followerhelper'
function SlashCmdList.FollowerHelper(msg)
  printFollowers()
end

local followersList = C_Garrison.GetFollowers()

function getFollowerCount()
  local followerCount = 0
  for i = 1, #followersList do
    if (followersList[i].isCollected) then
      followerCount = followerCount + 1
    end
  end
  return followerCount
end

function printFollowers()
  for i = 1, #followersList do
    printFollower(followersList[i])
  end
end

function printFollower(follower)
  if (not follower.isCollected or follower.status == GARRISON_FOLLOWER_INACTIVE or follower.status == GARRISON_FOLLOWER_WORKING) then
    return
  end
  local level = colorize(follower.quality, level(follower))
  local abilities = getAbilityIconString(follower)
  print(level .. ' - ' .. follower.name .. ' - ' .. abilities)
end

function getAbilityIconString(follower)
  local iconString = ''
  local abilities = C_Garrison.GetFollowerAbilities(follower.followerID)
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

function level(follower)
  if follower.level >= 100 then
    return 'i' .. follower.iLevel
  end
  return follower.level
end

function colorize(quality, text)
  return ITEM_QUALITY_COLORS[quality].hex .. text .. FONT_COLOR_CODE_CLOSE
end

function getIconString(icon)
  return string.format('\124T%s:0:0:2:0\124t', icon)
end
