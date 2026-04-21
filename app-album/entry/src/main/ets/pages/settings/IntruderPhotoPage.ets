import router from '@ohos.router';

@Preview
@Entry
@Component
struct IntruderPhotoPage {
  @State intruderEnabled: boolean = false;
  @State photos: string[] = [];

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('闯入者拍摄')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Row() {
        Text('启用闯入者拍摄')
          .fontSize(16).fontColor('#111827')
        Blank()
        Toggle({ type: ToggleType.Switch, isOn: this.intruderEnabled })
          .onChange((isOn: boolean) => {
            this.intruderEnabled = isOn;
          })
      }
      .width('100%').padding(16).backgroundColor('#FFFFFF').borderRadius(8)
      .margin({ left: 16, right: 16 })

      if (this.photos.length === 0) {
        Column() {
          Text('📸').fontSize(48)
          Text('暂无闯入记录').fontSize(16).fontColor('#6B7280').margin({ top: 12 })
          Text('开启后，输入错误密码时将自动拍摄').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
        }
        .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
      }
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
