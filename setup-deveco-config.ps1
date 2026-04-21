param(
  [string]$DevEco = "/Applications/DevEco-Studio.app",
  [string]$PreviewPage = ""
)

$ErrorActionPreference = "Stop"
$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

if ($IsWindows) {
  if ($DevEco -eq "/Applications/DevEco-Studio.app") {
    $DevEco = "D:\Program Files\Huawei\DevEco Studio"
  }
  $SdkRoot = Join-Path $DevEco "sdk\default"
} else {
  $SdkRoot = Join-Path $DevEco "Contents/sdk/default"
}

$SdkPkg = Join-Path $SdkRoot "sdk-pkg.json"
if (!(Test-Path $DevEco)) { throw "DevEco Studio not found: $DevEco" }
if (!(Test-Path $SdkPkg)) { throw "SDK metadata not found: $SdkPkg" }

$SdkData = Get-Content $SdkPkg -Raw | ConvertFrom-Json
$VersionPath = $SdkData.data.path
if (!$VersionPath) { throw "Unable to read SDK version path from $SdkPkg" }

function Get-AppLabel([string]$AppRoot) {
  $config = Get-Content (Join-Path $AppRoot "app.json") -Raw | ConvertFrom-Json
  $name = $config.app -replace "^app-", ""
  return $name.Substring(0, 1).ToUpper() + $name.Substring(1)
}

function New-SdkShim([string]$AppRoot) {
  $shim = Join-Path $AppRoot ".deveco-sdk-shim"
  New-Item -ItemType Directory -Force -Path $shim | Out-Null
  Copy-Item $SdkPkg (Join-Path $shim "sdk-pkg.json") -Force
  $link = Join-Path $shim $VersionPath
  if (Test-Path $link) { Remove-Item $link -Force -Recurse }
  if ($IsWindows) {
    New-Item -ItemType Junction -Path $link -Target $SdkRoot | Out-Null
  } else {
    New-Item -ItemType SymbolicLink -Path $link -Target $SdkRoot | Out-Null
  }
}

function New-RunConfiguration([string]$AppDir, [string]$Label) {
  $dir = Join-Path $Root ".idea/runConfigurations"
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $file = Join-Path $dir "${Label}_Entry.xml"
  @"
<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="${Label}-Entry" type="HvigorRunConfiguration" factoryName="HvigorRunConfiguration">
    <option name="applicationParameters" value="assembleApp -p product=default -p buildMode=debug" />
    <option name="nodeInterpreter" value="`$APPLICATION_HOME_DIR`$/tools/node/bin" />
    <option name="scriptFile" value="`$APPLICATION_HOME_DIR`$/tools/hvigor/bin/hvigorw.js" />
    <option name="workingDir" value="`$PROJECT_DIR`$/${AppDir}" />
    <envs>
      <env name="DEVECO_SDK_HOME" value="`$PROJECT_DIR`$/${AppDir}/.deveco-sdk-shim" />
      <env name="OHOS_BASE_SDK_HOME" value="`$PROJECT_DIR`$/${AppDir}/.deveco-sdk-shim/${VersionPath}/openharmony" />
    </envs>
    <method v="2" />
  </configuration>
</component>
"@ | Set-Content -Path $file -Encoding UTF8
}

function New-PreviewerConfig([string]$AppRoot, [string]$PageName) {
  $previewer = Join-Path $AppRoot ".idea/previewer"
  $phone = Join-Path $previewer "phone"
  New-Item -ItemType Directory -Force -Path $phone | Out-Null

  @'
{
 "1.0.0": {
  "LastPreviewDevice": {}
 },
 "1.0.1": {
  "profileList": [
   {"id":"Foldable","deviceType":"phone","width":2224,"height":2496,"foldable":true,"foldWidth":1080,"foldHeight":2504,"shape":"rect","dpi":520,"orientation":"portrait","language":"zh_CN","colorMode":"light"},
   {"id":"Phone","deviceType":"phone","foldable":false,"width":1080,"height":2340,"foldWidth":0,"foldHeight":0,"shape":"rect","dpi":480,"orientation":"portrait","colorMode":"light","language":"zh_CN"}
  ],
  "runningProfileList": ["Phone","Foldable"],
  "availableProfileList": []
 },
 "enableFileOperation": false
}
'@ | Set-Content -Path (Join-Path $previewer "previewConfigV2.json") -Encoding UTF8

  @'
{
 "setting": {
  "1.0.1": {
   "Language": {"args": {"Language": "zh_CN"}},
   "AvoidArea": {
    "args": {
     "topRect": {"posX":0,"posY":0,"width":1080,"height":117},
     "leftRect": {"posX":0,"posY":117,"width":0,"height":0},
     "rightRect": {"posX":1080,"posY":117,"width":0,"height":0},
     "bottomRect": {"posX":0,"posY":2256,"width":1080,"height":84}
    }
   }
  }
 },
 "frontend": {
  "1.0.0": {
   "Resolution": {"args": {"Resolution": "360*780"}},
   "DeviceType": {"args": {"DeviceType": "phone"}}
  }
 }
}
'@ | Set-Content -Path (Join-Path $phone "phoneSettingConfig_Phone.json") -Encoding UTF8

  $entry = Join-Path $AppRoot "entry"
  $preview = Join-Path $entry ".preview"
  $config = Join-Path $preview "config"
  New-Item -ItemType Directory -Force -Path $config | Out-Null

  $pagePath = Join-Path $entry "src/main/ets/pages/$PageName.ets"
  $resources = Join-Path $entry "src/main/resources"
  $mainPages = Join-Path $resources "base/profile/main_pages.json"
  $pages = @()
  if (Test-Path $mainPages) {
    $pages = (Get-Content $mainPages -Raw | ConvertFrom-Json).src
  }

  $buildConfig = [ordered]@{
    deviceType = "phone"
    buildMode = "debug"
    note = "false"
    logLevel = "3"
    isPreview = "true"
    port = "29900"
    checkEntry = "true"
    localPropertiesPath = (Join-Path $AppRoot "local.properties")
    previewPagePath = $pagePath
    hapMode = "false"
    img2bin = "true"
    projectProfilePath = (Join-Path $AppRoot "build-profile.json5")
    watchMode = "true"
    aceModuleRoot = (Join-Path $entry "src/main/ets")
    stageRouterConfig = [ordered]@{
      paths = @(
        (Join-Path $preview "default/intermediates/res/default/module.json"),
        (Join-Path $preview "default/intermediates/res/default/resources/base/profile/main_pages.json")
      )
      contents = @(
        '{"module":{"pages":"$profile:main_pages","name":"entry"}}',
        (@{ src = $pages } | ConvertTo-Json -Compress)
      )
    }
  }
  $buildConfig | ConvertTo-Json -Depth 10 -Compress | Set-Content -Path (Join-Path $config "buildConfig.json") -Encoding UTF8

  $previewParam = [ordered]@{
    APP_RESOURCES = (Join-Path $AppRoot "AppScope/resources")
    MODULE_RESOURCES = (@{ $resources = "module_compiled" } | ConvertTo-Json -Compress)
    HAR_RESOURCES = "{}"
    PREVIEW_GENERATE_SOURCE_DIR = (Join-Path $preview "default/generated/r/default")
    PREVIEW_COMPILE_MODULE_NAMES = "entry"
  }
  $previewParam | ConvertTo-Json -Compress | Set-Content -Path (Join-Path $preview "PreviewBuildParam.json") -Encoding UTF8
}

Write-Host "[INFO] DevEco Studio: $DevEco"
Write-Host "[INFO] SDK version path: $VersionPath"

Get-ChildItem $Root -Directory -Filter "app-*" | ForEach-Object {
  $appRoot = $_.FullName
  if (!(Test-Path (Join-Path $appRoot "app.json"))) { return }
  $appDir = $_.Name
  $label = Get-AppLabel $appRoot
  $page = if ($PreviewPage) { $PreviewPage } elseif ($appDir -eq "app-album") { "MainPage" } else { "Index" }
  New-SdkShim $appRoot
  New-RunConfiguration $appDir $label
  New-PreviewerConfig $appRoot $page
  Write-Host "[OK] Configured $appDir ($label-Entry, preview page: $page)"
}

Write-Host "[OK] DevEco run configurations and previewer settings generated."
Write-Host "[INFO] Restart DevEco Studio if it is already open."
