import router from '@ohos.router';

@Preview
@Entry
@Component
struct BackupDataPage {
  @State lastBackup: string = '从未备份';

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('备份数据')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Column() {
        Text('💾').fontSize(48)
        Text('上次备份: ' + this.lastBackup).fontSize(16).fontColor('#6B7280').margin({ top: 12 })
        Text('将加密相册数据备份到安全位置').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
        Button('立即备份')
          .width('60%').height(44).fontSize(16).fontColor('#FFFFFF')
          .backgroundColor('#6366F1').borderRadius(8).margin({ top: 20 })
      }
      .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
