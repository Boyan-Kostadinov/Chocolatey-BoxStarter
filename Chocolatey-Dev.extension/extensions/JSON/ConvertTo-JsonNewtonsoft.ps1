function ConvertTo-JsonNewtonsoft
{
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][object] $obj
    )

    if (!$global:asm) {
        $global:asm = [Reflection.Assembly]::LoadFile($global:newtonsoftJsonDll)
    }

    return [Newtonsoft.Json.JsonConvert]::SerializeObject($obj, [Newtonsoft.Json.Formatting]::Indented)
}