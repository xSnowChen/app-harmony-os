import router from '@ohos.router';

@Entry
@Component
struct AppSettingsPage {
  @State autoLock: boolean = true;
  @State lockDelay: number = 1;
  @State autoBackup: boolean = false;

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('App设置')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Column({ space: 0 }) {
        Row() {
          Text('自动锁定').fontSize(16).fontColor('#111827')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.autoLock })
            .onChange((isOn: boolean) => { this.autoLock = isOn; })
        }.width('100%').padding(16)

        Divider().color('#E5E7EB')

        Row() {
          Text('锁定延迟(分钟)').fontSize(16).fontColor('#111827')
          Blank()
          Text(this.lockDelay.toString()).fontSize(16).fontColor('#6366F1')
        }.width('100%').padding(16)

        Divider().color('#E5E7EB')

        Row() {
          Text('自动备份').fontSize(16).fontColor('#111827')
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.autoBackup })
            .onChange((isOn: boolean) => { this.autoBackup = isOn; })
        }.width('100%').padding(16)
      }
      .backgroundColor('#FFFFFF').borderRadius(8).margin({ left: 16, right: 16 })

      Blank()
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
