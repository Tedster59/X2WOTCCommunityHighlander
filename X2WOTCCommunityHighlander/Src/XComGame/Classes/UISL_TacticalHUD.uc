// This is an Unreal Script

Class UISL_TacticalHUD extends UIScreenListener;


event OnInit(UIScreen Screen)
{
	local UIHitLog HitLogScreen;

	`Log("Added hitlog",,'TedLog');
	HitLogScreen = Screen.Spawn(class'UIHitLog', Screen);
	`SCREENSTACK.Push(HitLogScreen);
}

defaultproperties
{
       ScreenClass = UITacticalHUD;
}
