import router from '@ohos.router';

@Entry
@Component
struct PhotosPage {
  @State folders: string[] = ['所有照片', '相机胶卷', '截图', '收藏'];
  @State photos: string[] = [];
  @State currentFolder: string = '所有照片';

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('照片')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
        Text('+')
          .fontSize(24).fontColor('#6366F1')
          .onClick(() => {})
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      // 文件夹切换
      Scroll() {
        Row({ space: 8 }) {
          ForEach(this.folders, (folder: string) => {
            Text(folder)
              .fontSize(13)
              .fontColor(this.currentFolder === folder ? '#FFFFFF' : '#6366F1')
              .backgroundColor(this.currentFolder === folder ? '#6366F1' : '#E0E7FF')
              .borderRadius(16)
              .padding({ left: 12, right: 12, top: 6, bottom: 6 })
              .onClick(() => { this.currentFolder = folder; })
          }, (folder: string) => folder)
        }
        .padding({ left: 16, right: 16 })
      }
      .scrollable(ScrollDirection.Horizontal)
      .scrollBar(BarState.Off)

      // 新建文件夹
      Row() {
        Text('新建文件夹')
          .fontSize(14).fontColor('#6366F1')
          .onClick(() => {})
        Blank()
        Text('导入照片')
          .fontSize(14).fontColor('#6366F1')
          .onClick(() => {})
      }
      .width('100%').padding({ left: 16, right: 16 })

      // 照片网格
      if (this.photos.length === 0) {
        Column() {
          Text('📷').fontSize(48)
          Text('暂无照片').fontSize(16).fontColor('#6B7280').margin({ top: 12 })
          Text('点击右上角 + 导入照片').fontSize(13).fontColor('#9CA3AF').margin({ top: 4 })
        }
        .width('100%').layoutWeight(1).justifyContent(FlexAlign.Center)
      } else {
        Grid() {
          ForEach(this.photos, (photo: string) => {
            GridItem() {
              Column() {
                Text(photo).fontSize(14).fontColor('#111827')
              }
              .width('100%').aspectRatio(1).backgroundColor('#E0E7FF').borderRadius(4)
              .justifyContent(FlexAlign.Center)
            }
          }, (photo: string) => photo)
        }
        .columnsTemplate('1fr 1fr 1fr')
        .rowsGap(4).columnsGap(4)
        .width('100%').padding({ left: 16, right: 16 }).layoutWeight(1)
      }
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
