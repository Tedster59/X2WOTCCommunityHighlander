//---------------------------------------------------------------------------------------
 //  FILE:    UIDebugInfo.uc
 //  AUTHOR:  Brit Steiner --  3/2015
 //  PURPOSE: Debug container for tactical game 
 //---------------------------------------------------------------------------------------
 //  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
 //---------------------------------------------------------------------------------------

class UIHitlog extends UIScreen;

var public UITextContainer DebugTextField;
var public UIButton ClearButton; 
var public UIButton HideButton;
var privatewrite string DebugText; 
var private array<string> DebugTextArray;

const MAX_DEBUG_LINES = 25;

//----------------------------------------------------------------------------
// MEMBERS

simulated function InitScreen(XComPlayerController InitController, UIMovie InitMovie, optional name InitName)
{
	super.InitScreen(InitController, InitMovie, InitName);

	DebugTextField = Spawn(class'UITextContainer', self);
	DebugTextField.InitTextContainer('', DebugText, 5, 25, 400, 230, true);
	DebugTextField.AnchorTopRight().SetX(-DebugTextField.Width); // Move in to the visual frame area. 
	DebugTextField.SetY(400);

	ClearButton = Spawn(class'UIButton', self).InitButton('', "Clear Log", OnClickedClearText);
	ClearButton.AnchorTopRight().SetX(-DebugTextField.Width); // Move in to the visual frame area. 
	ClearButton.SetY(400);

	HideButton = Spawn(Class'UIButton',self).InitButton('', "Show/Hide Hitlog", OnClickedToggleView);

	HideButton.AnchorTopRight().SetX(-DebugTextField.Width/2); // Move in to the visual frame area. 
	HideButton.SetY(400);

	Refresh(); 
}

private function Refresh()
{
	local int i;

	while (DebugTextArray.Length > MAX_DEBUG_LINES)
	{
		DebugTextArray.Remove(0, 1);
	}
	DebugText = "";
	for (i = DebugTextArray.Length - 1; i >= 0; --i)
	{
		DebugText $= "\n" $ DebugTextArray[i];
	}

	DebugTextField.SetHTMLText(DebugText);

	if( DebugText == "" )
	{
		DebugTextField.Hide();
		ClearButton.Hide();
	}
	else
	{
		DebugTextField.Show();
		ClearButton.Show();
	}
}

public function AddText(string NewInfo, optional bool bClearPrevious = false)
{
	local bool bIsHidden;
	if( bClearPrevious )
		ClearText();

	bIsHidden = !DebugTextField.bIsVisible;

	`Log("bIsHidden:" @bIsHidden,,'TedLog');

	DebugTextArray.AddItem(NewInfo);
	
	
	Refresh();

	if(bIsHidden)
	{
		DebugTextField.Hide();
		ClearButton.Hide();
	}
}

public function ClearText()
{
	DebugTextArray.Length = 0;	
	Refresh();
}


function OnClickedClearText(UIButton Button)
{
	ClearText();
}

function OnClickedToggleView(UIButton Button)
{

	DebugTextField.ToggleVisible();
	ClearButton.ToggleVisible();
}

//Defaults: ------------------------------------------------------------------------------
defaultproperties
{
	bAlwaysTick = true;
	InputState = eInputState_None;
	bShowDuringCinematic = false;
	DebugText = ""; 
}