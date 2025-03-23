local pot = {
toast = {},
}
function pot:hookremote(remote, callback)
    local oldfserver = remote.FireServer
    remote.FireServer = function(self, ...)
        return callback(self, ...) or oldfserver(self, ...)
    end
end
function pot:getplayers(filter)
    local players = game:FindFirstChildOfClass("Players"):GetPlayers()
    if filter then
        return table.filter(players, filter)
    end
    return players
end
function pot:getmemoryusage()
    return collectgarbage('count')
end
function pot:modifymemory(address, value)
    setreadonly(memory, false)
    memory.write(address, value)
    setreadonly(memory, true)
end
function pot.toast:notify(titletxt, text, time)
    local GUI = Instance.new('ScreenGui')
    local Main = Instance.new('Frame', GUI)
    local title = Instance.new('TextLabel', Main)
    local message = Instance.new('TextLabel', Main)
    GUI.Name = 'NotificationOof'
    GUI.Parent = game.CoreGui
    Main.Name = 'MainFrame'
    Main.BackgroundColor3 = Color3.new(0.156863, 0.156863, 0.156863)
    Main.BorderSizePixel = 0
    Main.Position = UDim2.new(1, 5, 0, 50)
    Main.Size = UDim2.new(0, 330, 0, 100)

    title.BackgroundColor3 = Color3.new(0, 0, 0)
    title.BackgroundTransparency = 0.89999997615814
    title.Size = UDim2.new(1, 0, 0, 30)
    title.Font = Enum.Font.SourceSansSemibold
    title.Text = titletxt
    title.TextColor3 = Color3.new(1, 1, 1)
    title.TextSize = 17

    message.BackgroundColor3 = Color3.new(0, 0, 0)
    message.BackgroundTransparency = 1
    message.Position = UDim2.new(0, 0, 0, 30)
    message.Size = UDim2.new(1, 0, 1, -30)
    message.Font = Enum.Font.SourceSans
    message.Text = text
    message.TextColor3 = Color3.new(1, 1, 1)
    message.TextSize = 16

    wait(0.1)
    Main:TweenPosition(UDim2.new(1, -330, 0, 50), 'Out', 'Sine', 0.5)
    wait(time)
    Main:TweenPosition(UDim2.new(1, 5, 0, 50), 'Out', 'Sine', 0.5)
    wait(0.6)
    GUI:Destroy()
end
function pot:notify(titletxt, text, time, icon, btn1txt, btn2txt)
    if time == nil then
        time = 3
    end
    local CoreGui = game:GetService('StarterGui')

    CoreGui:SetCore('SendNotification', {
        Title = titletxt,
        Text = text,
        Duration = time,
        Button1 = btn1txt,
        Button2 = btn2txt,
    })
end
return pot
