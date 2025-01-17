LinkLuaModifier( "modifier_zuus_passive_lua", "heroes/hero_zuus/zuus_passive/zuus_passive.lua", LUA_MODIFIER_MOTION_NONE )

zuus_passive_lua = class({})

function zuus_passive_lua:GetCooldown(level)
local abil = self:GetCaster():FindAbilityByName("npc_dota_hero_zuus_int7")	
		if abil ~= nil then 
		return 2
	end
	return self.BaseClass.GetCooldown(self, level)
end

function zuus_passive_lua:GetIntrinsicModifierName()
	return "modifier_zuus_passive_lua"
end

-------------------------------------------------------------------

modifier_zuus_passive_lua = class({})

function modifier_zuus_passive_lua:IsHidden()
	return false
end

function modifier_zuus_passive_lua:RemoveOnDeath()
	return true
end

function modifier_zuus_passive_lua:OnCreated()	
	self:StartIntervalThink(0.1)
end

function modifier_zuus_passive_lua:OnIntervalThink()
	if IsServer() and self:GetAbility() and self:GetCaster():IsRealHero() and self:GetCaster():IsAlive() and not self:GetParent():PassivesDisabled() then
		if self:GetAbility():IsCooldownReady() then
			local caster = self:GetCaster()
			
			local ability = self:GetAbility()
			local damageType = DAMAGE_TYPE_MAGICAL
			local int = caster:GetIntellect()
			local damage_per_int = ability:GetSpecialValueFor("dmg_per_int")
			
			if caster:FindAbilityByName("npc_dota_hero_zuus_int11") ~= nil then 
				damage_per_int = ability:GetSpecialValueFor("dmg_per_int") + 0.1
			end
			
			if caster:FindAbilityByName("npc_dota_hero_zuus_int_last") ~= nil then 
				damage_per_int = ability:GetSpecialValueFor("dmg_per_int") + 1
			end

			if caster:IsAlive() then
			
			local damage = damage_per_int * int
			hEnemies = FindUnitsInRadius( self:GetAbility():GetCaster():GetTeamNumber(), self:GetAbility():GetCaster():GetAbsOrigin(), nil, 600, DOTA_UNIT_TARGET_TEAM_ENEMY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
			if hEnemies ~= nil then
			
				local abil = caster:FindAbilityByName("npc_dota_hero_zuus_str7")	
				if abil ~= nil then 
					if caster:HasModifier("modifier_zuus_armor") then
						caster:RemoveModifierByName("modifier_zuus_armor")
					end
					caster:AddNewModifier(caster, ability, "modifier_zuus_armor", {})
					caster:SetModifierStackCount("modifier_zuus_armor", caster, #hEnemies)	
				end
			
				local abil = caster:FindAbilityByName("npc_dota_hero_zuus_int6")	
				if abil ~= nil then 
				local ability2 = caster:FindAbilityByName("zuus_arc_lightning_lua")	
					if ability2 ~= nil and ability2:GetLevel() > 0 and hEnemies[1] ~= nil then
						_G.arctatget = hEnemies[1]
						caster:FindAbilityByName("zuus_arc_lightning_lua"):OnSpellStart()
					local level = ability2:GetLevel()
					Timers:CreateTimer(0.1, function()
						caster:SetMana(caster:GetMana() + ability2:GetManaCost(level))
						ability2:EndCooldown()
					end)
					end
				end
			
			
				for _,unit in pairs(hEnemies) do
				
					local abil = caster:FindAbilityByName("npc_dota_hero_zuus_agi6")	
					if abil ~= nil then 
						unit:AddNewModifier(caster, ability, "modifier_passive_armor", {duration = 1})
					end
					
					damage_flags = DOTA_DAMAGE_FLAG_NONE
					
					
					local abil = caster:FindAbilityByName("npc_dota_hero_zuus_agi11")	
					if abil ~= nil then 
						damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
						damage = damage + caster:GetAgility()
					end
					
					local abil = caster:FindAbilityByName("npc_dota_hero_zuus_str9")	
					if abil ~= nil then 
						damage = caster:GetStrength()
					end
					
						local damage = {
						victim = unit,
						attacker = caster,
						damage = damage,
						damage_type = DAMAGE_TYPE_MAGICAL,
						damage_flags = damage_flags,
						ability = ability
					}
					ApplyDamage( damage )
					local lightningBolt = ParticleManager:CreateParticle("particles/units/heroes/hero_zuus/zuus_arc_lightning_.vpcf", PATTACH_WORLDORIGIN, caster)
					ParticleManager:SetParticleControl(lightningBolt, 0, Vector(caster:GetAbsOrigin().x, caster:GetAbsOrigin().y , caster:GetAbsOrigin().z + caster:GetBoundingMaxs().z ))   
					ParticleManager:SetParticleControl(lightningBolt, 1, Vector(unit:GetAbsOrigin().x, unit:GetAbsOrigin().y, unit:GetAbsOrigin().z))
					self:GetCaster():EmitSound("Hero_Zuus.ArcLightning.Cast")
				end	
			end
			end
			self:GetAbility():UseResources(false, false, true)	
		end
	end
end

------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_passive_armor", "heroes/hero_zuus/zuus_passive/zuus_passive.lua", LUA_MODIFIER_MOTION_NONE )

modifier_passive_armor = class({})

function modifier_passive_armor:IsHidden()
	return false
end

function modifier_passive_armor:IsPurgable()
	return false
end

function modifier_passive_armor:OnCreated()
end

function modifier_passive_armor:DeclareFunctions()
	return {MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS}
end

function modifier_passive_armor:GetModifierPhysicalArmorBonus()
	return -10
end
			
------------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------------
LinkLuaModifier("modifier_zuus_armor", "heroes/hero_zuus/zuus_passive/zuus_passive.lua", LUA_MODIFIER_MOTION_NONE )

modifier_zuus_armor = class({})

function modifier_zuus_armor:IsHidden()
	return self:GetStackCount()==0
end

function modifier_zuus_armor:IsDebuff()
	return false
end

function modifier_zuus_armor:RemoveOnDeath()
    return true
end

function modifier_zuus_armor:IsPurgable()
	return false
end

function modifier_zuus_armor:DestroyOnExpire()
	return false
end

function modifier_zuus_armor:OnCreated( kv )
	self.armor = 3
	self.resist = 1
end


function modifier_zuus_armor:OnRefresh( kv )
	self.armor = 3
	self.resist = 1
end

function modifier_zuus_armor:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_PHYSICAL_ARMOR_BONUS,
		MODIFIER_PROPERTY_MAGICAL_RESISTANCE_BONUS,
	}
	return funcs
end


function modifier_zuus_armor:GetModifierPhysicalArmorBonus( params )
	return self:GetStackCount() * self.armor
end

function modifier_zuus_armor:GetModifierMagicalResistanceBonus( params )
	return self:GetStackCount() * self.resist
end