local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Pstrw/Reuploaded-Librarys/main/EngoUI/source.lua"))()

local main = library:CreateMain("name", "", Enum.KeyCode.LeftAlt) -- keybind

local tab = main:CreateTab("tab1")
  
tab:CreateLabel("Reach")
  
tab:CreateToggle("toggle", function(value)
  print(value)
end)

tab:CreateSlider("slider", 0, 90, function(value)
  print(value)
end)

tab:CreateButton("button", function()
  print("button pressed")
end)

-- Original Drag is broken so use this.

local InputService = game:GetService('UserInputService')
local frame = game.CoreGui.EngoUI.Main
local dragging = nil
local speed = 0.1
local startPosition = nil
local initialPos = nil

local function adjustInput(input)
    local delta = input.Position - startPosition
    local newPosition = UDim2.new(
        initialPos.X.Scale,
        initialPos.X.Offset + delta.X,
        initialPos.Y.Scale,
        initialPos.Y.Offset + delta.Y
    )
    game:GetService('TweenService'):Create(frame, TweenInfo.new(speed), {Position = newPosition}):Play()
end

frame.InputBegan:Connect(function(input)
    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
        dragging = true
        startPosition = input.Position
        initialPos = frame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

InputService.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        if dragging then
            adjustInput(input)
        end
    end
end)
