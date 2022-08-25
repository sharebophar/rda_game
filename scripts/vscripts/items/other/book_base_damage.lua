LinkLuaModifier( "modifier_item_base_damage_aura", "items/other/book_base_damage", LUA_MODIFIER_MOTION_NONE )

item_base_damage_aura = class({})

function item_base_damage_aura:OnSpellStart()
	if IsServer() then
		self.caster = self:GetCaster()	
		self.radius = self:GetSpecialValueFor( "radius" )
		self.duration = self:GetSpecialValueFor( "duration" )
		local Heroes = FindUnitsInRadius( self:GetCaster():GetTeamNumber(), self:GetCaster():GetOrigin(), self:GetCaster(), self.radius, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS, 0, false )
		for _,Hero in pairs( Heroes ) do
		
		Hero:AddNewModifier(
		self.caster,
		self,
		"modifier_item_base_damage_aura", 
		{duration = self.duration})
		end
			self.caster:EmitSound("Item.TomeOfKnowledge")
			self:SpendCharge()
			local new_charges = self:GetCurrentCharges()
			if new_charges <= 0 then
			self.caster:RemoveItem(self)
		end
	end
end

----------------------------------------------------------------------------------------------------------------------------------------------------------------------
modifier_item_base_damage_aura = class({})

function modifier_item_base_damage_aura:IsHidden()
	return false
end

function modifier_item_base_damage_aura:GetTexture()
	return "scroll_6"
end

function modifier_item_base_damage_aura:IsDebuff()
	return false
end

function modifier_item_base_damage_aura:IsPurgable()
	return false
end

function modifier_item_base_damage_aura:OnCreated( kv )
	if IsServer() then 
		self.caster = self:GetCaster()
		
	end
end

function modifier_item_base_damage_aura:DeclareFunctions()
	local funcs = {
		MODIFIER_PROPERTY_BASEDAMAGEOUTGOING_PERCENTAGE,
		}
	return funcs
end

function modifier_item_base_damage_aura:GetModifierBaseDamageOutgoing_Percentage()
	return 20
end
