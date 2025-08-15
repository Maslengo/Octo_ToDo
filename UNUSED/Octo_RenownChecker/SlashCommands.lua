if Octo == nil then Octo = {} end
if Octo.SlashCommands == nil then 
    Octo.SlashCommands = {}
    SLASH_Octo1 = '/Octo'
    SlashCmdList['Octo'] = function(arg)
        local fn = Octo.SlashCommands[arg]
        if type(fn) == "function" then
            fn()
        end
    end
end