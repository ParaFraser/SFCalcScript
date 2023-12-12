ow_coords := ["2052,884","-1692,1268","-204,-1692","2548,4116","2660,-4940","-3020,-4876","-2316,4324","5684,-172","-4972,148"]
ne_coords := ["256,110","-212,158","-26,-212","318,514","332,-618","-378,-610","-290,540","710,-22","-622,18"]

#If WinActive("Minecraft") && (WinActive("ahk_exe javaw.exe") || WinActive("ahk_exe java.exe"))
{
	Gui, +AlwaysOnTop -SysMenu +Owner
	Gui, Add, Text,, Waiting for F3+C...
	Gui, Show, x1590 y0 w330 h130 NoActivate, Calculator
	ClipWait , , 0
	ClipSaved := clipboard
	arr := StrSplit(ClipSaved, " ")
	xLen := InStr(arr.7, ".") - 1
	yLen := InStr(arr.8, ".") - 1
	zLen := InStr(arr.9, ".") - 1
	x := SubStr(arr.7, 1, xLen)
	y := SubStr(arr.8, 1, yLen)
	z := SubStr(arr.9, 1, zLen)

	if (arr.3 = "minecraft:overworld")
	{
		OWdistances := []
		OWangles := []
		i = 1
		while i <= ow_coords.MaxIndex()
		{
			xDist := SubStr(ow_coords[i], 1, InStr(ow_coords[i], ",") - 1) - x
			zDist := SubStr(ow_coords[i], InStr(ow_coords[i], ",") + 1, StrLen(ow_coords[i]) - InStr(ow_coords[i], ",")) - z
			dist := Round(Sqrt(xDist*xDist + zDist*zDist))

			if (xDist > 0) && (zDist > 0)
			{
				angle := Round(0 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist < 0) && (zDist > 0)
			{
				angle := Round(0 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist < 0) && (zDist < 0)
			{
				angle := Round(180 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist > 0) && (zDist < 0)
			{
				angle := Round(-180 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist = 0) && (zDist < 0)
			{
				angle := 180.0
			}
			else if (xDist = 0) && (zDist > 0)
			{
				angle := 0.0
			}
			else if (xDist < 0) && (zDist = 0)
			{
				angle := 90.0
			}
			else if (xDist > 0) && (zDist = 0)
			{
				angle := -90.0
			}

			OWdistances.Push(dist)
			OWangles.Push(angle)

			i += 1
		}
		
		strongholdID := 0
		
		n = 1
		while n <= OWdistances.MaxIndex()
		{
			if OWdistances[n] = Min(OWdistances*)
			{
				strongholdID := n
			}

			n += 1
		}
		
		ne_coord := ne_coords[strongholdID]
		ow_coord := ow_coords[strongholdID]
		ow_dist := OWdistances[strongholdID]
		ow_angle := OWangles[strongholdID]
		
		ne_coords.RemoveAt(strongholdID)
		ow_coords.RemoveAt(strongholdID)
		OWdistances.RemoveAt(strongholdID)
		OWangles.RemoveAt(strongholdID)

		strongholdID_two := 0
		
		n = 1
		while n <= OWdistances.MaxIndex()
		{
			if OWdistances[n] = Min(OWdistances*)
			{
				strongholdID_two := n
			}

			n += 1
		}
		
		ne_coord_two := ne_coords[strongholdID_two]
		ow_coord_two := ow_coords[strongholdID_two]
		ow_dist_two := OWdistances[strongholdID_two]
		ow_angle_two := OWangles[strongholdID_two]
		
		if (ow_dist > 200)
		{
			colour := "Silver"
		}
		else if (200 >= ow_dist) && (ow_dist > 100)
		{
			colour := "Maroon"
		}
		else if (100 >= ow_dist) && (ow_dist > 50)
		{
			colour := "F06D60"
		}
		else if (50 >= ow_dist) && (ow_dist > 15)
		{
			colour := "Yellow"
		}
		else if (15 >= ow_dist)
		{
			colour := "Lime"
		}

		if (ow_dist_two > 200)
		{
			colour_two := "Silver"
		}
		else if (200 >= ow_dist_two) && (ow_dist_two > 100)
		{
			colour_two := "Maroon"
		}
		else if (100 >= ow_dist_two) && (ow_dist_two > 50)
		{
			colour_two := "F06D60"
		}
		else if (50 >= ow_dist_two) && (ow_dist_two > 15)
		{
			colour_two := "Yellow"
		}
		else if (15 >= ow_dist_two)
		{
			colour_two := "Lime"
		}

		Gui, Destroy
		Gui, +AlwaysOnTop -SysMenu +Owner
		Gui, Color, 008000
		Gui, Add, Text, cWhite, Closest strongholds are at
		Gui, font, bold
		Gui, Add, Text, % "c" colour, NE: (%ne_coord%)`nOW: (%ow_coord%), %ow_dist% blocks away at %ow_angle% degrees
		Gui, font
		Gui, Add, Text, % "c" colour_two, NE: (%ne_coord_two%)`nOW: (%ow_coord_two%), %ow_dist_two% blocks away at %ow_angle_two% degrees
		Gui, Add, Button, Default, Reset
		Gui, Show, x1590 y0 w330 h130 NoActivate, Calculator
	}

	if (arr.3 = "minecraft:the_nether")
	{
		NEdistances := []
		NEangles := []
		i = 1
		while i <= ne_coords.MaxIndex()
		{
			xDist := SubStr(ne_coords[i], 1, InStr(ne_coords[i], ",") - 1) - x
			zDist := SubStr(ne_coords[i], InStr(ne_coords[i], ",") + 1, StrLen(ne_coords[i]) - InStr(ne_coords[i], ",")) - z
			dist := Round(Sqrt(xDist*xDist + zDist*zDist))

			if (xDist > 0) && (zDist > 0)
			{
				angle := Round(0 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist < 0) && (zDist > 0)
			{
				angle := Round(0 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist < 0) && (zDist < 0)
			{
				angle := Round(180 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist > 0) && (zDist < 0)
			{
				angle := Round(-180 - ATan(xDist/zDist)*180/(4*ATan(1)), 1)
			}
			else if (xDist = 0) && (zDist < 0)
			{
				angle := 180.0
			}
			else if (xDist = 0) && (zDist > 0)
			{
				angle := 0.0
			}
			else if (xDist < 0) && (zDist = 0)
			{
				angle := 90.0
			}
			else if (xDist > 0) && (zDist = 0)
			{
				angle := -90.0
			}

			NEdistances.Push(dist)
			NEangles.Push(angle)

			i += 1
		}
		
		strongholdID := 0
		
		n = 1
		while n <= NEdistances.MaxIndex()
		{
			if NEdistances[n] = Min(NEdistances*)
			{
				strongholdID := n
			}

			n += 1
		}
		
		ne_coord := ne_coords[strongholdID]
		ne_dist := NEdistances[strongholdID]
		ne_angle := NEangles[strongholdID]
		ow_coord := ow_coords[strongholdID]

		ne_coords.RemoveAt(strongholdID)
		NEdistances.RemoveAt(strongholdID)
		NEangles.RemoveAt(strongholdID)
		ow_coords.RemoveAt(strongholdID)

		strongholdID_two := 0
		
		n = 1
		while n <= NEdistances.MaxIndex()
		{
			if NEdistances[n] = Min(NEdistances*)
			{
				strongholdID_two := n
			}

			n += 1
		}
		
		ne_coord_two := ne_coords[strongholdID_two]
		ne_dist_two := NEdistances[strongholdID_two]
		ne_angle_two := NEangles[strongholdID_two]
		ow_coord_two := ow_coords[strongholdID_two]

		if (ne_dist > 200)
		{
			colour := "Silver"
		}
		else if (200 >= ne_dist) && (ne_dist > 100)
		{
			colour := "Maroon"
		}
		else if (100 >= ne_dist) && (ne_dist > 50)
		{
			colour := "F06D60"
		}
		else if (50 >= ne_dist) && (ne_dist > 15)
		{
			colour := "Yellow"
		}
		else if (15 >= ne_dist)
		{
			colour := "Lime"
		}

		if (ne_dist_two > 200)
		{
			colour_two := "Silver"
		}
		else if (200 >= ne_dist_two) && (ne_dist_two > 100)
		{
			colour_two := "Maroon"
		}
		else if (100 >= ne_dist_two) && (ne_dist_two > 50)
		{
			colour_two := "F06D60"
		}
		else if (50 >= ne_dist_two) && (ne_dist_two > 15)
		{
			colour_two := "Yellow"
		}
		else if (15 >= ne_dist_two)
		{
			colour_two := "Lime"
		}

		Gui, Destroy
		Gui, +AlwaysOnTop -SysMenu +Owner
		Gui, Color, DE1F0C
		Gui, Add, Text, cWhite, Closest strongholds are at
		Gui, font, bold
		Gui, Add, Text, % "c" colour, NE: (%ne_coord%), %ne_dist% blocks away at %ne_angle% degrees`nOW: (%ow_coord%)
		Gui, font
		Gui, Add, Text, % "c" colour_two, NE: (%ne_coord_two%), %ne_dist_two% blocks away at %ne_angle_two% degrees`nOW: (%ow_coord_two%)
		Gui, Add, Button, Default, Reset
		Gui, Show, x1590 y0 w330 h130 NoActivate, Calculator
	}

	clipboard := ""
	ClipWait , , 0
	reload
}

ButtonReset:
Gui, Destroy
Gui, +AlwaysOnTop -SysMenu +Owner
Gui, Add, Text,, Waiting for F3+C...
Gui, Show, x1590 y0 w330 h130 NoActivate, Calculator
return