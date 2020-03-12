AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")

util.AddNetworkString("Wasied:GunSeller:OpenFrame")
util.AddNetworkString("Wasied:GunSeller:RemoveMoney")

function ENT:Initialize()

    self:SetModel(WasiedGunSellerConfig.model)
	self:SetHullType(HULL_HUMAN)
	self:SetHullSizeNormal()
	self:SetNPCState(NPC_STATE_SCRIPT)
	self:SetSolid(SOLID_BBOX)
	self:CapabilitiesAdd(CAP_ANIMATEDFACE || CAP_TURN_HEAD)
	self:SetUseType(SIMPLE_USE)
	self:DropToFloor()

	self.NextTime = CurTime() + 1

    local phys = self:GetPhysicsObject()
    if phys:IsValid() then
        phys:Wake()
    end

end

function ENT:SpawnFunction( ply, tr, ClassName )

	if ( !tr.Hit ) then return end

	local SpawnPos = tr.HitPos + tr.HitNormal * 10
	local SpawnAng = ply:EyeAngles()
	SpawnAng.p = 0
	SpawnAng.y = SpawnAng.y + 180

	local ent = ents.Create( ClassName )
	ent:SetPos( SpawnPos )
	ent:SetAngles( SpawnAng )
	ent:Spawn()
	ent:Activate()

	return ent

end

function ENT:AcceptInput(inp, activator, caller)

	if inp == "Use" && activator:IsPlayer() && self.NextTime < CurTime() then
	
		self.NextTime = CurTime() + 2
		local teamNumbers = team.NumPlayers(WasiedGunSellerConfig.GunTeam)

			if teamNumbers == 0 then

				net.Start("Wasied:GunSeller:OpenFrame")
					net.WriteEntity(self)
				net.Send(activator)

			elseif teamNumbers > 0 then

				DarkRP.notify(activator, 0, 6, "Vous n'êtes pas autorisé à utiliser ce PNJ !")
				DarkRP.notify(activator, 0, 7, "Il n'est disponible que si aucun armurier n'est disponible.")
				DarkRP.notify(activator, 0, 8, "Il y a actuellement "..teamNumbers.." armurier(s) en ville.")

			end
		
	end
	
end

net.Receive("Wasied:GunSeller:RemoveMoney", function(len, ply)
	local wepid = net.ReadInt(4)
	local ent = net.ReadEntity()

	if ent:GetClass() != "gun_seller_npc" then return end
	if IsValid(ply) && ply:GetPos():DistToSqr(ent:GetPos()) < 250^2 --[[Juste une sécurité]] then

		local wep = WasiedGunSellerConfig.Weapons[wepid]

		if ply:canAfford(wep.price) then
			
			ply:addMoney(-wep.price)
			DarkRP.notify(ply, 0, 7, "Vous avez été débité de "..wep.price.."€.")

			ply:Give(wep.weapon)
			print("["..WasiedGunSellerConfig.AddonName.."] "..ply:Nick().." vient d'acheter une arme "..wep.weapon.." !")
		
		else

			DarkRP.notify(ply, 0, 9, "Vous n'avez pas assez d'argent pour acheter ceci !")

		end
	
	end

end)