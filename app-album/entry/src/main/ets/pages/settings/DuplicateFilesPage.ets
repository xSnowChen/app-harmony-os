import router from '@ohos.router';

@Preview
@Entry
@Component
struct DuplicateFilesPage {
  @State duplicates: string[] = [];

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('查看重复文件')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Column() {
        Text('📄').fontSize(48)
        Text('暂未检测到重复文件').fontSize(16).fontColor('#6B7280').margin({ top: 12 })
        Text('扫描加密相册中的重复内容以节省空间').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
        Button('开始扫描')
          .width('60%').height(44).fontSize(16).fontColor('#FFFFFF')
          .backgroundColor('#6366F1').borderRadius(8).margin({ top: 20 })
      }
      .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
