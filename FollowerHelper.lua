SLASH_FollowerHelper1, SLASH_FollowerHelper2 = '/fh', '/followerhelper'

function SlashCmdList.FollowerHelper(msg)
  setFollowers(getFollowers())
  scaleFrameToText(FH_Window, fontString, 20)
  FH_Window:Show();
end

function scaleFrameToText(frame, text, margin)
  text:SetPoint('TOPLEFT', frame, 'TOPLEFT', margin, -margin)
  text:SetWidth(frame:GetRight() - frame:GetLeft() - margin * 2)
  frame:SetHeight(text:GetHeight() + margin * 2)
end

function setFollowers(text)
  fontString:SetText(text)
end

function getFollowers()
  local followersList = C_Garrison.GetFollowers()
  local followerString = ''
  for i = 1, #followersList do
    local follower = getFollower(followersList[i])
    if (follower ~= '') then
      followerString = followerString .. follower .. '|n'
    end
  end
  return followerString
end

function getFollowerCount()
  local followersList = C_Garrison.GetFollowers()
  local followerCount = 0
  for i = 1, #followersList do
    if (followerIsUsable(followersList[i])) then
      followerCount = followerCount + 1
    end
  end
  return followerCount
end

function getFollower(follower)
  if (not followerIsUsable(follower)) then
    return ''
  end
  local level = colorize(follower.quality, level(follower))
  local abilities = getAbilityIconString(follower)
  return level .. ' - ' .. follower.name .. ' - ' .. abilities
end

function followerIsUsable(follower)
  local collected = follower.isCollected
  local active    = follower.status ~= GARRISON_FOLLOWER_INACTIVE
  local working   = follower.status == GARRISON_FOLLOWER_WORKING
  return collected and active and not working
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
