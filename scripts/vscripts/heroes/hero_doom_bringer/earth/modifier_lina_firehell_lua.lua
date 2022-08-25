modifier_lina_firehell_lua = class({})

--------------------------------------------------------------------------------
-- Classifications
function modifier_lina_firehell_lua:IsHidden()
	return false
end

function modifier_lina_firehell_lua:IsDebuff()
	return false
end

function modifier_lina_firehell_lua:IsPurgable()
	return false
end

--------------------------------------------------------------------------------
-- Initializations
function modifier_lina_firehell_lua:OnCreated( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "base_damage_per_second" ) * self:GetCaster():GetModifierStackCount("modifier_ability_devour_souls", self:GetCaster())
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_pct" )
	self.manacost = self:GetAbility():GetManaCost(self:GetAbility():GetLevel() - 1)
	

	if not IsServer() then return end
	local interval = 1
	self.owner = kv.isProvidedByAura~=1

	if not self.owner then return end
	-- precache damage
	self.damageTable = {
		-- victim = target,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
	}

	-- Start interval
	self:StartIntervalThink( interval )

	-- Play effects
	self:PlayEffects1()
end

function modifier_lina_firehell_lua:OnRefresh( kv )
	-- references
	local damage = self:GetAbility():GetSpecialValueFor( "base_damage_per_second" )
	self.radius = self:GetAbility():GetSpecialValueFor( "radius" )
	self.ms_bonus = self:GetAbility():GetSpecialValueFor( "bonus_movement_speed_pct" )	

	if not IsServer() then return end
	if not self.owner then return end
	-- update damage
	self.damageTable.damage = damage
end

function modifier_lina_firehell_lua:OnRemoved()
end

function modifier_lina_firehell_lua:OnDestroy()
end

--------------------------------------------------------------------------------
-- Modifier Effects
function modifier_lina_firehell_lua:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_MOVESPEED_BONUS_CONSTANT,
	}

	return funcs
end

function modifier_lina_firehell_lua:GetModifierMoveSpeedBonus_Constant()
	return self.ms_bonus
end

--------------------------------------------------------------------------------
-- Interval Effects
function modifier_lina_firehell_lua:OnIntervalThink()

	local caster = self:GetCaster()
	self:GetParent():SpendMana( self.manacost, self:GetAbility() )
	if caster:GetMana() <=  self.manacost then
	caster:RemoveModifierByName("modifier_lina_firehell_lua")	
	end

	local damage = caster:GetMaxHealth()/100 * self:GetAbility():GetSpecialValueFor( "damage_per_second_for_caster" )
	ApplyDamage({
		victim = caster,
		attacker = self:GetCaster(),
		damage = damage,
		damage_type = DAMAGE_TYPE_PURE,
		ability = self:GetAbility(),
		damage_flags = DOTA_DAMAGE_FLAG_NO_SPELL_LIFESTEAL + DOTA_DAMAGE_FLAG_NO_SPELL_AMPLIFICATION
	})
		
	local enemies = FindUnitsInRadius(
		self:GetParent():GetTeamNumber(),	-- int, your team number
		self:GetParent():GetOrigin(),	-- point, center point
		nil,	-- handle, cacheUnit. (not known)
		self.radius,	-- float, radius. or use FIND_UNITS_EVERYWHERE
		DOTA_UNIT_TARGET_TEAM_ENEMY,	-- int, team filter
		DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC,	-- int, type filter
		0,	-- int, flag filter
		0,	-- int, order filter
		false	-- bool, can grow cache
	)

	for _,enemy in pairs(enemies) do
		-- apply damage
		self.damageTable.victim = enemy
		ApplyDamage( self.damageTable )

		-- play effects
		self:PlayEffects2( enemy )
	end
end

--------------------------------------------------------------------------------
-- Aura Effects
function modifier_lina_firehell_lua:IsAura()
	return self.owner
end

function modifier_lina_firehell_lua:GetModifierAura()
	return "modifier_lina_firehell_lua"
end

function modifier_lina_firehell_lua:GetAuraRadius()
	return self.radius
end

function modifier_lina_firehell_lua:GetAuraDuration()
	return 0.5
end

function modifier_lina_firehell_lua:GetAuraSearchTeam()
	return DOTA_UNIT_TARGET_TEAM_FRIENDLY
end

function modifier_lina_firehell_lua:GetAuraSearchType()
	return DOTA_UNIT_TARGET_HERO + DOTA_UNIT_TARGET_BASIC
end

function modifier_lina_firehell_lua:GetAuraSearchFlags()
	return DOTA_UNIT_TARGET_FLAG_PLAYER_CONTROLLED
end

function modifier_lina_firehell_lua:GetAuraEntityReject( hEntity )
	if not IsServer() then return end

	if hEntity==self:GetParent() then return true end

	return hEntity:GetPlayerOwnerID()~=self:GetParent():GetPlayerOwnerID()
end

--------------------------------------------------------------------------------
-- Graphics & Animations
function modifier_lina_firehell_lua:GetEffectName()
	return "particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_buff.vpcf"
end

function modifier_lina_firehell_lua:GetEffectAttachType()
	return PATTACH_ABSORIGIN_FOLLOW
end

function modifier_lina_firehell_lua:PlayEffects1()
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_scorched_earth.vpcf"
	local sound_cast = "Hero_DoomBringer.ScorchedEarthAura"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, self:GetParent() )
	ParticleManager:SetParticleControl( effect_cast, 1, Vector( self.radius, 0, 0 ) )

	-- buff particle
	self:AddParticle(
		effect_cast,
		false, -- bDestroyImmediately
		false, -- bStatusEffect
		-1, -- iPriority
		false, -- bHeroEffect
		false -- bOverheadEffect
	)

	-- Create Sound
	EmitSoundOn( sound_cast, self:GetParent() )
end

function modifier_lina_firehell_lua:PlayEffects2( target )
	-- Get Resources
	local particle_cast = "particles/units/heroes/hero_doom_bringer/doom_bringer_scorched_earth_debuff.vpcf"

	-- Create Particle
	local effect_cast = ParticleManager:CreateParticle( particle_cast, PATTACH_ABSORIGIN_FOLLOW, target )
	ParticleManager:ReleaseParticleIndex( effect_cast )
end