modifier_centaur_repel_lua = class({})

function modifier_centaur_repel_lua:IsHidden()
	return false
end

function modifier_centaur_repel_lua:IsDebuff()
	return false
end

function modifier_centaur_repel_lua:IsPurgable()
	return false
end

function modifier_centaur_repel_lua:OnCreated( kv )
	if IsServer() then
		self.caster = self:GetCaster()
		self.sound_cast = "Hero_omniknight.Repel"
		EmitSoundOn( self.sound_cast, self:GetParent() )
		self.particle_1 = "particles/units/heroes/hero_pangolier/pangolier_tailthump_buff.vpcf"
		self.particle_2 = "particles/centaur2.vpcf"
		self.particle_3 = "particles/centaur1.vpcf"
		
			self.buff_particles = ParticleManager:CreateParticle(self.particle_1, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
			ParticleManager:SetParticleControlEnt(self.buff_particles, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,10), false) --origin
			self:AddParticle(self.buff_particles, false, false, -1, true, false)
			
			self.buff_particles = ParticleManager:CreateParticle(self.particle_2, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
			ParticleManager:SetParticleControlEnt(self.buff_particles, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,10), false) --origin
			self:AddParticle(self.buff_particles, false, false, -1, true, false)

			
			self.buff_particles = ParticleManager:CreateParticle(self.particle_3, PATTACH_ABSORIGIN_FOLLOW, self:GetCaster())
			ParticleManager:SetParticleControlEnt(self.buff_particles, 1, self:GetCaster(), PATTACH_ABSORIGIN_FOLLOW, nil, Vector(0,0,10), false) --origin
			self:AddParticle(self.buff_particles, false, false, -1, true, false)	
			
	end
end

function modifier_centaur_repel_lua:OnRefresh( kv )
end

function modifier_centaur_repel_lua:OnDestroy( kv )
	if IsServer() then
		StopSoundOn( self.sound_cast, self:GetParent() )
		local abil = self:GetCaster():FindAbilityByName("npc_dota_hero_centaur_int9")
			if abil ~= nil then
				local ability = self:GetCaster():FindAbilityByName("centaur_warrunner_hoof_stomp_lua" )
				if ability~=nil and ability:GetLevel()>=1 then
					ability:OnSpellStart()
				end
		end
	end
end

function modifier_centaur_repel_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_ABSOLUTE_NO_DAMAGE_PHYSICAL,
		MODIFIER_PROPERTY_ATTACKSPEED_BONUS_CONSTANT,
	}
	return funcs
end

function modifier_centaur_repel_lua:GetAbsoluteNoDamagePhysical()
	return 1
end

function modifier_centaur_repel_lua:GetModifierAttackSpeedBonus_Constant()
local abil = self:GetCaster():FindAbilityByName("npc_dota_hero_centaur_agi9")
	if abil ~= nil then
	return self:GetCaster():GetLevel() * 5
	end
	return 0
end

function modifier_centaur_repel_lua:CheckState()
	local state = {
	[MODIFIER_STATE_MAGIC_IMMUNE] = false,
	}
	return state
end
