#!/usr/bin/env bash

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEVECO_STUDIO_PATH="${DEVECO_STUDIO_PATH:-/Applications/DevEco-Studio.app}"
SDK_ROOT="$DEVECO_STUDIO_PATH/Contents/sdk/default"
SDK_PKG="$SDK_ROOT/sdk-pkg.json"

info() { printf '[INFO] %s\n' "$*"; }
ok() { printf '[OK] %s\n' "$*"; }
warn() { printf '[WARN] %s\n' "$*" >&2; }
fail() { printf '[ERROR] %s\n' "$*" >&2; exit 1; }

read_sdk_version_path() {
  python3 - "$SDK_PKG" <<'PY'
import json
import sys

with open(sys.argv[1], encoding="utf-8") as f:
    data = json.load(f)
print(data.get("data", {}).get("path", ""))
PY
}

app_label() {
  python3 - "$1/app.json" <<'PY'
import json
import re
import sys

with open(sys.argv[1], encoding="utf-8") as f:
    app = json.load(f).get("app", "")
label = re.sub(r"^app-", "", app)
print(label[:1].upper() + label[1:])
PY
}

create_sdk_shim() {
  local app_root="$1"
  local version_path="$2"
  local shim_root="$app_root/.deveco-sdk-shim"

  mkdir -p "$shim_root"
  cp "$SDK_PKG" "$shim_root/sdk-pkg.json"
  ln -sfn "$SDK_ROOT" "$shim_root/$version_path"
}

create_run_config() {
  local app_dir="$1"
  local label="$2"
  local version_path="$3"
  local config_file="$ROOT_DIR/.idea/runConfigurations/${label}_Entry.xml"

  mkdir -p "$ROOT_DIR/.idea/runConfigurations"
  cat >"$config_file" <<EOF
<component name="ProjectRunConfigurationManager">
  <configuration default="false" name="${label}-Entry" type="HvigorRunConfiguration" factoryName="HvigorRunConfiguration">
    <option name="applicationParameters" value="assembleApp -p product=default -p buildMode=debug" />
    <option name="nodeInterpreter" value="\$APPLICATION_HOME_DIR\$/tools/node/bin" />
    <option name="scriptFile" value="\$APPLICATION_HOME_DIR\$/tools/hvigor/bin/hvigorw.js" />
    <option name="workingDir" value="\$PROJECT_DIR\$/${app_dir}" />
    <envs>
      <env name="DEVECO_SDK_HOME" value="\$PROJECT_DIR\$/${app_dir}/.deveco-sdk-shim" />
      <env name="OHOS_BASE_SDK_HOME" value="\$PROJECT_DIR\$/${app_dir}/.deveco-sdk-shim/${version_path}/openharmony" />
    </envs>
    <method v="2" />
  </configuration>
</component>
EOF
}

create_previewer_config() {
  local app_root="$1"
  local page_name="${2:-Index}"
  local page_path="$app_root/entry/src/main/ets/pages/${page_name}.ets"

  mkdir -p "$app_root/.idea/previewer/phone"
  cat >"$app_root/.idea/previewer/previewConfigV2.json" <<'EOF'
{
 "1.0.0": {
  "LastPreviewDevice": {}
 },
 "1.0.1": {
  "profileList": [
   {
    "id": "Foldable",
    "deviceType": "phone",
    "width": 2224,
    "height": 2496,
    "foldable": true,
    "foldWidth": 1080,
    "foldHeight": 2504,
    "shape": "rect",
    "dpi": 520,
    "orientation": "portrait",
    "language": "zh_CN",
    "colorMode": "light"
   },
   {
    "id": "Phone",
    "deviceType": "phone",
    "foldable": false,
    "width": 1080,
    "height": 2340,
    "foldWidth": 0,
    "foldHeight": 0,
    "shape": "rect",
    "dpi": 480,
    "orientation": "portrait",
    "colorMode": "light",
    "language": "zh_CN"
   }
  ],
  "runningProfileList": [
   "Phone",
   "Foldable"
  ],
  "availableProfileList": []
 },
 "enableFileOperation": false
}
EOF

  cat >"$app_root/.idea/previewer/phone/phoneSettingConfig_Phone.json" <<'EOF'
{
 "setting": {
  "1.0.1": {
   "Language": {
    "args": {
     "Language": "zh_CN"
    }
   },
   "AvoidArea": {
    "args": {
     "topRect": {
      "posX": 0,
      "posY": 0,
      "width": 1080,
      "height": 117
     },
     "leftRect": {
      "posX": 0,
      "posY": 117,
      "width": 0,
      "height": 0
     },
     "rightRect": {
      "posX": 1080,
      "posY": 117,
      "width": 0,
      "height": 0
     },
     "bottomRect": {
      "posX": 0,
      "posY": 2256,
      "width": 1080,
      "height": 84
     }
    }
   }
  }
 },
 "frontend": {
  "1.0.0": {
   "Resolution": {
    "args": {
     "Resolution": "360*780"
    }
   },
   "DeviceType": {
    "args": {
     "DeviceType": "phone"
    }
   }
  }
 }
}
EOF

  if [[ -f "$page_path" ]]; then
    mkdir -p "$app_root/entry/.preview/config"
    python3 - "$ROOT_DIR" "$app_root" "$page_path" <<'PY'
import json
import os
import sys

root, app_root, page_path = [os.path.abspath(x) for x in sys.argv[1:]]
entry_root = os.path.join(app_root, "entry")
resources = os.path.join(entry_root, "src/main/resources")
preview_root = os.path.join(entry_root, ".preview")
pages_json = os.path.join(resources, "base/profile/main_pages.json")
pages = []
if os.path.exists(pages_json):
    with open(pages_json, encoding="utf-8") as f:
        pages = json.load(f).get("src", [])

build_config = {
    "deviceType": "phone",
    "buildMode": "debug",
    "note": "false",
    "logLevel": "3",
    "isPreview": "true",
    "port": "29900",
    "checkEntry": "true",
    "localPropertiesPath": os.path.join(app_root, "local.properties"),
    "aceProfilePath": os.path.join(preview_root, "default/intermediates/res/default/resources/base/profile"),
    "previewPagePath": page_path,
    "hapMode": "false",
    "img2bin": "true",
    "projectProfilePath": os.path.join(app_root, "build-profile.json5"),
    "watchMode": "true",
    "aceModuleRoot": os.path.join(entry_root, "src/main/ets"),
    "stageRouterConfig": {
        "paths": [
            os.path.join(preview_root, "default/intermediates/res/default/module.json"),
            os.path.join(preview_root, "default/intermediates/res/default/resources/base/profile/main_pages.json")
        ],
        "contents": [
            "{\"module\":{\"pages\":\"$profile:main_pages\",\"name\":\"entry\"}}",
            json.dumps({"src": pages}, ensure_ascii=False)
        ]
    }
}

with open(os.path.join(preview_root, "config/buildConfig.json"), "w", encoding="utf-8") as f:
    json.dump(build_config, f, ensure_ascii=False, separators=(",", ":"))

preview_param = {
    "APP_RESOURCES": os.path.join(app_root, "AppScope/resources"),
    "MODULE_RESOURCES": json.dumps({resources: "module_compiled"}, ensure_ascii=False),
    "HAR_RESOURCES": "{}",
    "PREVIEW_GENERATE_SOURCE_DIR": os.path.join(preview_root, "default/generated/r/default"),
    "PREVIEW_COMPILE_MODULE_NAMES": "entry"
}
with open(os.path.join(preview_root, "PreviewBuildParam.json"), "w", encoding="utf-8") as f:
    json.dump(preview_param, f, ensure_ascii=False, separators=(",", ":"))
PY
  else
    warn "Preview page missing for $(basename "$app_root"): $page_path"
  fi
}

main() {
  [[ -d "$DEVECO_STUDIO_PATH" ]] || fail "DevEco Studio not found: $DEVECO_STUDIO_PATH"
  [[ -f "$SDK_PKG" ]] || fail "SDK metadata not found: $SDK_PKG"

  local version_path
  version_path="$(read_sdk_version_path)"
  [[ -n "$version_path" ]] || fail "Unable to read SDK version path from $SDK_PKG"

  info "DevEco Studio: $DEVECO_STUDIO_PATH"
  info "SDK version path: $version_path"

  for app_root in "$ROOT_DIR"/app-*; do
    [[ -d "$app_root" && -f "$app_root/app.json" ]] || continue
    local app_dir label default_page
    app_dir="$(basename "$app_root")"
    label="$(app_label "$app_root")"
    default_page="${PREVIEW_PAGE:-Index}"
    if [[ "$app_dir" == "app-album" ]]; then
      default_page="${PREVIEW_PAGE:-MainPage}"
    fi

    create_sdk_shim "$app_root" "$version_path"
    create_run_config "$app_dir" "$label" "$version_path"
    create_previewer_config "$app_root" "$default_page"
    ok "Configured $app_dir (${label}-Entry, preview page: $default_page)"
  done

  ok "DevEco run configurations and previewer settings generated."
  info "Restart DevEco Studio if it is already open."
}

main "$@"
