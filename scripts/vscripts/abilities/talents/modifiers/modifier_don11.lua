modifier_don11 = class({})

--------------------------------------------------------------------------------

function modifier_don11:IsHidden()
	return true
end

function modifier_don11:IsPurgable()
	return false
end

function modifier_don11:RemoveOnDeath()
	return false
end

function modifier_don11:OnCreated( kv )
self.caster = self:GetCaster()
end

function modifier_don11:DeclareFunctions()
	local funcs =
	{
		MODIFIER_EVENT_ON_ABILITY_FULLY_CAST,
	}
	return funcs
end

function modifier_don11:OnAbilityFullyCast( params )	
	if IsServer() then
		if params.unit ~= self:GetParent() then
			return 0
		end
		local Ability = params.ability
		if Ability == nil then
			return 0
		end

		if Ability:IsItem() == false and RandomInt(1,100) <= 15 then
			Ability:EndCooldown()
			local nFXIndex = ParticleManager:CreateParticle( "particles/units/heroes/hero_ogre_magi/ogre_magi_multicast.vpcf", PATTACH_OVERHEAD_FOLLOW, self:GetParent() )
			ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 1, 2, 1 ) )
			ParticleManager:ReleaseParticleIndex( nFXIndex )
			EmitSoundOn( "Bogduggs.LuckyFemur", self:GetParent() )
		end
	end
	return 0
end