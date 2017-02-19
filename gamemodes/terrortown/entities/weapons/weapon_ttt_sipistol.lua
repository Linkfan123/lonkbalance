AddCSLuaFile()

SWEP.HoldType              = "pistol"

if CLIENT then
   SWEP.PrintName          = "sipistol_name"
   SWEP.Slot               = 6

   SWEP.ViewModelFlip      = false
   SWEP.ViewModelFOV       = 54

   SWEP.EquipMenuData = {
      type = "item_weapon",
      desc = "sipistol_desc"
   };

   SWEP.Icon               = "vgui/ttt/icon_silenced"
   SWEP.IconLetter         = "a"
end

SWEP.Base                  = "weapon_tttbase"

SWEP.Primary.Recoil        = 1.2
SWEP.Primary.Damage        = 40
SWEP.Primary.Delay         = 0.38
SWEP.Primary.Cone          = 0
SWEP.Primary.ClipSize      = 10
SWEP.Primary.Automatic     = true
SWEP.Primary.DefaultClip   = 10
SWEP.Primary.ClipMax       = 30
SWEP.Primary.Ammo          = "Pistol"
SWEP.Primary.Sound         = Sound( "Weapon_USP.SilencedShot" )
SWEP.Primary.SoundLevel    = 50

SWEP.Kind                  = WEAPON_EQUIP
SWEP.CanBuy                = {ROLE_TRAITOR} -- only traitors can buy
SWEP.WeaponID              = AMMO_SIPISTOL

SWEP.AmmoEnt               = "item_ammo_pistol_ttt"
SWEP.IsSilent              = true

SWEP.UseHands              = true
SWEP.ViewModel             = "models/weapons/cstrike/c_pist_usp.mdl"
SWEP.WorldModel            = "models/weapons/w_pist_usp_silencer.mdl"

SWEP.IronSightsPos         = Vector( -5.91, -4, 2.84 )
SWEP.IronSightsAng         = Vector(-0.5, 0, 0)

SWEP.PrimaryAnim           = ACT_VM_PRIMARYATTACK_SILENCED
SWEP.ReloadAnim            = ACT_VM_RELOAD_SILENCED

function SWEP:Deploy()
   self:SendWeaponAnim(ACT_VM_DRAW_SILENCED)
   return true
end

-- The silenced pistol's headshot damage multiplier is based on distance. The further it
-- is, the more damage it does. This gives players an extra bonus for engaging
-- at long range. It isn't much, but it's something.
function SWEP:GetHeadshotMultiplier(victim, dmginfo)
   local att = dmginfo:GetAttacker()
   if not IsValid(att) then return 3 end

   local dist = victim:GetPos():Distance(att:GetPos())
   local d = math.max(0, dist - 140)

   -- grow from 1 to 2 slowly as distance increases
   return 1 + math.max(0, (0 + 0.002 * (d ^ 1.5)))
end

-- We were bought as special equipment, and we have an extra to give
function SWEP:WasBought(buyer)
   if IsValid(buyer) then -- probably already self.Owner
      buyer:GiveAmmo( 15, "Pistol" )
   end
end
