include("shared.lua")

/*
FONT LIST
*/
surface.CreateFont( "WasiedNPCTitle", {font="Righteous",extended=false,size=WasiedGunSellerConfig.TextSize,weight=1000})
surface.CreateFont( "WasiedFrameTitle", {font="Pacifico",extended=true,size=100,weight=5500})
surface.CreateFont( "WasiedCloseButton", {font="Pacifico",extended=true,size=60,weight=5500})
surface.CreateFont( "WasiedWeaponTitle", {font="Pacifico",extended=true,size=20,weight=750})
surface.CreateFont( "WasiedWeaponDescription", {font="Pacifico",extended=false,size=35,weight=500})
surface.CreateFont( "WasiedWeaponPrice", {font="Righteous",extended=true,size=30,weight=1500})
surface.CreateFont( "WasiedWeaponPrice2", {font="Righteous",extended=true,size=25,weight=1000})

/*
CODE
*/
function ENT:Draw()
    self:DrawModel()

    local pos = self:GetPos()
    local ang = self:GetAngles()

    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), -90)
    cam.Start3D2D(pos, ang, 0.1)
        if LocalPlayer():GetPos():DistToSqr(self:GetPos()) < WasiedGunSellerConfig.MinPos^2 then
            draw.SimpleText(WasiedGunSellerConfig.NPCText, "WasiedNPCTitle", 0, WasiedGunSellerConfig.TextPos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
        end
    cam.End3D2D()

    ang:RotateAroundAxis(ang:Right(), 180)
    cam.Start3D2D(pos, ang, 0.1)
        if LocalPlayer():GetPos():DistToSqr(self:GetPos()) < WasiedGunSellerConfig.MinPos^2 then
            draw.SimpleText(WasiedGunSellerConfig.NPCText, "WasiedNPCTitle", 0, WasiedGunSellerConfig.TextPos, Color( 255, 255, 255, 255 ), TEXT_ALIGN_CENTER)
        end
    cam.End3D2D()

end

net.Receive("Wasied:GunSeller:OpenFrame", function()

    local ent = net.ReadEntity()

    local basicframe = vgui.Create("DPanel")
    basicframe:SetSize(1000,600)
    basicframe:Center()
    basicframe:MakePopup()
    function basicframe:Paint(w,h)
        Derma_DrawBackgroundBlur(self, self.startTime)
    
        draw.RoundedBox(5, 0, 0, w, h, Color(10,10,10,180))

        draw.SimpleText(WasiedGunSellerConfig.AddonName, "WasiedFrameTitle", w/2, 0, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP)
    end

    local closebutton = vgui.Create("DButton", basicframe)
    closebutton:SetSize(basicframe:GetWide()-40, 50)
    closebutton:SetPos(20, (basicframe:GetTall()-closebutton:GetTall())-20)
    closebutton:SetText("")
    closebutton.OnCursorEntered = function(self)
        self.hover = true
    end
    closebutton.OnCursorExited = function(self)
        self.hover = false
    end
    function closebutton:Paint(w,h)
        if !self.hover then
            draw.RoundedBox(5, 0, 0, w, h, Color(30,30,30,210))
        else
            draw.RoundedBox(5, 0, 0, w, h, Color(50,30,30,210))
        end
        draw.SimpleText("Fermer", "WasiedCloseButton", w/2, h/2, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end
    closebutton.DoClick = function()
        basicframe:SlideUp(0.5)
    end

    local scroll = vgui.Create("DScrollPanel", basicframe)
    scroll:SetSize(basicframe:GetWide()-80, 400)
    scroll:SetPos(40, 100)

    local sbar = scroll:GetVBar()
    function sbar:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(20,20,20,190))
    end
    function sbar.btnGrip:Paint(w, h)
        draw.RoundedBox(0, 0, 0, w, h, Color(0,0,0))
    end
    function sbar.btnDown:Paint(w, h) end
    function sbar.btnUp:Paint(w, h) end

    -- Weapons
    local weplist = vgui.Create("DListLayout",scroll)
    weplist:Dock(FILL)
    weplist:Clear()
    for k,v in pairs(WasiedGunSellerConfig.Weapons) do
        
        local weppanel = vgui.Create("DButton", weplist)
        weppanel:SetSize(weplist:GetWide(), 100)
		weppanel:SetPos(0,0)
        weppanel:SetText("")
        weppanel.color = Color(20, 20, 20, 200)
        function weppanel:OnCursorEntered()
            self.color = Color(40, 20, 20, 200)
        end
        function weppanel:OnCursorExited()
            self.color = Color(20, 20, 20, 200)
        end
        function weppanel:Paint(w,h)
            surface.SetDrawColor(self.color)
            surface.DrawRect(0, 0, w, h)

            surface.SetDrawColor(Color(255, 255, 255))           
            surface.DrawOutlinedRect(0, 0, w, h)

            -- Model background
            surface.SetDrawColor(Color(0, 0, 0, 50))
            surface.DrawRect(1, 1, 128, h-2)

            draw.SimpleText(v.name.." - "..v.price.."€", "WasiedCloseButton", 150, h/2-5, Color(255,255,255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
            draw.SimpleText(v.description, "WasiedWeaponDescription", w-10, h/2, Color(255,255,255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
        end
        function weppanel:DoClick()
            sound.Play("buttons/button24.wav", LocalPlayer():GetPos())

            basicframe:SlideUp(0.5)

            net.Start("Wasied:GunSeller:RemoveMoney")
                net.WriteInt(k, 4)
                net.WriteEntity(ent)
            net.SendToServer()
        end

        local modelpanel = vgui.Create("DModelPanel", weppanel)
        modelpanel:SetSize(150, weppanel:GetTall())
        modelpanel:SetPos(0, 0)
        modelpanel:SetModel(v.model)
        modelpanel:SetLookAt(v.modelpos)
        modelpanel:SetFOV(35)
        function modelpanel:LayoutEntity(entity) return end
    
    end

end)