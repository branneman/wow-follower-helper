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
  print(colorize(follower.quality, level(follower)) .. ' - ' .. follower.name)
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
