import router from '@ohos.router';

@Preview
@Entry
@Component
struct VideosPage {
  @State videos: string[] = [];

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('视频')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
        Text('+').fontSize(24).fontColor('#EC4899')
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      if (this.videos.length === 0) {
        Column() {
          Text('🎬').fontSize(48)
          Text('暂无视频').fontSize(16).fontColor('#6B7280').margin({ top: 12 })
          Text('点击右上角 + 导入视频').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
        }
        .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
      }
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
