# Used by updateVersion.ps1

$version_block = @'
// AUTO-CODEGEN: Version-Info
defaultproperties
{
	MajorVersion = 1;
	MinorVersion = 26;
	PatchVersion = 2;
	Commit = "%COMMIT%";
}
'@
