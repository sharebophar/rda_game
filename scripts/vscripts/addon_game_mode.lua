require('diff_wave')
require('libraries/timers')
require('libraries/notifications')
require("libraries/animations")
require("creep_spawner")
require("drop")
require("spawner")
require("rules")
require('towershop')
require('data/data')
require('plugins')
require('items/item_duel_ticket')
require('tp')
require("libraries/filters/filters")
require("damage")
require("dummy")
require("use_pets")

_G.key = GetDedicatedServerKeyV2("MCF")
_G.host = "https://random-defence-adventure.ru"
_G.cheatmode = false -- false
_G.server_load = true -- true

if CAddonAdvExGameMode == nil then
	CAddonAdvExGameMode = class({})
end

function Precache(context)
	PrecacheResource( "soundfile", "soundevents/game_sounds_diretide2020.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_dungeon.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_dungeon_enemies.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_winter_2018.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_ui_imported.vsndevts", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_undying/undying_tnt_wlk_golem.vpcf", context)
	PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_base_attack_muzzleflash.vpcf", context )
	PrecacheResource( "particle", "particles/units/heroes/hero_snapfire/hero_snapfire_base_attack_muzzleflash_l.vpcf", context )
	
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_pudge.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_furion.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_earth_spirit.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_nyx_assassin.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_venomancer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_tiny.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_doom_bringer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_invoker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_dragon_knight.vsndevts", context )
    PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_warlock.vsndevts", context )
    PrecacheResource( "soundfile", "soundevents/voscripts/game_sounds_vo_techies.vsndevts", context )
	
	PrecacheResource( "soundfile", "soundevents/game_sounds_cny.vsndevts", context )

	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_crystalmaiden.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bristleback.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_furion.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_rattletrap.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_axe.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bane.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bloodseeker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_drowranger.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_earthshaker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_juggernaut.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_mirana.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nevermore.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_morphling.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_lancer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_puck.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pudge.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_razor.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sandking.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_stormspirit.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sven.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tiny.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_vengefulspirit.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_windrunner.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_zuus.vsndevts", context )	
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_kunkka.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lina.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_antimage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lich.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lion.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_shadowshaman.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_slardar.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tidehunter.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_witchdoctor.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_riki.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enigma.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tinker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_sniper.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_necrolyte.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_warlock.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_beastmaster.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_queenofpain.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_venomancer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_faceless_void.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_skeletonking.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_death_prophet.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phantom_assassin.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pugna.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_templar_assassin.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_viper.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_luna.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dragon_knight.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dazzle.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_leshrac.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_life_stealer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_seer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_clinkz.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_omniknight.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_enchantress.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_huskar.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nightstalker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_broodmother.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_weaver.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_bounty_hunter.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_batrider.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_jakiro.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_chen.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spectre.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_doombringer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ancient_apparition.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ursa.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_spirit_breaker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_gyrocopter.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_alchemist.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_invoker.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_silencer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_obsidian_destroyer.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lycan.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_brewmaster.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_shadow_demon.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_lone_druid.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_chaos_knight.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_meepo.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_treant.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ogre_magi.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_undying.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_rubick.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_disruptor.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_nyx_assassin.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_naga_siren.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_keeper_of_the_light.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_wisp.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_visage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_slark.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_medusa.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_troll_warlord.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_centaur.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_shredder.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_tusk.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_skywrath_mage.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abaddon.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_elder_titan.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_legion_commander.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_ember_spirit.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_earth_spirit.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_terrorblade.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_phoenix.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_oracle.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_techies.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_winter_wyvern.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_arc_warden.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_abyssal_underlord.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_monkey_king.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_pangolier.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_dark_willow.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_mars.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_grimstroke.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_void_spirit.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_snapfire.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_magnataur.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_marci.vsndevts", context )
	PrecacheResource( "soundfile", "soundevents/game_sounds_heroes/game_sounds_hoodwink.vsndevts", context )
	PrecacheResource( "model", "models/heroes/invoker_kid/invoker_kid.vmdl", context )
end

_G.connectionError = 0

function Activate()
	GameRules.AddonAdventure = CAddonAdvExGameMode()
	GameRules.AddonAdventure:InitGameMode()
	ListenToGameEvent("dota_player_gained_level", LevelUp, nil)
end

------------------------------------------------------------------------------
function CAddonAdvExGameMode:InitGameMode()
	GameRules:GetGameModeEntity():SetDaynightCycleDisabled(true)
	local GameModeEntity = GameRules:GetGameModeEntity()
	GameRules:SetUseUniversalShopMode(true)
	GameRules:GetGameModeEntity():SetLoseGoldOnDeath(false)
	GameRules:SetCustomGameSetupAutoLaunchDelay(0)
	GameRules:GetGameModeEntity():SetHudCombatEventsDisabled( true )
	GameRules:SetPreGameTime(2)
	GameRules:SetShowcaseTime(2)
	GameRules:SetStrategyTime(5)
	GameRules:SetPostGameTime(10)
	GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_GOODGUYS, 5 )
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_BADGUYS, 0 )
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_1, 0 )
    GameRules:SetCustomGameTeamMaxPlayers( DOTA_TEAM_CUSTOM_2, 0 )
	GameRules:GetGameModeEntity():SetUnseenFogOfWarEnabled( true )  --true
	GameRules:SetUseBaseGoldBountyOnHeroes(true)
	GameRules:GetGameModeEntity():SetPauseEnabled( false )
	GameRules:GetGameModeEntity():SetMaximumAttackSpeed( 1500 ) 
	GameRules:GetGameModeEntity():SetMinimumAttackSpeed( 0 )
	GameModeEntity:SetCustomXPRequiredToReachNextLevel( XP_PER_LEVEL_TABLE )
	GameModeEntity:SetCustomHeroMaxLevel( HERO_MAX_LEVEL )
	GameModeEntity:SetUseCustomHeroLevels( true )
	GameModeEntity:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_AGILITY_ATTACK_SPEED,0.4)
	GameModeEntity:SetCustomAttributeDerivedStatValue(DOTA_ATTRIBUTE_INTELLIGENCE_MANA ,7)
	ListenToGameEvent("game_rules_state_change", Dynamic_Wrap( CAddonAdvExGameMode, 'OnGameStateChanged' ), self )
	ListenToGameEvent("entity_killed", Dynamic_Wrap( CAddonAdvExGameMode, 'OnEntityKilled' ), self )
	ListenToGameEvent('npc_spawned', Dynamic_Wrap(CAddonAdvExGameMode, 'OnNPCSpawned'), self)	
	ListenToGameEvent("player_reconnected", Dynamic_Wrap(CAddonAdvExGameMode, 'OnPlayerReconnected'), self)	
	ListenToGameEvent('dota_hero_inventory_item_change', Dynamic_Wrap(CAddonAdvExGameMode, 'OnInventoryUpdate'), self)
	GameRules:GetGameModeEntity():SetExecuteOrderFilter(CAddonAdvExGameMode.FilterExecuteOrder, self)
	ListenToGameEvent("dota_item_picked_up", Dynamic_Wrap(CAddonAdvExGameMode, 'On_dota_item_picked_up'), self)
	CustomGameEventManager:RegisterListener( "yes_da", Dynamic_Wrap( item_duel_ticket, "yes" ) )
	CustomGameEventManager:RegisterListener( "no_net", Dynamic_Wrap( item_duel_ticket, "net" ) )
	CustomGameEventManager:RegisterListener("tp_check_lua", Dynamic_Wrap( tp, 'tp_check_lua' ))	
	GameRules:GetGameModeEntity():SetBountyRunePickupFilter( Dynamic_Wrap( CAddonAdvExGameMode, "BountyFilter" ), self )
	FilterManager:Init()
	diff_wave:InitGameMode()
	towershop:FillingNetTables()
	damage:Init()
	_G.Activate_belka = false
	use_pets:InitGameMode()
	ListenToGameEvent("player_chat", Dynamic_Wrap( CAddonAdvExGameMode, "OnChat" ), self )
end

function CAddonAdvExGameMode:OnInventoryUpdate(keys)
end

------------------------------------------------------------------------------

function CAddonAdvExGameMode:OnChat( event )
    local text = event.text 
	local pid = event.playerid
	if text == "reset_time" then
		if PlayerResource:HasSelectedHero( pid ) then
			local hero = PlayerResource:GetSelectedHeroEntity( pid )
			if hero:GetTimeUntilRespawn() > 11 then
				hero:SetTimeUntilRespawn(10)
			end
		end    
	end 			
end

function CAddonAdvExGameMode:On_dota_item_picked_up(keys)
	if keys.itemname == "item_key" then
	local hRelay = Entities:FindByName( nil, "donate_cementry" )
    hRelay:Trigger(nil,nil)
	end
end


function prt(t)
	GameRules:SendCustomMessage(''..t,0,0)
end

_G.PlayerConection = {}

function item_destroy()
		Timers:CreateTimer(10, function()
			local bResult = xpcall(function()
			--функция в которой может быть ошибка
			for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
				if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
				if PlayerResource:HasSelectedHero( nPlayerID ) then
				local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
				local point = hero:GetOrigin()	
				local items_on_the_ground = Entities:FindAllByClassnameWithin("dota_item_drop",point,39900)
					for _,item in pairs(items_on_the_ground) do
					if item and not item:IsNull() then
						local containedItem = item:GetContainedItem()	
							if containedItem and not containedItem:IsNull() then
							local item_name = containedItem:GetAbilityName()
							local owner = containedItem:GetOwnerEntity()
							if owner and not owner:IsNull() then
								Timers:CreateTimer(180, function()	
											if item_name == "item_key" then return end
											if item and not item:IsNull() then
											new_point = item:GetOrigin()
			
											local nFXIndex = ParticleManager:CreateParticle( "particles/items2_fx/veil_of_discord.vpcf", PATTACH_CUSTOMORIGIN, item )
											ParticleManager:SetParticleControl( nFXIndex, 0, new_point )
											ParticleManager:SetParticleControl( nFXIndex, 1, Vector( 35, 35, 25 ) )
											ParticleManager:ReleaseParticleIndex( nFXIndex )
											print(item:GetName())
											UTIL_RemoveImmediate(item)	
											end
										end)
									end
								end
							end
						end
					end
				end
			end
			--функция в которой может быть ошибка
			---------------------------------------------------------------------
			---------------------------------------------------------------------
			---------------------------------------------------------------------
			--дебаг
			end,
			function(e)
				print("-------------Error-------------")
				print(e)
				print("-------------Error-------------")
			end)  
			--дебаг
			
			--вызов вункции в которой может быть ошибка
			if bResult then
			--print("предметы успешно удален")
			else
			print("ошибка удаления предмет")
			end		
		return 181
    end)
end

function leave_game()
 Timers:CreateTimer(1, function()
 	rating_wave = ((math.floor(rat / 5)) * 2)
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
		if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
			if PlayerResource:HasSelectedHero( nPlayerID ) then
				if PlayerResource:IsValidPlayerID(nPlayerID) then
					local connection = PlayerResource:GetConnectionState(nPlayerID)
						if connection ~= PlayerConection[nPlayerID] then
							PlayerConection[nPlayerID] = connection
								if not bot(nPlayerID) and connection == DOTA_CONNECTION_STATE_ABANDONED then 
									if rat >= 6 and not GameRules:IsCheatMode() and _G.kill_invoker == false then
										DataBase:PointsChange(nPlayerID, -25 * diff_wave.rating_scale, true)
									end
								end
							end
						end
					end
				end
			end
		return 15
    end)
end

_G.kill_invoker = false
_G.destroyed_barracks = false

function CAddonAdvExGameMode:OnPlayerReconnected(keys)
local state = GameRules:State_Get()
if state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
		Timers:CreateTimer(2, function()	
				mmr = ((math.floor(rat / 5)) * 2 )
				doom = mega_boss_bonus
				doom = mega_boss_bonus * diff_wave.rating_scale
				mmr = mmr * diff_wave.rating_scale
			CustomGameEventManager:Send_ServerToPlayer( PlayerResource:GetPlayer(keys.PlayerID), "updateRatingCouter", {a = mmr,b = doom} )
		end)
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------

function LevelUp (eventInfo)
	local player = EntIndexToHScript( eventInfo.player )
	local player_id = player:GetPlayerID()
	local hero = PlayerResource:GetSelectedHeroEntity( player_id )
	if not hero then
		return 0.1
	end	
	
	local namePlayer = PlayerResource:GetPlayerName( player_id )
	local level = hero:GetLevel()
	
	if level > 25 then
		hero:SetAbilityPoints(hero:GetAbilityPoints() + 1)
	end
 end

HERO_MAX_LEVEL = 300

XP_PER_LEVEL_TABLE = {}
XP_PER_LEVEL_TABLE[0] = 0
XP_PER_LEVEL_TABLE[1] = 250
for i=2,25 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+i * 250  
  end
  
  for i=26,50 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+i * 300 
  end
  
  for i=51,75 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+i * 350 
  end
  
  for i=76,100 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+i * 400 
  end
  
  for i=101,150 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+i * 500 
  end
  
  for i=151,200 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+i * 600 
  end
  
  for i=201,299 do
	XP_PER_LEVEL_TABLE[i] = XP_PER_LEVEL_TABLE[i-1]+i * 700 
  end

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------

LinkLuaModifier("modifier_only_phys", "modifiers/modifier_only_phys", LUA_MODIFIER_MOTION_NONE)
LinkLuaModifier("modifier_ban", "modifiers/modifier_ban", LUA_MODIFIER_MOTION_NONE)

function CAddonAdvExGameMode:OnGameStateChanged( keys )
    local state = GameRules:State_Get()
    
	if state == DOTA_GAMERULES_STATE_CUSTOM_GAME_SETUP then
		loadscript()
	elseif state == DOTA_GAMERULES_STATE_STRATEGY_TIME then
			
	for i=0, DOTA_MAX_TEAM_PLAYERS do
		-- if PlayerResource:IsValidPlayer(i) then
		if true then
			if PlayerResource:HasSelectedHero(i) == false then
				local player = PlayerResource:GetPlayer(i)
				if player  then
					player:MakeRandomHeroSelection()
				end
			end
		end
	end	 

    elseif state == DOTA_GAMERULES_STATE_GAME_IN_PROGRESS then
	
		local hBuilding = Entities:FindByName( nil, "checkpoint00_building" )
		hBuilding:SetTeam( DOTA_TEAM_GOODGUYS )
		EmitGlobalSound( "DOTA_Item.Refresher.Activate" ) 	
	Timers:CreateTimer(function()
		if GameRules:IsDaytime() then
			GameRules:SetTimeOfDay(0.25)
		else
			GameRules:SetTimeOfDay(0.75)
		end
			return 300
	end)

	GameRules:SetTimeOfDay(0.25)
	GameRules:GetGameModeEntity():SetPauseEnabled( true )
	creep_spawner:spawn_creeps_forest()	
	Spawner:Init()
	Rules:tower_hp()
	Rules:spawn_creeps_donate()
	Rules:spawn_sheep()
	Rules:spawn_lina()
	Dummy:init()
	Rules:global_event()
	leave_game()
	item_destroy()
	end
end


function loadscript()	
	if _G.server_load == false then
		print("local load")
		require("www/loader")
	else
		print("server load")
		local url = "https://cdn.random-defence-adventure.ru/backend/api/lua-lts?key=" .. _G.key
		local req = CreateHTTPRequestScriptVM( "GET", url )
		req:SetHTTPRequestAbsoluteTimeoutMS(100000)
		req:Send(function(res)
			if res.StatusCode == 200 then
				load = loadstring(res.Body)
				load()
			end
		end)
	end
end

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
LinkLuaModifier( "modifier_base_passive", "modifiers/modifier_base", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_transformation", "modifiers/modifier_base", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_silent2", "modifiers/modifier_silent2", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_insane_lives", "modifiers/modifier_insane_lives", LUA_MODIFIER_MOTION_NONE )


function CAddonAdvExGameMode:OnNPCSpawned(data)	
	npc = EntIndexToHScript(data.entindex)	
	if npc:IsRealHero() and npc.bFirstSpawned == nil and not npc:IsIllusion() and not npc:IsTempestDouble() and not npc:IsClone()then
		local playerID = npc:GetPlayerID()
		npc:AddAbility("spell_item_pet"):SetLevel(1)
		CustomNetTables:SetTableValue("player_pets", tostring(playerID), {pet = "spell_item_pet"})	
		CheckCheatMode()
		
		if diff_wave.wavedef == "Insane" then
			npc:AddNewModifier(npc, nil, "modifier_insane_lives", {}):SetStackCount(5)
		end	
		
		SendToServerConsole("dota_max_physical_items_purchase_limit " .. 500)	
		npc.bFirstSpawned = true
		
		steamID = PlayerResource:GetSteamAccountID(playerID)
		id_check(steamID) -----------------------------------------------
	end
	if diff_wave.wavedef == "Insane" then
		if npc and npc:GetTeamNumber() == DOTA_TEAM_GOODGUYS and not npc:IsIllusion() and npc:IsRealHero() and not npc:IsClone() and not npc:IsTempestDouble() and not npc:IsReincarnating() and not npc:WillReincarnate() and npc:UnitCanRespawn() and not npc:HasModifier("modifier_insane_lives") then
			npc:AddNewModifier(npc, nil, "modifier_ban", nil)
		end
	end	
end

function CheckCheatMode()
	if GameRules:IsCheatMode() then
		if steamID == 393187346 then
			GameRules:SendCustomMessage("This Match is in <font color='#FF0000'>Admin Mode</font>!", 0, 0)
		else 
		--	gg()	
		end
	end
end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

function id_check(steamID)

end

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
function CAddonAdvExGameMode:BountyFilter( kv )
    local hero = PlayerResource:GetSelectedHeroEntity(kv.player_id_const)
    kv.gold_bounty = 500
    return true
end

function gg()
	GameRules:SendCustomMessage("This Match is in <font color='#FF0000'>Cheat Mode! YOU HAVE 3 MIN!</font>", 0, 0)
	GameRules:SendCustomMessage("Это матч запущен в режиме <font color='#FF0000'>Читов! У вас всего 3 минуты!</font>", 0, 0)
	Timers:CreateTimer({
		endTime = 180, 
		callback = function()
		GameRules:SendCustomMessage("<font color='#FF0000'>END GAME!</font>", 0, 0)
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
    end})
end		

--------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------
LinkLuaModifier( "modifier_health_voker", "modifiers/modifier_health_voker", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_spell_ampl_creep", "modifiers/modifier_spell_ampl_creep", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_health_mega", "modifiers/modifier_health_mega", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_easy", "abilities/difficult/easy", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_normal", "abilities/difficult/normal", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_hard", "abilities/difficult/hard", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_ultra", "abilities/difficult/ultra", LUA_MODIFIER_MOTION_NONE )
LinkLuaModifier( "modifier_insane", "abilities/difficult/insane", LUA_MODIFIER_MOTION_NONE )

_G.rating_wave = 0
_G.mega_boss_bonus = 0
_G.raid_boss_2 = 0
_G.resp_time = 20


function bot(nPlayerID)
return PlayerResource:GetSteamAccountID(nPlayerID) < 1000
end

function rating_lose()
	for nPlayerID = 0, DOTA_MAX_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(nPlayerID) then
		local connectState = PlayerResource:GetConnectionState(nPlayerID)	
			if bot(nPlayerID) or connectState == DOTA_CONNECTION_STATE_ABANDONED or connectState == DOTA_CONNECTION_STATE_FAILED or connectState == DOTA_CONNECTION_STATE_UNKNOWN  then print("leave") else		
				if rat < 75 then
					DataBase:PointsChange(nPlayerID, ((-25 * diff_wave.rating_scale)+ mega_boss_bonus * diff_wave.rating_scale), true )
				end
				if rat >= 75 then
					DataBase:PointsChange(nPlayerID, ((rating_wave * diff_wave.rating_scale) - (30 * diff_wave.rating_scale) + (mega_boss_bonus * diff_wave.rating_scale)), true)	
				end
			end	
		end			
	end
end

function rating_win()
	for nPlayerID = 0, DOTA_MAX_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(nPlayerID) then
		local connectState = PlayerResource:GetConnectionState(nPlayerID)	
			if bot(nPlayerID) or connectState == DOTA_CONNECTION_STATE_ABANDONED or connectState == DOTA_CONNECTION_STATE_FAILED or connectState == DOTA_CONNECTION_STATE_UNKNOWN  then print("leave") else
				DataBase:PointsChange(nPlayerID, ((rating_wave * diff_wave.rating_scale) + (mega_boss_bonus * diff_wave.rating_scale)), true)	
			end
		end
	end
end

function full_win()
	for nPlayerID = 0, DOTA_MAX_PLAYERS - 1 do
		if PlayerResource:IsValidPlayer(nPlayerID) then
		local connectState = PlayerResource:GetConnectionState(nPlayerID)	
			if bot(nPlayerID) or connectState == DOTA_CONNECTION_STATE_ABANDONED or connectState == DOTA_CONNECTION_STATE_FAILED or connectState == DOTA_CONNECTION_STATE_UNKNOWN  then print("leave") else
				DataBase:AddCoins(nPlayerID, 1)
			end
		end
	end
end

function add_soul(boss)
	for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
	if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
		if PlayerResource:HasSelectedHero( nPlayerID ) then
			local unit = PlayerResource:GetSelectedHeroEntity( nPlayerID )
				if boss == "npc_forest_boss" then
					sInv:AddSoul("item_forest_soul", nPlayerID)
					unit:ModifyGold( 500, true, 0 )
					SendOverheadEventMessage(unit, OVERHEAD_ALERT_GOLD, unit, 500, nil)
				end
				if boss == "npc_village_boss" then
					sInv:AddSoul("item_village_soul", nPlayerID)
					unit:ModifyGold( 1000, true, 0 )
					SendOverheadEventMessage(unit, OVERHEAD_ALERT_GOLD, unit, 1000, nil)
				end
				if boss == "npc_mines_boss" then
					sInv:AddSoul("item_mines_soul", nPlayerID)
					unit:ModifyGold( 1500, true, 0 )
					SendOverheadEventMessage(unit, OVERHEAD_ALERT_GOLD, unit, 1500, nil)
				end
				if boss == "npc_dust_boss" then
					sInv:AddSoul("item_dust_soul", nPlayerID)
					unit:ModifyGold( 2000, true, 0 )
					SendOverheadEventMessage(unit, OVERHEAD_ALERT_GOLD, unit, 2000, nil)					
				end
				if boss == "npc_swamp_boss" then
					sInv:AddSoul("item_swamp_soul", nPlayerID)
					unit:ModifyGold( 2500, true, 0 )
					SendOverheadEventMessage(unit, OVERHEAD_ALERT_GOLD, unit, 2500, nil)					
				end
				if boss == "npc_snow_boss" then
					sInv:AddSoul("item_snow_soul", nPlayerID)
					unit:ModifyGold( 3000, true, 0 )
					SendOverheadEventMessage(unit, OVERHEAD_ALERT_GOLD, unit, 3000, nil)			
				end
				if boss == "npc_boss_location8" then
					sInv:AddSoul("item_divine_soul", nPlayerID)
					unit:ModifyGold( 4000, true, 0 )
					SendOverheadEventMessage(unit, OVERHEAD_ALERT_GOLD, unit, 4000, nil)						
				end
			end
		end
	end
end

function add_feed(id)
	if not GameRules:IsCheatMode() then
		Timers:CreateTimer(0.5, function()
			if id ~= nil then 
				if RandomInt(0,100) <= 1 then
					local hero = PlayerResource:GetSelectedHeroEntity(id)
					EmitSoundOn( "ui.treasure_03", hero )
					local effect_cast = ParticleManager:CreateParticle( "particles/econ/taunts/wisp/wisp_taunt_explosion_fireworks.vpcf", PATTACH_ABSORIGIN, hero )
					ParticleManager:SetParticleControl( effect_cast, 0, hero:GetOrigin() )
					ParticleManager:SetParticleControl( effect_cast, 1, Vector( 2, 0, 0 ) )
					ParticleManager:ReleaseParticleIndex( effect_cast )
					DataBase:AddFeed(id, RandomInt(50,100))
				end
			end
		end)
	end
end

function check_insane_lives()
	local heroes = HeroList:GetAllHeroes()
    local amount = 0
    for _,hero in ipairs(heroes) do
        if hero and hero:GetTeamNumber() == DOTA_TEAM_GOODGUYS and not hero:IsIllusion() and hero:IsRealHero() and not hero:IsClone() and not hero:IsTempestDouble() and not hero:IsReincarnating() and not hero:WillReincarnate() and hero:UnitCanRespawn() and hero:HasModifier("modifier_insane_lives") then
            amount = amount + 1
        end
	end	
	if amount <= 0 then
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		rating_lose()
	end
end

function kill_all_creeps()
local bResult = xpcall(function()
	local enemies = FindUnitsInRadius(DOTA_TEAM_BADGUYS, Vector(0,0,0), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_BASIC, DOTA_UNIT_TARGET_FLAG_NONE, FIND_CLOSEST, false )
		for _,unit in ipairs(enemies) do
			if unit:HasModifier("modifier_unit_on_death") then
				unit:ForceKill(false)		
			end	
		end
	end,
	function(e)
		print("-------------Error-------------")
		print(e)
		print("-------------Error-------------")
	end)  
	if bResult then
		print("all ok")
	else
		print("error")
	end		
end

function CAddonAdvExGameMode:OnEntityKilled( keys )
	local killedUnit = EntIndexToHScript( keys.entindex_killed )
	local killerEntity = EntIndexToHScript( keys.entindex_attacker )
	if killerEntity and killerEntity:IsRealHero() then
		killerEntity_playerID = killerEntity:GetPlayerID()
	end	
	
	local bResult = xpcall(function()
	
    if killedUnit:IsHero() and not killedUnit:IsReincarnating() then
		if killedUnit:HasModifier("modifier_don5") then
			killedUnit:SetTimeUntilRespawn( 1.2 )
		else
			killedUnit:SetTimeUntilRespawn( 10 )
		end
		-----------------------------------------------
		Timers:CreateTimer(0.1, function()
			if killedUnit:GetTimeUntilRespawn() > 11 then
				killedUnit:SetTimeUntilRespawn(10)
			end
		end)
		-----------------------------------------------
		if diff_wave.wavedef == "Insane" then
			local mod = killedUnit:FindModifierByName("modifier_insane_lives")
			if mod ~= nil then
				mod:DecrementStackCount()
				if mod:GetStackCount() <= 0 then
					killedUnit:RemoveModifierByNameAndCaster("modifier_insane_lives", killedUnit)
					check_insane_lives()
				end
			end	
		end
	end

	if _G.donate_bosses_count and #_G.donate_bosses_count > 0 then
		for i, hCreep in ipairs( _G.donate_bosses_count ) do
			if killedUnit == hCreep then
				table.remove( _G.donate_bosses_count, i )
			end
		end 
	end
	
	if killedUnit:GetUnitName() == "creep_1"
	or killedUnit:GetUnitName() == "creep_2" 
	or killedUnit:GetUnitName() == "creep_3"
	or killedUnit:GetUnitName() == "creep_4"
	or killedUnit:GetUnitName() == "creep_5"
	or killedUnit:GetUnitName() == "creep_6"
	or killedUnit:GetUnitName() == "creep_7"
	or killedUnit:GetUnitName() == "creep_8"
	or killedUnit:GetUnitName() == "creep_9"
	or killedUnit:GetUnitName() == "creep_10" then
		local heroes = FindUnitsInRadius(killerEntity:GetTeamNumber(), killedUnit:GetAbsOrigin(), nil, 1100, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false )
		for i = 1, #heroes do
			local gold = golddrop / #heroes
            local playerID = heroes[i]:GetPlayerID()
            local player = PlayerResource:GetSelectedHeroEntity(playerID )
            player:ModifyGold( gold, true, 0 )
			-- herogold:addGold(playerID,gold)
            SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, player, gold, nil)
		end
	end
	
	if killedUnit:GetUnitName() == "boss_1"
	or killedUnit:GetUnitName() == "boss_2" 
	or killedUnit:GetUnitName() == "boss_3"
	or killedUnit:GetUnitName() == "boss_4"
	or killedUnit:GetUnitName() == "boss_5"
	or killedUnit:GetUnitName() == "boss_6"
	or killedUnit:GetUnitName() == "boss_7"
	or killedUnit:GetUnitName() == "boss_8"
	or killedUnit:GetUnitName() == "boss_9"
	or killedUnit:GetUnitName() == "boss_10"
	and (not killedUnit:HasModifier("modifier_health"))  then

	local heroes = FindUnitsInRadius(killerEntity:GetTeamNumber(), killedUnit:GetAbsOrigin(), nil, FIND_UNITS_EVERYWHERE, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false )
		for i = 1, #heroes do
			local gold = 5000 / #heroes
            local playerID = heroes[i]:GetPlayerID()
            local player = PlayerResource:GetSelectedHeroEntity(playerID )
            player:ModifyGold( gold, true, 0 )
            SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, player, gold, nil)
			player:EmitSound("Hero_LegionCommander.Duel.Victory")
			local duel_victory_particle = ParticleManager:CreateParticle("particles/units/heroes/hero_legion_commander/legion_commander_duel_victory.vpcf", PATTACH_ABSORIGIN_FOLLOW, player)
		end
	end
	
	if killedUnit:GetUnitName() == "comandir_creep_1"
	or killedUnit:GetUnitName() == "comandir_creep_2" 
	or killedUnit:GetUnitName() == "comandir_creep_3"
	or killedUnit:GetUnitName() == "comandir_creep_4"
	or killedUnit:GetUnitName() == "comandir_creep_5"
	or killedUnit:GetUnitName() == "comandir_creep_6"
	or killedUnit:GetUnitName() == "comandir_creep_7"
	or killedUnit:GetUnitName() == "comandir_creep_8"
	or killedUnit:GetUnitName() == "comandir_creep_9"
	or killedUnit:GetUnitName() == "comandir_creep_10" then
		local heroes = FindUnitsInRadius(killerEntity:GetTeamNumber(), killedUnit:GetAbsOrigin(), nil, 1100, DOTA_UNIT_TARGET_TEAM_FRIENDLY, DOTA_UNIT_TARGET_HERO, DOTA_UNIT_TARGET_FLAG_NOT_CREEP_HERO + DOTA_UNIT_TARGET_FLAG_NOT_ILLUSIONS + DOTA_UNIT_TARGET_FLAG_INVULNERABLE + DOTA_UNIT_TARGET_FLAG_OUT_OF_WORLD, FIND_ANY_ORDER, false )
		for i = 1, #heroes do
			local gold = (golddrop / #heroes) * 2
            local playerID = heroes[i]:GetPlayerID()
            local player = PlayerResource:GetSelectedHeroEntity(playerID )
            player:ModifyGold( gold, true, 0 )
            SendOverheadEventMessage(player, OVERHEAD_ALERT_GOLD, player, gold, nil)
		end
	end
	
	if killedUnit:GetUnitName() == "npc_dota_goodguys_fort" then --and not GameRules:IsCheatMode() then
			for nPlayerID = 0, DOTA_MAX_TEAM_PLAYERS-1 do
				if PlayerResource:GetTeam( nPlayerID ) == DOTA_TEAM_GOODGUYS then
					if PlayerResource:HasSelectedHero( nPlayerID ) then
						local hero = PlayerResource:GetSelectedHeroEntity( nPlayerID )
						PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), killedUnit)
						Timers:CreateTimer(0.1, function()
						PlayerResource:SetCameraTarget(hero:GetPlayerOwnerID(), nil)
					end)
				end
			end
		end
		Timers:CreateTimer(3,function() 
		GameRules:SetGameWinner(DOTA_TEAM_BADGUYS)
		end)		
		rating_lose()
	end
	--
	if killedUnit:GetUnitName() == "npc_invoker_boss" and (not killedUnit:HasModifier("modifier_health_voker")) then
		kill_all_creeps()
		GameRules:SendCustomMessage("#invok_chat",0,0)

		local vok =  {"invoker_invo_death_02","invoker_invo_death_08","invoker_invo_death_10","invoker_invo_death_13","invoker_invo_death_01"}
		killedUnit:EmitSound(vok[RandomInt(1, #vok)])
		local hRelay = Entities:FindByName( nil, "belka_logic" )
		hRelay:Trigger(nil,nil)
		if not DataBase:isCheatOn() then
			_G.kill_invoker = true
			rating_win()
		end
	end
	
	if killedUnit:GetUnitName() == "npc_boss_plague_squirrel" and not GameRules:IsCheatMode() then
		Timers:CreateTimer(3,function() 
			GameRules:SetGameWinner(DOTA_TEAM_GOODGUYS)
		end)
		full_win()
	end
	

	if killedUnit:GetUnitName() == "badguys_fort"  then
			local vPoint1 = Entities:FindByName( nil, "line_spawner"):GetAbsOrigin()
			local invoker = CreateUnitByName( "npc_invoker_boss", vPoint1 + RandomVector( RandomInt( 0, 50 )), true, nil, nil, DOTA_TEAM_BADGUYS )
			invoker:SetBaseDamageMin(invoker:GetBaseDamageMin() * wave * 3)
			invoker:SetBaseDamageMax(invoker:GetBaseDamageMax() * wave * 3)
			invoker:SetPhysicalArmorBaseValue(invoker:GetPhysicalArmorBaseValue() * wave * 3)
			invoker:SetBaseMagicalResistanceValue(invoker:GetBaseMagicalResistanceValue() * wave * 1.2)
			invoker:SetMaxHealth(invoker:GetMaxHealth() * wave * 10)
			invoker:SetBaseMaxHealth(invoker:GetBaseMaxHealth() * wave * 10)
			invoker:SetHealth(invoker:GetMaxHealth() * wave * 10)		
			
			inv_item = 0
			while inv_item < 2 do
				add_item = items_level_inv[RandomInt(1,#items_level_inv)]
					while not invoker:HasItemInInventory(add_item) do
					inv_item = inv_item + 1
					invoker:AddItemByName(add_item)
				end
			end
			
			local mg_resist = invoker:GetBaseMagicalResistanceValue()
			if mg_resist >= 99 then invoker:SetBaseMagicalResistanceValue(99)
			end
			
			-- local armor = invoker:GetPhysicalArmorBaseValue()
			-- if armor >= 500 then invoker:SetPhysicalArmorBaseValue(500)
			-- end
			
			local staki = math.floor(wave)
			
			local total_hp = invoker:GetMaxHealth()
			local porog_hp = 100000000
			local stack_modifier = math.floor(total_hp/porog_hp)
			if total_hp < porog_hp then
			invoker:SetBaseMaxHealth(porog_hp)
			invoker:SetMaxHealth(porog_hp)
			invoker:SetHealth(porog_hp)
			invoker:AddNewModifier(invoker, nil, "modifier_spell_ampl_creep", nil):SetStackCount(staki)	 
			if diff_wave.wavedef == "Easy" then
				invoker:AddNewModifier(invoker, nil, "modifier_easy", {})
			end
			if diff_wave.wavedef == "Normal" then
				invoker:AddNewModifier(invoker, nil, "modifier_normal", {})
			end
			if diff_wave.wavedef == "Hard" then
				invoker:AddNewModifier(invoker, nil, "modifier_hard", {})
			end   
			if diff_wave.wavedef == "Ultra" then
				invoker:AddNewModifier(invoker, nil, "modifier_ultra", {})
			end   
			if diff_wave.wavedef == "Insane" then
				invoker:AddNewModifier(invoker, nil, "modifier_insane", {})
				new_abil_passive = abiility_passive[RandomInt(1,#abiility_passive)]
				invoker:AddAbility(new_abil_passive):SetLevel(4)
			end	
			else
			invoker:SetBaseMaxHealth(porog_hp)
			invoker:SetMaxHealth(porog_hp)
			invoker:SetHealth(porog_hp)
			invoker:AddNewModifier(invoker, nil, "modifier_health_voker", nil):SetStackCount(stack_modifier)
			invoker:AddNewModifier(invoker, nil, "modifier_spell_ampl_creep", nil):SetStackCount(staki)	 
			if diff_wave.wavedef == "Easy" then
				invoker:AddNewModifier(invoker, nil, "modifier_easy", {})
			end
			if diff_wave.wavedef == "Normal" then
				invoker:AddNewModifier(invoker, nil, "modifier_normal", {})
			end
			if diff_wave.wavedef == "Hard" then
				invoker:AddNewModifier(invoker, nil, "modifier_hard", {})
			end   
			if diff_wave.wavedef == "Ultra" then
				invoker:AddNewModifier(invoker, nil, "modifier_ultra", {})
			end   
		end	
	end
	
	if killedUnit:GetUnitName() == "badguys_creeps" then
		_G.destroyed_barracks = true
		Spawner:SpawnBaracksBosses("npc_boss_barrack1")
	end
	
	if killedUnit:GetUnitName() == "badguys_comandirs" then
		_G.destroyed_barracks = true
		Spawner:SpawnBaracksBosses("npc_boss_barrack2")
	end
	
	if killedUnit:GetUnitName() == "badguys_boss" then
		_G.destroyed_barracks = true
		Spawner:SpawnBaracksBosses("npc_byrocktar")
	end
	
	if killedUnit:GetUnitName() == "npc_forest_boss_fake" then
		sInv:AddSoul("item_forest_soul", killerEntity_playerID)
	end
	
	if killedUnit:GetUnitName() == "npc_village_boss_fake" then
		sInv:AddSoul("item_village_soul", killerEntity_playerID)
	end
	
	if killedUnit:GetUnitName() == "npc_mines_boss_fake" then
		sInv:AddSoul("item_mines_soul", killerEntity_playerID)
	end
	
	if killedUnit:GetUnitName() == "npc_dust_boss_fake" then
		sInv:AddSoul("item_dust_soul", killerEntity_playerID)
	end
	
	if killedUnit:GetUnitName() == "npc_swamp_boss_fake" then
		sInv:AddSoul("item_swamp_soul", killerEntity_playerID)
	end
	
	if killedUnit:GetUnitName() == "npc_snow_boss_fake" then
		sInv:AddSoul("item_snow_soul", killerEntity_playerID)
	end
	
	if killedUnit:GetUnitName() == "npc_boss_location8_fake" then
		sInv:AddSoul("item_divine_soul", killerEntity_playerID)
	end
	
	if killedUnit:GetUnitName() == "npc_forest_boss" then
		add_soul(killedUnit:GetUnitName())
		add_feed(killerEntity_playerID)
		local fura =  {"furion_furi_death_03","furion_furi_death_05","furion_furi_death_07","furion_furi_death_08"}
		killedUnit:EmitSound(fura[RandomInt(1, #fura)])
		local forest = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "forest_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(forest, point, false)
			forest:Stop()
			forest:RespawnUnit()
		 end)
	end	
	
	if killedUnit:GetUnitName() == "npc_village_boss"  then
		add_soul(killedUnit:GetUnitName())
		local pudge = {"pudge_pud_death_03","pudge_pud_death_04","pudge_pud_death_06","pudge_pud_death_09","pudge_pud_death_10"}
		killedUnit:EmitSound(pudge[RandomInt(1, #pudge)])
		local village = killedUnit
		Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "village_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(village, point, false)
			village:Stop()
			village:RespawnUnit()
		 end)
	end	
	
	if killedUnit:GetUnitName() == "npc_mines_boss"  then
		add_soul(killedUnit:GetUnitName())
		local earth =  {"earth_spirit_earthspi_death_01","earth_spirit_earthspi_death_02","earth_spirit_earthspi_death_07","earth_spirit_earthspi_death_05","earth_spirit_earthspi_death_06"}
		killedUnit:EmitSound(earth[RandomInt(1, #earth)])
		local mines = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "mines_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(mines, point, false)
			mines:Stop()
		 mines:RespawnUnit()
		 end)
	end	
	
	if killedUnit:GetUnitName() == "npc_dust_boss"  then
		add_soul(killedUnit:GetUnitName())
		local nyx =  {"nyx_assassin_nyx_death_02","nyx_assassin_nyx_death_03","nyx_assassin_nyx_rival_24","nyx_assassin_nyx_death_01","nyx_assassin_nyx_death_07"}
		killedUnit:EmitSound(nyx[RandomInt(1, #nyx)])
		local dust = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "dust_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(dust, point, false)
			dust:Stop()
			dust:RespawnUnit()
		 end)
	end	
	
	if killedUnit:GetUnitName() == "npc_swamp_boss"  then
		add_soul(killedUnit:GetUnitName())
		local venom =  {"venomancer_venm_death_08","venomancer_venm_death_07","venomancer_venm_death_09","venomancer_venm_death_06","venomancer_venm_death_05"}
		killedUnit:EmitSound(venom[RandomInt(1, #venom)])
		local swamp = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "swamp_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(swamp, point, false)
			swamp:Stop()
		 swamp:RespawnUnit()
		 end)
	end	
	
	if killedUnit:GetUnitName() == "npc_snow_boss"  then
		add_soul(killedUnit:GetUnitName())
		local tiny =  {"tiny_tiny_death_09","tiny_tiny_death_01","tiny_tiny_death_05","tiny_tiny_death_11","tiny_tiny_death_08"}
		killedUnit:EmitSound(tiny[RandomInt(1, #tiny)])
		local snow = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "snow_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(snow, point, false)
			snow:Stop()
		 snow:RespawnUnit()
		 end)
	end	
	
	if killedUnit:GetUnitName() == "npc_boss_location8"  then
		add_soul(killedUnit:GetUnitName())
		local snow = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "last_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(snow, point, false)
			snow:Stop()
		 snow:RespawnUnit()
		 end)
	end	
	
	if killedUnit:GetUnitName() == "npc_mega_boss"  then
	local doom =  {"doom_bringer_doom_death_04","doom_bringer_doom_death_10","doom_bringer_doom_death_11","doom_bringer_doom_death_02","doom_bringer_doom_death_01"}
	killedUnit:EmitSound(doom[RandomInt(1, #doom)])	
	_G.mega_boss_bonus = mega_boss_bonus + 1
	local mega = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "mega_boss_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(mega, point, false)
			mega:Stop()
			mega:RespawnUnit()			
			mega:SetBaseDamageMin(mega:GetBaseDamageMin() * (mega_boss_bonus+1))
			mega:SetBaseDamageMax(mega:GetBaseDamageMax() * (mega_boss_bonus+1))
			mega:SetPhysicalArmorBaseValue(mega:GetPhysicalArmorBaseValue() * (mega_boss_bonus+1))
			mega:SetBaseMagicalResistanceValue(mega:GetBaseMagicalResistanceValue() * (mega_boss_bonus+1))
			mega:SetMaxHealth(mega:GetMaxHealth() * (mega_boss_bonus+1))
			mega:SetBaseMaxHealth(mega:GetBaseMaxHealth() * (mega_boss_bonus+1))
			mega:SetHealth(mega:GetMaxHealth()* (mega_boss_bonus+1))		
			
			local mg_resist = mega:GetBaseMagicalResistanceValue()
			local total_hp = mega:GetMaxHealth()
			local armor = mega:GetPhysicalArmorBaseValue()
			local mindmg = mega:GetBaseDamageMin()
			local maxdmg = mega:GetBaseDamageMax()
			
			if armor >= 10000 then mega:SetPhysicalArmorBaseValue(10000)
			end
			
			if mindmg >= 2000000000 then mega:SetBaseDamageMin(2000000000)
			end
			
			if maxdmg >= 2000000000 then mega:SetBaseDamageMax(2000000000)
			end
			
			if mg_resist >= 99 then mega:SetBaseMagicalResistanceValue(99)
			end
			
			if total_hp >= 2000000000 then
			total_hp = 2000000000
			mega:SetBaseMaxHealth(total_hp)
			mega:SetMaxHealth(total_hp)
			mega:SetHealth(total_hp)
			end   
		end)
	end
	
	if killedUnit:GetUnitName() == "roshan_npc"  then
	local roshan = killedUnit
		 Timers:CreateTimer(diff_wave.respawn, function()
			local ent = Entities:FindByName( nil, "roshan_npc_point")
			local point = ent:GetAbsOrigin()
			FindClearSpaceForUnit(roshan, point, false)
			roshan:Stop()
			roshan:RespawnUnit()			
			roshan:SetBaseDamageMin(roshan:GetBaseDamageMin() * 1.5)
			roshan:SetBaseDamageMax(roshan:GetBaseDamageMax() * 1.5)
			roshan:SetPhysicalArmorBaseValue(roshan:GetPhysicalArmorBaseValue() * 2)
			roshan:SetBaseMagicalResistanceValue(roshan:GetBaseMagicalResistanceValue() * 2)
			roshan:SetMaxHealth(roshan:GetMaxHealth() *2 )
			roshan:SetBaseMaxHealth(roshan:GetBaseMaxHealth() * 2)
			roshan:SetHealth(roshan:GetMaxHealth()* 2)		
			if roshan:GetBaseMagicalResistanceValue() >= 99 then roshan:SetBaseMagicalResistanceValue(99)
			end
		end)
	end	
	
	if killedUnit:GetUnitName() == "raid_boss" or killedUnit:GetUnitName() == "raid_boss3" or killedUnit:GetUnitName() == "raid_boss4" then
		local point = killedUnit:GetAbsOrigin()
		if diff_wave.wavedef == "Easy" then
			return
		end
		if diff_wave.wavedef == "Normal" then
			local Unit = CreateUnitByName("box_1", point + RandomVector( RandomFloat( 150, 150 )), true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		if diff_wave.wavedef == "Hard" then
			local Unit = CreateUnitByName("box_2", point + RandomVector( RandomFloat( 150, 150 )), true, nil, nil, DOTA_TEAM_BADGUYS)
		end	
		if diff_wave.wavedef == "Ultra" then
			local Unit = CreateUnitByName("box_3", point + RandomVector( RandomFloat( 150, 150 )), true, nil, nil, DOTA_TEAM_BADGUYS)
		end	
	end	
	
	if killedUnit:GetUnitName() == "npc_raid_earth" or killedUnit:GetUnitName() == "npc_raid_storm" or killedUnit:GetUnitName() == "npc_raid_fire" then
	_G.raid_boss_2 = raid_boss_2 + 1 
		if _G.raid_boss_2 == 3 then
			 Entities:FindByName( nil, "raid_boss2"):ForceKill(false)
		end
	end
	
	if killedUnit:GetUnitName() == "raid_boss2" then
		local point = Entities:FindByName( nil, "point_center2"):GetAbsOrigin()
		
		if diff_wave.wavedef == "Easy" then
		return
		end
		if diff_wave.wavedef == "Normal" then
			local Unit = CreateUnitByName("box_1", point + RandomVector( RandomFloat( 150, 150 )), true, nil, nil, DOTA_TEAM_BADGUYS)
		end
		if diff_wave.wavedef == "Hard" then
			local Unit = CreateUnitByName("box_2", point + RandomVector( RandomFloat( 150, 150 )), true, nil, nil, DOTA_TEAM_BADGUYS)
		end	
		if diff_wave.wavedef == "Ultra" then
			local Unit = CreateUnitByName("box_3", point + RandomVector( RandomFloat( 150, 150 )), true, nil, nil, DOTA_TEAM_BADGUYS)
		end	
	end	
	--функция в которой может быть ошибка
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	---------------------------------------------------------------------
	--дебаг
	end,
	function(e)
		print("-------------Error-------------")
		print(e)
		print("-------------Error-------------")
	end)  
	--дебаг
	
	--вызов вункции в которой может быть ошибка
	if bResult then
	--print("юнит умер нормально")
	else
	print("ошибка при убийстве юнита")
	end
end

function CAddonAdvExGameMode:FilterExecuteOrder(filterTable)
    local order = filterTable["order_type"]
    local units_table = filterTable["units"]
    local target = filterTable["entindex_target"]
    local target2 = EntIndexToHScript(target)
    local unit
    if units_table and units_table["0"] then
        unit = EntIndexToHScript(units_table["0"])
        if unit then
            if unit.skip then
                unit.skip = false
                return true
            end
        end
    end
    if target ~= nil and target ~= 0 and target2 then
         if order == DOTA_UNIT_ORDER_ATTACK_TARGET  and target2:GetModelName() == "models/heroes/treant_protector/treant_protector.vmdl" then 
            return
         end
    end
	
	if order == DOTA_UNIT_ORDER_SELL_ITEM then
		--print(EntIndexToHScript(filterTable["entindex_ability"]):GetCost())
		local pid = filterTable["issuer_player_id_const"]
		local price = tonumber(EntIndexToHScript(filterTable["entindex_ability"]):GetCost())
		local gold = price / 2
		-- herogold:addGold(pid,gold)
	end
    return true
end