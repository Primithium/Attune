--[[
    attune
    a tiny utility module for pitching sounds with 12-TET

    by Primithium
]]--

local Attune = {}
Attune.__index = Attune

function Attune.Init(Sound)
    if not Sound:IsA("Sound") then warn("Attempted to initialize Attune on non-sound object") return end

    local object = {}
    object.Effect = Instance.new("PitchShiftSoundEffect", Sound)
    object.Effect.Octave = 1
    object.Tuning = 0
    setmetatable(object, Attune)
    return object
end

function Attune:SetShiftInSemitones(Offset)
    local pitchFactor = 2 ^ ((Offset + self.Tuning) / 12)
    pitchFactor = math.max(0.5, math.min(2, pitchFactor))
    
    self.Effect.Octave = pitchFactor
end

function Attune:SetShiftInCents(Offset)
    local pitchFactor = 2 ^ ((Offset + self.Tuning) / 1200)
    pitchFactor = math.max(0.5, math.min(2, pitchFactor))

    self.Effect.Octave = pitchFactor
end

return Attune