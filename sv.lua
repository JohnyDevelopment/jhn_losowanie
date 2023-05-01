ESX = exports["es_extended"]:getSharedObject()
RegisterCommand("rozdaj", function(source, args) 
    local players = GetPlayers()
    if (source == 0) then 
        if #players == 0 then
            print("^1 [ERROR]  ^7 Nie ma nikogo na serwerze")
        else 
            local ile = tonumber(args[1])
            local co = args[2]
            local ilechujow = tonumber(args[3]) -- prosze aby sto
            if (#players > ile) then 
                print("^1 [ERROR]  ^7 Niektore osoby dostana kilka razy skrzynke!")
            else 
                if (ile and co and ilechujow) then 
                    print(ile)
                    print(co)
                    print(ilechujow)
                    TriggerClientEvent("chat:addMessage", -1 , "Uzytkownik Console rozpoczal rozdawanie "..co.." w ilosci "..ilechujow.." dla "..ile.." uzytkownikow online")
                    for i=1, ile, 1 do 
                        local randomPlayerIndex = math.random(1, #players)
                        local randomPlayer = players[randomPlayerIndex]
                        local xPlayer = ESX.GetPlayerFromId(randomPlayer)
                        if (xPlayer) then 
                            print("Wylosowano osobę: " .. GetPlayerName(randomPlayer))
                            TriggerClientEvent("chat:addMessage", -1, "Uzytkownik "..GetPlayerName(randomPlayer).." Dostal itemy ktore sa aktualnie rozdawane")
                            xPlayer.addInventoryItem(co, ilechujow)
                        else 
                            TriggerClientEvent("chat:addMessage", -1, "Uzytkownik ktory mial dostac wyszedl z serwera wiec jedna kolejka przepada!")
                        end
                        Citizen.Wait(50000)
                    end
                else 
                    print("^1 [ERROR]  ^7 Poprawne uzycie komendy to /rozdaj ilu_osoba_rozdac co_rozdac ile_tego")
                end
            end
        end
    else
        local xPlayer1 = ESX.GetPlayerFromId(source)
        if (xPlayer1) then 
            if (xPlayer1.getGroup() == 'admin') then 
                local ile = tonumber(args[1])
                local co = args[2]
                local ilechujow = tonumber(args[3])
                if (ile and co and ilechujow) then 
                    TriggerClientEvent("chat:addMessage", -1 , "Uzytkownik "..GetPlayerName(source).." rozpoczal rozdawanie "..co.." w ilosci "..ilechujow.." dla "..ile.." uzytkownikow online")
                    Citizen.Wait(3000)
                    for i=1, ile, 1 do 
                        local randomPlayerIndex = math.random(1, #players)
                        local randomPlayer = players[randomPlayerIndex]
                        local xPlayer = ESX.GetPlayerFromId(randomPlayer)
                        if (xPlayer) then 
                            TriggerClientEvent("chat:addMessage", -1, "Uzytkownik "..GetPlayerName(randomPlayer).." Dostal itemy ktore sa aktualnie rozdawane")
                            xPlayer.addInventoryItem(co, ilechujow)
                        else 
                            TriggerClientEvent("chat:addMessage", -1, "Uzytkownik ktory mial dostac wyszedl z serwera wiec jedna kolejka przepada!")
                        end
                        Citizen.Wait(50000)
                    end
                else 
                    xPlayer1.showNotification("Poprawne uzycie komendy to /rozdaj ilu_osoba_rozdac co_rozdac ile_tego")
                end
            else 
                xPlayer1.showNotification('Nie masz permisji')
            end
        else 
        end
    end 
end)
