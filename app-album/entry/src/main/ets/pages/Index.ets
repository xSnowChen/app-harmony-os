import common from '@ohos.app.ability.common';
import Want from '@ohos.app.ability.Want';
import SoundEffectPlayer from '../utils/SoundEffectPlayer';

interface TargetApp {
  id: string;
  label: string;
  bundleName: string;
  moduleName: string;
  abilityName: string;
}

const COMMAND_OPEN_ENTRY: string = 'open-entry';
const START_WITHOUT_TIPS_FLAG: number = 0x100000;
const RETURN_SOUND_FILE: string = 'return.wav';

@Preview
@Entry
@Component
struct Index {
  @State status: string = '加密相册初始化界面';
  private readonly centerApp: TargetApp = {
    id: 'app-center',
    label: '应用中心',
    bundleName: 'com.zerows.appcenter',
    moduleName: 'entry',
    abilityName: 'EntryAbility'
  };
  private readonly soundEffectPlayer: SoundEffectPlayer = new SoundEffectPlayer();

  private getAbilityContext(): common.UIAbilityContext {
    const hostContext = this.getUIContext().getHostContext();
    if (!hostContext) {
      throw new Error('UIAbilityContext is unavailable');
    }
    return hostContext as common.UIAbilityContext;
  }

  private buildEntryWant(target: TargetApp): Want {
    return {
      bundleName: target.bundleName,
      moduleName: target.moduleName,
      abilityName: target.abilityName,
      flags: START_WITHOUT_TIPS_FLAG,
      parameters: {
        command: COMMAND_OPEN_ENTRY,
        starterApp: 'app-album',
        coordinationScene: 'album-back-to-center',
        sourceLabel: '加密相册',
        startedAt: Date.now()
      }
    };
  }

  private async playAndReturn(): Promise<void> {
    await this.soundEffectPlayer.play(this.getAbilityContext(), RETURN_SOUND_FILE);
    try {
      await this.getAbilityContext().startAbility(this.buildEntryWant(this.centerApp));
    } catch (err) {
      console.error('Return failed: ' + JSON.stringify(err));
    }
  }

  build() {
    Column({ space: 16 }) {
      Text('加密相册')
        .fontSize(28)
        .fontWeight(FontWeight.Bold)
        .fontColor('#111827')

      Text('初始应用界面')
        .fontSize(16)
        .fontColor('#667085')

      Text(this.status)
        .fontSize(14)
        .fontColor('#6366F1')
        .padding({ left: 12, right: 12, top: 8, bottom: 8 })
        .borderRadius(4)
        .backgroundColor('#E0E7FF')

      Column({ space: 12 }) {
        Row({ space: 12 }) {
          Column() {
            Text('相册功能')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
            Text('即将开发')
              .fontSize(12)
              .fontColor('#667085')
          }
          .alignItems(HorizontalAlign.Start)
          .padding(12)
          .borderRadius(4)
          .backgroundColor('#FFFFFF')
          .layoutWeight(1)

          Column() {
            Text('加密功能')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
            Text('即将开发')
              .fontSize(12)
              .fontColor('#667085')
          }
          .alignItems(HorizontalAlign.Start)
          .padding(12)
          .borderRadius(4)
          .backgroundColor('#FFFFFF')
          .layoutWeight(1)
        }

        Row({ space: 12 }) {
          Column() {
            Text('权限管理')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
            Text('即将开发')
              .fontSize(12)
              .fontColor('#667085')
          }
          .alignItems(HorizontalAlign.Start)
          .padding(12)
          .borderRadius(4)
          .backgroundColor('#FFFFFF')
          .layoutWeight(1)

          Column() {
            Text('云端备份')
              .fontSize(14)
              .fontWeight(FontWeight.Medium)
              .fontColor('#111827')
            Text('即将开发')
              .fontSize(12)
              .fontColor('#667085')
          }
          .alignItems(HorizontalAlign.Start)
          .padding(12)
          .borderRadius(4)
          .backgroundColor('#FFFFFF')
          .layoutWeight(1)
        }
      }
      .width('100%')

      Blank()

      Button('返回应用中心')
        .width('100%')
        .fontSize(16)
        .fontColor('#6366F1')
        .backgroundColor('#E0E7FF')
        .borderRadius(4)
        .onClick(() => {
          void this.playAndReturn();
        })
    }
    .width('100%')
    .height('100%')
    .padding(20)
    .backgroundColor('#F3F6FC')
  }
}