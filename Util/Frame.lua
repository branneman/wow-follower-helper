function scaleFrameToText(frame, text, margin)
    text:SetPoint('TOPLEFT', frame, 'TOPLEFT', margin, -margin)
    frame:SetHeight(text:GetHeight() + margin * 2)
end
