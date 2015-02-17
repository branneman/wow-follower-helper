function colorize(quality, text)
    return ITEM_QUALITY_COLORS[quality].hex .. text .. FONT_COLOR_CODE_CLOSE
end

function getIconString(icon)
    return string.format('\124T%s:0:0:2:0\124t', icon)
end

function join(tbl, sep)
    sep = sep or '|n'
    local str = ''
    for i, v in pairs(tbl) do
        str = str .. fif(str ~= '', sep, '') .. v
    end
    return str
end
