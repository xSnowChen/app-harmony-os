import router from '@ohos.router';

@Entry
@Component
struct RecycleBinPage {
  @State itemList: string[] = [];

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('回收站')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
        Text('清空')
          .fontSize(14).fontColor('#EF4444')
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      if (this.itemList.length === 0) {
        Column() {
          Text('🗑️').fontSize(48)
          Text('回收站为空').fontSize(16).fontColor('#6B7280').margin({ top: 12 })
          Text('删除的文件会在这里保留30天').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
        }
        .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
      } else {
        List({ space: 8 }) {
          ForEach(this.itemList, (item: string) => {
            ListItem() {
              Row() {
                Text(item).fontSize(14).fontColor('#111827')
                Blank()
                Text('恢复').fontSize(13).fontColor('#6366F1')
              }
              .width('100%').padding(16).backgroundColor('#FFFFFF').borderRadius(8)
            }
          }, (item: string) => item)
        }
        .width('100%').layoutWeight(1).padding({ left: 16, right: 16 })
      }
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
