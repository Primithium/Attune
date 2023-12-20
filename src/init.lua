--[=[
    @class Attune
    a tiny utility module for pitching sounds with 12-TET.
]=]--

--[=[
    @prop Effect PitchShiftSoundEffect
    @within Attune
    @readonly
    a reference to the [PitchShiftSoundEffect](https://create.roblox.com/docs/reference/engine/classes/PitchShiftSoundEffect) linked to this Attune object.
    for almost all use cases this should not be modified, however, its properties can be.
]=]--

--[=[
    @prop Tuning number
    @within Attune
    the offset (in cents) to apply to the sound before any operation. intended to be used for fine tuning samples.
]=]--

local Attune = {}
Attune.__index = Attune

--[=[
    creates a new Attune object and instantiates a [PitchShiftSoundEffect](https://create.roblox.com/docs/reference/engine/classes/PitchShiftSoundEffect) for future use.

    @param Sound Sound -- the [Sound](https://create.roblox.com/docs/reference/engine/classes/Sound) you want to tune.
    @param Tuning number -- <since v0.1.1, default: 0> the offset (in cents) to apply to the sound before any operation. intended to be used for fine tuning samples.
    @return Attune
]=]--

function Attune.Init(Sound, Tuning)
    if not Sound:IsA("Sound") then warn("Attempted to initialize Attune on non-sound object") return end

    local object = {}
    object.Effect = Instance.new("PitchShiftSoundEffect", Sound)
    object.Effect.Octave = 1
    object.Tuning = Tuning or 0
    setmetatable(object, Attune)
    return object
end

--[=[
    offsets the pitch of the sample by a number of semitones.

    @param Offset number -- the number (in semitones) to adjust by.
]=]--

function Attune:SetShiftInSemitones(Offset)
    local pitchFactor = 2 ^ ((Offset + self.Tuning) / 12)
    pitchFactor = math.max(0.5, math.min(2, pitchFactor))
    
    self.Effect.Octave = pitchFactor
end

--[=[
    offsets the pitch of the sample by a number of cents.

    @param Offset number -- the number (in cents) to adjust by.
]=]--

function Attune:SetShiftInCents(Offset)
    local pitchFactor = 2 ^ ((Offset + self.Tuning) / 1200)
    pitchFactor = math.max(0.5, math.min(2, pitchFactor))

    self.Effect.Octave = pitchFactor
end

return Attune