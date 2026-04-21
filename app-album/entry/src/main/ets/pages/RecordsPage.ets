import router from '@ohos.router';

@Preview
@Entry
@Component
struct RecordsPage {
  @State items: string[] = [];

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('录音&文件')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
        Text('+').fontSize(24).fontColor('#3B82F6')
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // 功能切换
      Row({ space: 8 }) {
        Text('录音')
          .fontSize(14).fontColor('#3B82F6').backgroundColor('#DBEAFE')
          .borderRadius(16).padding({ left: 16, right: 16, top: 6, bottom: 6 })
        Text('文件')
          .fontSize(14).fontColor('#6B7280').backgroundColor('#F3F4F6')
          .borderRadius(16).padding({ left: 16, right: 16, top: 6, bottom: 6 })
      }
      .padding({ left: 16 })

      if (this.items.length === 0) {
        Column() {
          Text('🎙️').fontSize(48)
          Text('暂无录音和文件').fontSize(16).fontColor('#6B7280').margin({ top: 12 })
          Text('点击右上角 + 录音或导入文件').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
        }
        .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
      }
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
