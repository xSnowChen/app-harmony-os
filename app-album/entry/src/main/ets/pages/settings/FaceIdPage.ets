import router from '@ohos.router';

@Entry
@Component
struct FaceIdPage {
  @State faceIdEnabled: boolean = false;
  @State folderAccess: boolean = false;

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('Face ID')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Column({ space: 0 }) {
        Row() {
          Column() {
            Text('Face ID 解锁').fontSize(16).fontColor('#111827')
            Text('使用面部识别解锁加密相册').fontSize(13).fontColor('#6B7280')
          }
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.faceIdEnabled })
            .onChange((isOn: boolean) => { this.faceIdEnabled = isOn; })
        }
        .width('100%').padding(16)

        Divider().color('#E5E7EB')

        Row() {
          Column() {
            Text('文件夹 Face ID 访问').fontSize(16).fontColor('#111827')
            Text('使用 Face ID 访问特定文件夹').fontSize(13).fontColor('#6B7280')
          }
          Blank()
          Toggle({ type: ToggleType.Switch, isOn: this.folderAccess })
            .onChange((isOn: boolean) => { this.folderAccess = isOn; })
        }
        .width('100%').padding(16)
      }
      .backgroundColor('#FFFFFF').borderRadius(8).margin({ left: 16, right: 16 })

      Blank()
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
