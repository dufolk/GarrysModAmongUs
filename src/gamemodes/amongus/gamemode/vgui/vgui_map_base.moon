MAT_ASSETS = {
	close: Material "au/gui/closebutton.png", "smooth"
}

TRANSLATE = GM.Lang.GetEntry

surface.CreateFont "NMW AU Map Labels", {
	font: "Roboto"
	size: 0.025 * math.min ScrW!, ScrH!
	weight: 550
}

COLOR_OUTLINE = Color 0, 0, 0, 160
COLOR_WHITE   = Color 255, 255, 255

map = {
	Init: =>
		@__baseMatWidth = 0
		@__baseMatHeight = 0
		@__color = Color 255, 255, 255
		@__position = Vector 0, 0, 0
		@__scale = 1
		@__labels = {}
		@__overlayMatWidth = 1024
		@__overlayMatHeight = 1024
		@__resolution = 1

		@SetZPos 30000
		@SetSize ScrW!, ScrH!

		@__innerPanel = with @Add "Panel"
			size = 0.8 * math.min ScrH!, ScrW!
			\SetSize size, size
			\Center!

			.Paint = (_, w, h) ->
				shouldFilter = @__baseMat or @__overlayMat

				if shouldFilter
					render.PushFilterMag TEXFILTER.ANISOTROPIC
					render.PushFilterMin TEXFILTER.ANISOTROPIC

				if @__baseMat
					surface.SetAlphaMultiplier 0.85
					surface.SetDrawColor 255, 255, 255
					surface.SetMaterial @__baseMat
					surface.DrawTexturedRect 0, 0, w, h

				if @__overlayMat
					surface.SetAlphaMultiplier 0.925 + 0.05 * math.sin SysTime! * 2.5
					surface.SetDrawColor @__color
					surface.SetMaterial @__overlayMat
					surface.DrawTexturedRect 0, 0, w, h

				if shouldFilter
					render.PopFilterMag!
					render.PopFilterMin!

				surface.SetAlphaMultiplier 1

			.PaintOver = (_, w, h) ->
				surface.SetAlphaMultiplier 0.95
				for label in *@__labels
					x = label.Position.x * w
					y = label.Position.y * h

					draw.SimpleTextOutlined tostring(TRANSLATE(label.Text)), "NMW AU Map Labels", x, y, COLOR_WHITE,
						TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, COLOR_OUTLINE

				surface.SetAlphaMultiplier 1

		@__closeButton = with @Add "DImageButton"
			\SetText ""
			\SetMaterial MAT_ASSETS.close
			\SetSize ScrH! * 0.09, ScrH! * 0.09

			x, y = @__innerPanel\GetPos!
			\SetPos x - \GetWide! * 1.1, y

			.DoClick = ->
				@Close!

	GetInnerPanel: => @__innerPanel
	GetCloseButton: => @__closeButton

	SetColor: (value) => @__color = value
	GetColor: => @__color

	SetBackgroundMaterial: (value) =>
		@__baseMatWidth, @__baseMatHeight = if texture = value\GetTexture "$basetexture"
			texture\GetMappingWidth!, texture\GetMappingHeight!
		else
			0, 0

		w, h = GAMEMODE.Render.FitMaterial value, 0.8 * ScrW!, 0.8 * ScrH!
		with @__innerPanel
			\SetSize w, h
			\Center!

			x, y = @__innerPanel\GetPos!
			with @__closeButton
				\SetPos x - \GetWide! * 1.1, y

		@__baseMat = value

	GetBackgroundMaterial: => @__baseMat
	GetBackgroundMaterialSize: => @__baseMatWidth, @__baseMatHeight

	SetOverlayMaterial: (value) => @__overlayMat = value
	GetOverlayMaterial: => @__overlayMat

	SetPosition: (value) => @__position = value
	GetPosition: => @__position

	SetScale: (value) => @__scale = value
	GetScale: => @__scale

	SetResolution: (value) => @__resolution = value
	GetResolution: => @__resolution

	SetLabels: (value) => @__labels = value
	GetLabels: => @__labels

	SetupFromManifest: (manifest) =>
		if manifest.Map
			with map = manifest.Map.UI or manifest.Map
				if .OverlayMaterial
					@SetOverlayMaterial .OverlayMaterial

				if .BackgroundMaterial
					@SetBackgroundMaterial .BackgroundMaterial

				if .Scale
					@SetScale .Scale

				if .Position
					@SetPosition .Position

				if .Labels
					@SetLabels .Labels

				if .Resolution
					@SetResolution .Resolution

	Paint: =>

}

vgui.Register "AmongUsMapBase", map, "AmongUsVGUIBase"
