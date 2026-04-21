import router from '@ohos.router';

@Entry
@Component
struct LargeFilesPage {
  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('大文件排序')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Column() {
        Text('📊').fontSize(48)
        Text('暂无大文件记录').fontSize(16).fontColor('#6B7280').margin({ top: 12 })
        Text('按文件大小排序，快速找到占用空间的文件').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
      }
      .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
