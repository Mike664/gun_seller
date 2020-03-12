WasiedGunSellerConfig = WasiedGunSellerConfig or {}
WasiedGunSellerConfig.Weapons = {}

WasiedGunSellerConfig.GunTeam = TEAM_GUN -- L'ID du métier d'armurier dans ton jobs.lua

WasiedGunSellerConfig.AddonName = "Vendeur d'armes" -- Le nom qui s'affichera en haut de la frame

WasiedGunSellerConfig.NPCText = "Vendeur d'armes" -- Le texte au dessus du NPC
WasiedGunSellerConfig.TextSize = 75 -- La taille du texte au dessus du NPC
WasiedGunSellerConfig.TextPos = -825 -- La position par rapport au pied du NPC
WasiedGunSellerConfig.MinPos = 1000 -- La distance minimale à laquelle le joueur doit se trouver du PNJ pour voir le texte (optimisation)
WasiedGunSellerConfig.model = "models/player/gman_high.mdl" -- Le modèle du PNJ

--[[
Modèle :

WasiedGunSellerConfig.Weapons[NUMBER] = {
    name = "NOM", -- Le nom qui s'affichera dans le menu
    description = "DESCRIPTION", -- La description que tu veux, elle s'affichera sous l'arme, tu peux rajouter "\n" si tu veux allonger
    model = "MODELE" -- Le modèle désiré qui sera affiché dans le menu (aucun changement in-game)
    modelpos = Vector(x, y, z) -- La position de l'arme dans le carré du menu (changer en fonction de la taille des armes)
    weapon = "ARME", -- L'ID de l'arme, dans le menu props, armes, clic droit et copier l'identifiant
    price = PRIX, -- Le prix de l'arme, un chiffre sans virgules
    fov = 10 -- Le FOV pour le modèle de l'arme (en bref, le zoom)
}

]]--

WasiedGunSellerConfig.Weapons[1] = {
    name = "Lockpick",
    description = "Cette arme est très utile pour ouvrir des portes.",
    model = "models/weapons/w_crowbar.mdl",
    modelpos = Vector(3, 0, 0),
    weapon = "lockpick",
    price = 250
}

WasiedGunSellerConfig.Weapons[2] = {
    name = "M29 Satan",
    description = "Utile mais illégal sans license.",
    model = "models/weapons/tfa_w_m29_satan.mdl",
    modelpos = Vector(3, 0, 0),
    weapon = "tfa_m29satan",
    price = 5000
}

WasiedGunSellerConfig.Weapons[3] = {
    name = "M92 Beretta",
    description = "Utile mais illégal sans license.",
    model = "models/weapons/tfa_w_beretta_m92.mdl",
    modelpos = Vector(3, 0, 0),
    weapon = "tfa_m92beretta",
    price = 4000
}

WasiedGunSellerConfig.Weapons[4] = {
    name = "Taurus ACOG",
    description = "Utile mais illégal sans license.",
    model = "models/weapons/tfa_w_raging_bull_scoped.mdl",
    modelpos = Vector(3, 0, 0),
    weapon = "tfa_scoped_taurus",
    price = 5500
}

WasiedGunSellerConfig.Weapons[5] = {
    name = "UZI",
    description = "Utile mais illégal sans license.",
    model = "models/weapons/tfa_wuzi_imi.mdl",
    modelpos = Vector(3, 0, 0),
    weapon = "tfa_uzi",
    price = 9000
}

WasiedGunSellerConfig.Weapons[6] = {
    name = "Colt 1911",
    description = "Utile mais illégal sans license.",
    model = "models/weapons/tfa_w__dmgf_co1911.mdl",
    modelpos = Vector(3, 0, 0),
    weapon = "tfa_colt1911",
    price = 2500
}

-- Fin de la configuration !

ENT.Type = "ai"
ENT.Base = "base_ai"

ENT.PrintName = "Gun Seller"
ENT.Category = "Wasied | Gun Seller"
ENT.Author = "Wasied"
ENT.Contact = "Discord : Wasied#3753"
ENT.Purpose = "Vendre des armes lorsqu'aucun armurier n'est présent"
ENT.Instructions = "Utilisez-le et achetez vos armes"

ENT.Spawnable = true
