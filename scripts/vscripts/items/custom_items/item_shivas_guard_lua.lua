item_shivas_guard_lua1 = item_shivas_guard_lua1 or class({})
item_shivas_guard_lua2 = item_shivas_guard_lua1 or class({})
item_shivas_guard_lua3 = item_shivas_guard_lua1 or class({})
item_shivas_guard_lua4 = item_shivas_guard_lua1 or class({})
item_shivas_guard_lua5 = item_shivas_guard_lua1 or class({})
item_shivas_guard_lua6 = item_shivas_guard_lua1 or class({})
item_shivas_guard_lua7 = item_shivas_guard_lua1 or class({})
item_shivas_guard_lua8 = item_shivas_guard_lua1 or class({})

LinkLuaModifier("modifier_item_shivas_guard_lua", 'items/custom_items/item_shivas_guard_lua.lua', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shivas_guard_aura_lua", 'items/custom_items/item_shivas_guard_lua.lua', LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_item_shivas_guard_slow_lua", 'items/custom_items/item_shivas_guard_lua.lua', LUA_MODIFIER_MOTION_NONE)

function item_shivas_guard_lua1:GetIntrinsicModifierName()
	return "modifier_item_shivas_guard_lua"
end

function item_shivas_guard_lua1:OnSpellStart()
	-- Parameters
	local blast_radius = self:GetSpecialValueFor("blast_radius")
	local blast_speed = self:GetSpecialValueFor("blast_speed")
	local damage = self:GetSpecialValueFor("blast_damage")
	local blast_duration = blast_radius / blast_speed
	local current_loc = self:GetCaster():GetAbsOrigin()
	
	local slow_duration_tooltip	= self:GetSpecialValueFor("slow_duration_tooltip")

	local caster	= self:GetCaster()
	local ability	= self

	-- Play cast sound
	self:GetCaster():EmitSound("DOTA_Item.ShivasGuard.Activate")

	local blast_pfx = ParticleManager:CreateParticle("particles/items2_fx/shivas_guard_active.vpcf", PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
	ParticleManager:SetParticleControl(blast_pfx, 0, self:GetCaster():GetAbsOrigin())
	ParticleManager:SetParticleControl(blast_pfx, 1, Vector(blast_radius, blast_duration * 1.33, blast_speed))
	ParticleManager:ReleaseParticleIndex(blast_pfx)

	-- Initialize targets hit table
	local targets_hit = {}

	-- Main blasting loop
	local current_radius = 0
	local tick_interval = 0.1
	Timers:CreateTimer(tick_interval, function()
		-- Give vision
		AddFOWViewer(self:GetCaster():GetTeamNumber(), current_loc, current_radius, 0.1, false)

		-- Update current radius and location
		current_radius = current_radius + blast_speed * tick_interval
		current_loc = self:GetCaster():GetAbsOrigin()
		--vision_dummy:SetAbsOrigin(current_loc)

		-- Iterate through enemies in the radius
		local nearby_enemies = FindUnitsInRadius(self:GetCaster():GetTeamNumber(), current_loc, nil, current_radius, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_ANY_ORDER, false)
		for _,enemy in pairs(nearby_enemies) do
			-- Check if this enemy was already hit
			local enemy_has_been_hit = false
			for _,enemy_hit in pairs(targets_hit) do
				if enemy == enemy_hit then enemy_has_been_hit = true end
			end

			-- If not, blast it
			if not enemy_has_been_hit then
				local hit_pfx = ParticleManager:CreateParticle("particles/items2_fx/shivas_guard_impact.vpcf", PATTACH_ABSORIGIN_FOLLOW, enemy)
				ParticleManager:SetParticleControl(hit_pfx, 0, enemy:GetAbsOrigin())
				ParticleManager:SetParticleControl(hit_pfx, 1, enemy:GetAbsOrigin())
				ParticleManager:ReleaseParticleIndex(hit_pfx)

				-- Deal damage
				ApplyDamage({attacker = caster, victim = enemy, ability = ability, damage = damage, damage_type = DAMAGE_TYPE_MAGICAL})

				-- Apply slow modifier
				enemy:AddNewModifier(caster, ability, "modifier_item_shivas_guard_slow_lua", {duration = 4})

				end

				-- Add enemy to the targets hit table
				targets_hit[#targets_hit + 1] = enemy
		end
		-- If the current radius is smaller than the maximum radius, keep going
		if current_radius < blast_radius then
			return tick_interval
		end
	end)
end

-------------------------------------------------------------------------------------

modifier_item_shivas_guard_slow_lua = class({})

function modifier_item_shivas_guard_slow_lua:OnCreated()
	self.blast_movement_speed = self:GetAbility():GetSpecialValueFor("blast_movement_speed")
end

function modifier_item_shivas_guard_slow_lua:DeclareFunctions()
	return{
		MODIFIER_PROPERTY_MOVESPEED_BONUS_PERCENTAGE,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT
	}
end

function modifier_item_shivas_guard_slow_lua:GetModifierMoveSpeedBonus_Percentage()
	return self.blast_movement_speed
end

function modifier_item_shivas_guard_slow_lua:GetModifierAttackSpeedBonus_Constant()
	return self.blast_movement_speed
end

-------------------------------------------------------------------------------------
modifier_item_shivas_guard_aura_lua = class({})

function modifier_item_shivas_guard_aura_lua:IsHidden() return false end
function modifier_item_shivas_guard_aura_lua:IsPurgable() return false end
function modifier_item_shivas_guard_aura_lua:RemoveOnDeath() return false end
function modifier_item_shivas_guard_aura_lua:IsAuraActiveOnDeath() return false end

function modifier_item_shivas_guard_aura_lua:DeclareFunctions()
	return{
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE
	}
end

function modifier_item_shivas_guard_aura_lua:GetModifierHPRegenAmplify_Percentage()
	return ( self:GetAbility():GetSpecialValueFor("hp_regen_degen_aura") * (-1) )
end

-------------------------------------------------------------------------------------

modifier_item_shivas_guard_lua = class({})

function modifier_item_shivas_guard_lua:IsHidden()
	return true
end

function modifier_item_shivas_guard_lua:IsPurgable()
	return false
end

function modifier_item_shivas_guard_lua:RemoveOnDeath()	
	return false 
end

function modifier_item_shivas_guard_lua:OnCreated()
	self.bonus_intellect = self:GetAbility():GetSpecialValueFor("bonus_intellect")
	self.bonus_armor = self:GetAbility():GetSpecialValueFor("bonus_armor")
end

function modifier_item_shivas_guard_lua:DeclareFunctions()
	return {
		MODIFIER_PROPERTY_STATS_INTELLECT_BONUS,
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS
	}
end

function modifier_item_shivas_guard_lua:GetModifierBonusStats_Intellect()
	return self.bonus_intellect
end

function modifier_item_shivas_guard_lua:GetModifierPhysicalArmorBonus()
	return self.bonus_armor
end

function modifier_item_shivas_guard_lua:IsAura()						return true end
function modifier_item_shivas_guard_lua:IsAuraActiveOnDeath() 			return false end

function modifier_item_shivas_guard_lua:GetAuraRadius()				return self:GetAbility():GetSpecialValueFor("aura_radius") end
function modifier_item_shivas_guard_lua:GetAuraSearchFlags()			return DOTA_UNIT_TARGET_FLAG_NONE end
function modifier_item_shivas_guard_lua:GetAuraSearchTeam()			return DOTA_UNIT_TARGET_TEAM_ENEMY end
function modifier_item_shivas_guard_lua:GetAuraSearchType()			return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC end
function modifier_item_shivas_guard_lua:GetModifierAura()				return "modifier_item_shivas_guard_aura_lua" end
-------------------------------------------------------------------------------------
modifier_item_shivas_guard_aura_lua = class({})

function modifier_item_shivas_guard_aura_lua:DeclareFunctions()
	return{
		MODIFIER_PROPERTY_HP_REGEN_AMPLIFY_PERCENTAGE
	}
end

function modifier_item_shivas_guard_aura_lua:GetModifierHPRegenAmplify_Percentage()
	return ( self:GetAbility():GetSpecialValueFor("hp_regen_degen_aura") * (-1) )
end