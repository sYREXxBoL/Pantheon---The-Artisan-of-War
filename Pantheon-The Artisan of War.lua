version = "1.07"


--[[
  _____            _   _                                 _______ _                          _   _                          __  __          __        
 |  __ \          | | | |                               |__   __| |              /\        | | (_)                        / _| \ \        / /        
 | |__) |_ _ _ __ | |_| |__   ___  ___  _ __    ______     | |  | |__   ___     /  \   _ __| |_ _ ___  __ _ _ __     ___ | |_   \ \  /\  / /_ _ _ __ 
 |  ___/ _` | '_ \| __| '_ \ / _ \/ _ \| '_ \  |______|    | |  | '_ \ / _ \   / /\ \ | '__| __| / __|/ _` | '_ \   / _ \|  _|   \ \/  \/ / _` | '__|
 | |  | (_| | | | | |_| | | |  __/ (_) | | | |             | |  | | | |  __/  / ____ \| |  | |_| \__ \ (_| | | | | | (_) | |      \  /\  / (_| | |   
 |_|   \__,_|_| |_|\__|_| |_|\___|\___/|_| |_|             |_|  |_| |_|\___| /_/    \_\_|   \__|_|___/\__,_|_| |_|  \___/|_|       \/  \/ \__,_|_|   
                                                                                                                                                     
                                                                                                                                                     
--]]                                                                                                                                                  

if myHero.charName ~= "Pantheon" then
	return 
end

	function Hello()
		PrintChat("<font color=\"#4000ff\">Pantheon - The Artisan of War</font>")
	end

	local ATTACKITEMS = {"ItemTiamatCleave", "ItemTitanicHydraCleave", "BilgewaterCutlass", "YoumusBlade", "HextechGunblade", "ItemSwordOfFeastAndFamine"}
	local ANTICCITEMS = {"QuicksilverSash", "ItemDervishBlade"}
	local TIAMAT, TITANIC, CUTLASS, YOUMU, GUNBLADE, BOTRK, QSS, DERVISH = false
	local TIAMATSLOT, TITANICSLOT, CUTLASSSLOT, YOUMUSLOT, GUNBLADESLOT, BOTRKSLOT, QSSSLOT, DERVISHSLOT, SMITESLOT



	function OnLoad()
		Menu()
		Hello()

		if myHero:GetSpellData(SUMMONER_1).name:find("summonerdot") then Ignite = SUMMONER_1 elseif myHero:GetSpellData(SUMMONER_2).name:find("summonerdot") then Ignite = SUMMONER_2 end
	end


	function Menu()

		PanthMenu = scriptConfig("Pantheon - The Artisan of War", "Panth")
		
		PanthMenu:addSubMenu("Combo Settings", "combo")
			PanthMenu.combo:addParam("comboKey", "Full Combo Key (SBTW)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte (" "))
			PanthMenu.combo:addParam("items", "Use Items in Combo", SCRIPT_PARAM_ONOFF, true)
			--PanthMenu.combo:addParam("autoSmite", "Use Smite on Target if QWE Available", SCRIPT_PARAM_ONOFF, true)

		
		PanthMenu:addSubMenu("Harass Settings", "harass")
			--PanthMenu.harass:addParam("harassKey", "Harass key (C)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("C"))
			PanthMenu.harass:addParam("autoQ", "Auto-Q when Target in Range", SCRIPT_PARAM_ONKEYTOGGLE, false, GetKey('Z'))
			--PanthMenu.harass:addParam("aQT", "Don't Auto-Q if in enemy Turret Range", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.harass:addParam("harassMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
			
		
		PanthMenu:addSubMenu("Last Hit Settings", "farming")
			PanthMenu.farming:addParam("farmKey", "Farming Key", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("X"))
			PanthMenu.farming:addParam("qFarm", "Last Hit with (Q)", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.farming:addParam("farmMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)


		PanthMenu:addSubMenu("Lane Clear Settings", "lane")
			PanthMenu.lane:addParam("laneKey", "Jungle Clear Key (V)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			PanthMenu.lane:addParam("laneQ", "Use (Q)", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.lane:addParam("laneW", "Use (W)", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.lane:addParam("laneE", "USe (E)", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.lane:addParam("laneMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)

			
		PanthMenu:addSubMenu("Jungle Clear Settings", "jungle")
			PanthMenu.jungle:addParam("jungleKey", "Jungle Clear Key (V)", SCRIPT_PARAM_ONKEYDOWN, false, string.byte("V"))
			PanthMenu.jungle:addParam("jungleQ", "Use (Q)", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.jungle:addParam("jungleW", "Use (W)", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.jungle:addParam("jungleE", "USe (E)", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.jungle:addParam("jungleMana", "Min. Mana Percent: ", SCRIPT_PARAM_SLICE, 50, 0, 100, 0)
			
			
		PanthMenu:addSubMenu("KillSteal Settings", "ks")
			PanthMenu.ks:addParam("killSteal", "Use Smart Kill Steal", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.ks:addParam("autoIgnite", "Auto Ignite", SCRIPT_PARAM_ONOFF, true)
				

		PanthMenu:addSubMenu("Draw Settings", "drawing")	
			PanthMenu.drawing:addParam("mDraw", "Disable All Range Draws", SCRIPT_PARAM_ONOFF, false)
			PanthMenu.drawing:addParam("Target", "Draw Circle on Target", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.drawing:addParam("qDraw", "Draw (Q) Range", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.drawing:addParam("wDraw", "Draw (W) Range", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.drawing:addParam("eDraw", "Draw (E) Range", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.drawing:addParam("rDraw", "Draw (R) Range on the Minimap", SCRIPT_PARAM_ONOFF, true)


		PanthMenu:addSubMenu("Info - Ultimate Alert", "ultAlert")
			PanthMenu.ultAlert:addParam("drawulttext", "Enable Ultimate Alert", SCRIPT_PARAM_ONOFF, true)
			PanthMenu.ultAlert:addParam("alertInfo", "It will print a text in the middle of the screen if an Enemy is Killable", SCRIPT_PARAM_INFO, "")


		PanthMenu:addParam("panthVer", "Version: ", SCRIPT_PARAM_INFO, version)		
	end


	function OnDraw()
		
		if not myHero.dead then

			if not PanthMenu.drawing.mDraw then

				if (PanthMenu.drawing.qDraw) and qReady then
		            DrawCircle3DQ(myHero.x, myHero.y, myHero.z)
		        end

		        if (PanthMenu.drawing.wDraw) and wReady then
		            DrawCircle3DE(myHero.x, myHero.y, myHero.z)
		        end

		        if (PanthMenu.drawing.eDraw) and eReady then
		            DrawCircle3DW(myHero.x, myHero.y, myHero.z)
		        end

				if (PanthMenu.drawing.rDraw) and rReady then
					DrawCircleMinimapR(myHero.x, myHero.y, myHero.z)
				end        

				if (PanthMenu.ultAlert.drawulttext) and rReady then
					ultAlert()
				end
			end
		end
	end


	function OnTick()

		ComboKey		= PanthMenu.combo.comboKey
		HarassKey		= PanthMenu.harass.harassKey
		FarmKey			= PanthMenu.farming.farmKey
		LaneClearKey	= PanthMenu.lane.laneKey
		JungleClearKey	= PanthMenu.jungle.jungleKey

		ts = TargetSelector(TARGET_LESS_CAST_PRIORITY, 900, DAMAGE_PHYSICAL)
		target = ts.target
		ts:update()

		
		enemyMinions 	= minionManager(MINION_ENEMY, 1000, myHero, MINION_SORT_MAXHEALTH_ASC)
		jungleMinions = minionManager(MINION_JUNGLE, 1100, myHero, MINION_SORT_MAXHEALTH_DEC)

        qReady = myHero:CanUseSpell(_Q) == READY
        wReady = myHero:CanUseSpell(_W) == READY
        eReady = myHero:CanUseSpell(_E) == READY
        rReady = myHero:CanUseSpell(_R) == READY


        SpellQ = {name = "Spear Shot",			range =  1000	, ready = false, dmg = 0, manaUsage = 0				   }
		SpellW = {name = "Aegis of Zeonia",		range =  125	, ready = false, dmg = 0, manaUsage = 0				   }
		SpellE = {name = "Heartseeker Strike",	range =  325	, ready = false, dmg = 0, manaUsage = 0				   }
		SpellR = {name = "Grand Skyfall",		range = 	0	, ready = false, dmg = 0, manaUsage = 0				   }


		SpellQ.manaUsage = myHero:GetSpellData(_Q).mana
		SpellW.manaUsage = myHero:GetSpellData(_W).mana
		SpellE.manaUsage = myHero:GetSpellData(_E).mana
		SpellR.manaUsage = myHero:GetSpellData(_R).mana
       
		if PanthMenu.combo.items then
    		FindItems()
  		end

		if ComboKey then
			Combo(Target)
		end

		if HarassKey then
			Harass(Target)
		end

		if FarmKey then
			Farm()
		end

		if LaneClearKey then
			LaneClear()
		end

		if JungleClearKey then
			JungleClear()
		end

		if PanthMenu.harass.autoQ then
			HerassAutoQ()
		end


		if PanthMenu.ultAlert.drawulttext then
			ultAlert()
		end

        if PanthMenu.ks.killSteal then
            KillSteal()
        end

        if PanthMenu.ks.autoIgnite then
            autoIgnite()
        end
	end


	function Combo()

		if ts.target and ValidTarget(ts.target) then

			ListCC = 3, 5, 8, 10, 11, 21, 22, 24, 28, 29
			if PanthMenu.combo.items and ImCC() then
				CastQSS()
				CastDervish()
			end

			if GetDistance(ts.target) <= 600 then
				CastSpell(_Q, ts.target)
			end

			if GetDistance(ts.target) <= 600 then
				CastSpell(_W, ts.target)
				CastTITANIC() 
			    CastTiamat() 
			    CastYoumu() 
			    CastBOTRK(ts.target) 
			end

			if GetDistance(ts.target) <= 600 then
				if HaveBuff(ts.target, 5) then
					CastSpell(_E, ts.target)
				end
			end
		end
	end


    function HerassAutoQ()

    	if ts.target and ValidTarget(ts.target) then

			if GetDistance(ts.target) <= 600 then

				if not isLow('Mana', myHero, PanthMenu.harass.harassMana) then
					CastSpell(_Q, ts.target)
				end
			end
		end
    end


	function Farm()

		enemyMinions:update()

		for each, minions in ipairs(enemyMinions.objects) do

            if minions and ValidTarget(minions) then

            	if not isLow('Mana', myHero, PanthMenu.harass.harassMana) then

	            	if GetDistance(minions) > 150 and minions.health <= getDmg("Q",minions,myHero) and PanthMenu.farming.qFarm and not isLow('Mana', myHero, PanthMenu.farm.farmMana) then
	              		CastSpell(_Q, minions)
	          		end
	          	end
            end
        end
    end


    function LaneClear()

    	enemyMinions:update()

        for each, minions in ipairs(enemyMinions.objects) do

            if minions and ValidTarget(minions) then

            	if not isLow('Mana', myHero, PanthMenu.harass.harassMana) then

					if GetDistance(minions) <= 600 and PanthMenu.lane.laneQ and not isLow('Mana', myHero, PanthMenu.lane.laneMana) then
						CastSpell(_Q, minions)
					end

					if GetDistance(minions) <= 600 and PanthMenu.lane.laneW and not isLow('Mana', myHero, PanthMenu.lane.laneMana) then
						CastSpell(_W, minions)
					end

					if GetDistance(minions) <= 600 and GetMinionsaroundMinion(600, enemyMinions) >= 3 and PanthMenu.lane.laneE and not isLow('Mana', myHero, PanthMenu.lane.laneMana) then
						CastSpell(_E, minions)	
					end
				end
			end
		end
    end


	function JungleClear()

		jungleMinions:update()

        for _,jm in pairs(jungleMinions.objects) do

            if jm and ValidTarget(jm) then

            	if not isLow('Mana', myHero, PanthMenu.harass.harassMana) then

					if GetDistance(jm) <= 600 and PanthMenu.jungle.jungleQ and not isLow('Mana', myHero, PanthMenu.jungle.jungleMana) then
						CastSpell(_Q, jm)
					end

					if GetDistance(jm) <= 600 and PanthMenu.jungle.jungleW and not isLow('Mana', myHero, PanthMenu.jungle.jungleMana) then
						CastSpell(_W, jm)
					end

					if GetDistance(jm) <= 600 and PanthMenu.jungle.jungleE and not isLow('Mana', myHero, PanthMenu.jungle.jungleMana)  then
						CastSpell(_E, jm)	
					end
				end
			end
		end
	end


	function KillSteal()

		for each, enemy in ipairs(GetEnemyHeroes()) do

            if enemy and ValidTarget(enemy) then

                if GetDistance(enemy) <= 600 and enemy.health <= getDmg("Q",enemy,myHero) then
                    CastSpell(_Q, enemy)
                elseif GetDistance(enemy) <= 600 and enemy.health <= getDmg("W",enemy,myHero) then
                    CastSpell(_W, enemy)
                elseif GetDistance(enemy) <= 600 and enemy.health <= getDmg("E",enemy,myHero) then
                    CastSpell(_E, enemy)
                elseif GetDistance(enemy) <= 600 and enemy.health <= getDmg("Q",enemy,myHero) + getDmg("W",enemy,myHero) then
                	CastSpell(_W, enemy)
                	CastSpell(_Q, enemy)
                elseif GetDistance(enemy) <= 600 and enemy.health <= getDmg("W",enemy,myHero) + getDmg("E",enemy,myHero) then
                	CastSpell(_W, enemy)
                	CastSpell(_E, enemy)
                elseif GetDistance(enemy) <= 600 and enemy.health <= getDmg("Q",enemy,myHero) + getDmg("W",enemy,myHero) + getDmg("E",enemy,myHero) then
                	CastSpell(_W, enemy)
                	CastSpell(_E, enemy)
                	CastSpell(_Q, enemy)
                end       
            end
        end
    end


    function DrawCircle3DQ(x, y, z, radius, width, color, quality)
                radius = radius or 600
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 2294967295)
    end

    function DrawCircle3DW(x, y, z, radius, width, color, quality)
                radius = radius or 600
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 2294967295)
    end

    function DrawCircle3DE(x, y, z, radius, width, color, quality)
                radius = radius or 600
                quality = quality and 2 * math.pi / quality or 2 * math.pi / (radius / 5)
                local points = {}
                    for theta = 0, 2 * math.pi + quality, quality do
                        local c = WorldToScreen(D3DXVECTOR3(x + radius * math.cos(theta), y, z - radius * math.sin(theta)))
                        points[#points + 1] = D3DXVECTOR2(c.x, c.y)
                    end
                DrawLines2(points, width or 1, color or 2294967295)
    end

	function DrawCircleMinimapR(x, y, z, radius, width, color, quality)
	    radius = radius or 5500
	    quality = math.min(quality and 2 * math.pi / quality or 2 * math.pi / (radius / 100), 0.785)
	    local points = {}
	    	for theta = 0, 2 * math.pi + quality, quality do
	        	points[#points + 1] = D3DXVECTOR2(GetMinimapX(x + radius * math.cos(theta)), GetMinimapY(z - radius * math.sin(theta)))
	    	end
	    DrawLines2(points, width or 1, color or 4294967295)
	end


	function ultAlert()

		for each, enemy in ipairs(GetEnemyHeroes()) do

	        if enemy and ValidTarget(enemy) then

				if enemy.visible and enemy ~= nil and not enemy.dead then

					if enemy.health < getDmg("R",enemy,myHero) + getDmg("Q",enemy,myHero) + getDmg("W",enemy,myHero) + getDmg("E",enemy,myHero) then
						DrawText("Drop the Man out of "..enemy.charName, 24, 300, 400, 0xFFFF0000)						
					end
				end
			end
		end
	end

	
	function HaveBuff(unit, buffs)
        for i = 1, unit.buffCount, 1 do      
            local buff = unit:getBuff(i) 
            if buff.valid and buff.type == buffs then
                return true            
            end                    
        end
	end


	function autoIgnite()

		if not Ignite then return end

		for each, enemy in ipairs(GetEnemyHeroes()) do

		       if enemy and ValidTarget(enemy) then

				if enemy.health <= 50 + (20 * myHero.level) and PanthMenu.ks.autoIgnite and myHero:CanUseSpell(Ignite) == READY then
						CastSpell(Ignite, enemy)
				end
			end
		end
	end


	function GetMinionsaroundMinion(range, minions)
		local n = 0
		for _,v in pairs(minions.objects) do
			if GetDistance(v) <= range then n = n+1 end
		end
		return n
	end


	function isLow(what, unit, slider)
		if what == 'Mana' then
			if unit.mana < (unit.maxMana * (slider / 100)) then
				return true
			else
				return false
			end
		elseif what == 'HP' then
			if unit.health < (unit.maxHealth * (slider / 100)) then
				return true
			else
				return false
			end
		end
	end

	function ImCC()
    	if HaveBuff(myHero, 3) then return true
    	elseif HaveBuff(myHero, 5) then return true
        elseif HaveBuff(myHero, 8) then return true
        elseif HaveBuff(myHero, 10) then return true
        elseif HaveBuff(myHero, 11) then return true
        elseif HaveBuff(myHero, 21) then return true
        elseif HaveBuff(myHero, 22) then return true
        elseif HaveBuff(myHero, 24) then return true
        elseif HaveBuff(myHero, 28) then return true
        elseif HaveBuff(myHero, 29) then return true
        else
        return false
        end
    end

    --------------

    --[[SpellReady]]--

	function SpellReady(spell)
	  return myHero:CanUseSpell(spell) == READY
	end
    --[[FindItems]]--

	function FindItems()
	  if (PanthMenu.combo.items) then
	    GetTiamat()
	  end
	  if (PanthMenu.combo.items) then
	    GetTitanic()
	  end
	  if (PanthMenu.combo.items) then
	    GetBOTRK()
	  end
	  if (PanthMenu.combo.items) then
	    GetCutlass()
	  end
	  if (PanthMenu.combo.items) then
	    GetYoumu()
	  end
	  if (PanthMenu.combo.items) then
	    GetGunblade()
	  end
	  if (PanthMenu.combo.items) then
	    GetQSS()
	  end
	  if (PanthMenu.combo.items) then
	    GetDervish()
	  end
	end

	--[[Get Items]]--

	function GetTiamat()
	  local slot = GetItem(ATTACKITEMS[1])
	  if (slot ~= nil) then
	    TIAMAT = true
	    TIAMATSLOT = slot
	  else
	    TIAMAT = false
	  end
	end

	function GetTitanic()
	  local slot = GetItem(ATTACKITEMS[2])
	  if (slot ~= nil) then
	    TITANIC = true
	    TITANICSLOT = slot
	  else
	    TITANIC = false
	  end
	end

	function GetCutlass()
	  local slot = GetItem(ATTACKITEMS[3])
	  if (slot ~= nil) then
	    CUTLASS = true
	    CUTLASSSLOT = slot
	  else
	    CUTLASS = false
	  end
	end

	function GetYoumu()
	  local slot = GetItem(ATTACKITEMS[4])
	  if (slot ~= nil) then
	    YOUMU = true
	    YOUMUSLOT = slot
	  else
	    YOUMU = false
	  end
	end

	function GetGunblade()
	  local slot = GetItem(ATTACKITEMS[5])
	  if (slot ~= nil) then
	    GUNBLADE = true
	    GUNBLADESLOT = slot
	  else
	    GUNBLADE = false
	  end
	end

	function GetBOTRK()
	  local slot = GetItem(ATTACKITEMS[6])
	  if (slot ~= nil) then
	    BOTRK = true
	    BOTRKSLOT = slot
	  else
	    BOTRK = false
	  end
	end

	function GetQSS()
	  local slot = GetItem(ANTICCITEMS[1])
	  if (slot ~= nil) then
	    QSS = true
	    QSSSLOT = slot
	  else
	    QSS = false
	  end
	end

	function GetDervish()
	  local slot = GetItem(ANTICCITEMS[2])
	  if (slot ~= nil) then
	    DERVISH = true
	    DERVISHSLOT = slot
	  else
	    DERVISH = false
	  end
	end

	--[[Cast Items]]--

	function CastTiamat()
	  if TIAMAT then
	    if (SpellReady(TIAMATSLOT)) then
	      CastSpell(TIAMATSLOT)
	    end
	  end
	end

	function CastYoumu()
	  if YOUMU then
	    if (SpellReady(YOUMUSLOT)) then
	      CastSpell(YOUMUSLOT)
	    end
	  end
	end

	function CastBOTRK(target)
	  if BOTRK then
	    if (SpellReady(BOTRKSLOT)) then
	      CastSpell(BOTRKSLOT, target)
	    end
	  end
	end

	function CastTITANIC()
	  if TITANIC then
	    if (SpellReady(TITANICSLOT)) then
	      CastSpell(TITANICSLOT)
	    end
	  end
	end

	function CastCutlass(target)
	  if CUTLASS then
	    if (SpellReady(CUTLASSSLOT)) then
	      CastSpell(CUTLASSSLOT, target)
	    end
	  end
	end

	function CastGunblade(target)
	  if GUNBLADE then
	    if (SpellReady(GUNBLADESLOT)) then
	      CastSpell(GUNBLADESLOT, target)
	    end
	  end
	end

	function CastQSS()
	  if QSS then
	    if SpellReady(QSSSLOT) then
	      CastSpell(QSSSLOT)
	    end
	  end
	end

	function CastDervish()
	  if DERVISH then
	    if SpellReady(DERVISHSLOT) then
	      CastSpell(DERVISHSLOT)
	    end
	  end
	end

	--[[Find Slot]]--

	function FindSlotByName(name)
	  if name ~= nil then
	    for i=0, 12 do
	      if string.lower(myHero:GetSpellData(i).name) == string.lower(name) then
	        return i
	      end
	    end
	  end  
	  return nil
	end

	--[[Get Item]]--

	function GetItem(name)
	  local slot = FindSlotByName(name)
	  return slot 
	end
