require("data/data")

function Spawn( entityKeyValues )
    if not IsServer() then
        return
    end

    if thisEntity == nil then
        return
    end
	
    thisEntity:SetContextThink( "NeutralThink", NeutralThink, 1 )
end

function NeutralThink()	
    if ( not thisEntity:IsAlive() ) then
		return -1
	end	
	if not thisEntity.bSearchedForItems then
		SearchForItems()
		thisEntity.bSearchedForItems = true
	end
	if GameRules:IsGamePaused() == true then
		return 1
	end
	
	if not thisEntity.bInitialized then
		thisEntity.vInitialSpawnPos = Vector(-1242,6291,401)
		thisEntity.bInitialized = true
	end
	
	if thisEntity:IsChanneling() then  
        return RandomFloat(0.4, 1.2)
    end
	
	local search_radius = thisEntity:GetAcquisitionRange()
	local hp = thisEntity:GetHealthPercent()
	local enemies = FindUnitsInRadius(thisEntity:GetTeamNumber(), thisEntity:GetOrigin(), nil, search_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_MAGIC_IMMUNE_ENEMIES + DOTA_UNIT_TARGET_FLAG_NO_INVIS, FIND_CLOSEST, false )
	if #enemies > 0 then
	enemy = enemies[1]
	
		counter = #boss_belka
		while counter > 1 do
			local index = math.random(counter)
			swap(boss_belka, index, counter)		
			counter = counter - 1
		end
				
		for _, T in ipairs(boss_belka) do
			local Spell = thisEntity:FindAbilityByName(T)
			if Spell then
				local Behavior = Spell:GetBehaviorInt()
				if bit.band( Behavior, DOTA_ABILITY_BEHAVIOR_UNIT_TARGET ) == DOTA_ABILITY_BEHAVIOR_UNIT_TARGET then
					Spell.Behavior = "target"
					Cast( Spell, enemy )
				elseif bit.band( Behavior, DOTA_ABILITY_BEHAVIOR_NO_TARGET ) == DOTA_ABILITY_BEHAVIOR_NO_TARGET then
					Spell.Behavior = "no_target"
					if Spell:GetSpecialValueFor("radius") == 0 then
						Cast( Spell, enemy )
					elseif ( enemy:GetOrigin()- thisEntity:GetOrigin() ):Length2D() < Spell:GetSpecialValueFor("radius") then
						Cast( Spell, enemy )
					end
				elseif bit.band( Behavior, DOTA_ABILITY_BEHAVIOR_POINT ) == DOTA_ABILITY_BEHAVIOR_POINT then
					Spell.Behavior = "point"
					Cast( Spell, enemy )
				elseif bit.band( Behavior, DOTA_ABILITY_BEHAVIOR_TOGGLE ) == DOTA_ABILITY_BEHAVIOR_POINT then
					Spell.Behavior = "toggle"
					if not Spell:GetToggleState() then 
						Spell:ToggleAbility()
					end
				elseif bit.band( Behavior, DOTA_ABILITY_BEHAVIOR_PASSIVE ) == DOTA_ABILITY_BEHAVIOR_PASSIVE then
					Spell.Behavior = "passive"
				end
			end
		end	
		if thisEntity.ItemAbility and thisEntity.ItemAbility:IsFullyCastable() then
			return UseItem()
		end	
	end	
	
	local flDist = ( thisEntity:GetOrigin() - thisEntity.vInitialSpawnPos ):Length2D()
	if flDist > 2000 then
		RetreatHome()
	end
	if flDist > 2400 then
		FindClearSpaceForUnit(thisEntity, thisEntity.vInitialSpawnPos, false)
	end
	
	return RandomFloat(0.4, 1.2)
end


function RetreatHome()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_ATTACK_MOVE,
		Position = thisEntity.vInitialSpawnPos,
	})
	return 0.5
end

function swap(array, index1, index2)
	array[index1], array[index2] = array[index2], array[index1]
end

function SearchForItems()
		for i = 0, 5 do
			local item = thisEntity:GetItemInSlot( i )
			if item then
			for _, T in ipairs(AutoCastItem) do
				if item:GetAbilityName() == T then
					thisEntity.ItemAbility = item
				end
			end
		end
	end
end

function UseItem()
	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = DOTA_UNIT_ORDER_CAST_NO_TARGET,
		AbilityIndex = thisEntity.ItemAbility:entindex(),
		Queue = false,
	})

	return 1
end

function Cast( Spell , enemy )
	
	local order_type
	local vTargetPos = enemy:GetOrigin()
	
    if Spell.Behavior == "target" then
        order_type = DOTA_UNIT_ORDER_CAST_TARGET
    elseif Spell.Behavior == "no_target" then
        order_type = DOTA_UNIT_ORDER_CAST_NO_TARGET
    elseif Spell.Behavior == "point" then
        order_type = DOTA_UNIT_ORDER_CAST_POSITION
    elseif Spell.Behavior == "passive" then
        return
    end

	ExecuteOrderFromTable({
		UnitIndex = thisEntity:entindex(),
		OrderType = order_type,
		Position = vTargetPos,
		TargetIndex = enemy:entindex(),  
		AbilityIndex = Spell:entindex(),
		Queue = false,
	})
end



