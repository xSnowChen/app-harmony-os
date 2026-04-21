import router from '@ohos.router';
import common from '@ohos.app.ability.common';
import { PasswordStore } from '../../utils/PasswordStore';

@Preview
@Entry
@Component
struct PasswordSecurityPage {
  @State currentPassword: string = '';
  @State newPassword: string = '';
  @State errorMsg: string = '';
  @State successMsg: string = '';
  private store: PasswordStore = new PasswordStore();

  private getContext(): common.UIAbilityContext {
    return this.getUIContext().getHostContext() as common.UIAbilityContext;
  }

  async aboutToAppear(): Promise<void> {
    await this.store.init(this.getContext());
  }

  private async handleChangePassword(): Promise<void> {
    if (this.newPassword.length < 4) {
      this.errorMsg = '新密码至少4位';
      return;
    }
    const valid = await this.store.verifyPassword(this.currentPassword);
    if (!valid) {
      this.errorMsg = '当前密码错误';
      return;
    }
    await this.store.setPassword(this.newPassword);
    this.errorMsg = '';
    this.successMsg = '密码修改成功';
    this.currentPassword = '';
    this.newPassword = '';
  }

  build() {
    Column({ space: 12 }) {
      Row({ space: 12 }) {
        Button('←')
          .width(36).height(36).fontSize(18).fontColor('#111827')
          .backgroundColor('#FFFFFF').borderRadius(18)
          .onClick(() => { router.back(); })
        Text('密码与密保')
          .fontSize(20).fontWeight(FontWeight.Bold).fontColor('#111827')
        Blank()
      }
      .width('100%').padding({ left: 16, right: 16, top: 12, bottom: 12 })

      Column({ space: 16 }) {
        TextInput({ placeholder: '当前密码' })
          .type(InputType.Password).width('100%').height(48)
          .borderRadius(8).backgroundColor('#FFFFFF')
          .onChange((value: string) => { this.currentPassword = value; this.errorMsg = ''; })

        TextInput({ placeholder: '新密码' })
          .type(InputType.Password).width('100%').height(48)
          .borderRadius(8).backgroundColor('#FFFFFF')
          .onChange((value: string) => { this.newPassword = value; this.errorMsg = ''; })

        if (this.errorMsg) {
          Text(this.errorMsg).fontSize(13).fontColor('#EF4444')
        }
        if (this.successMsg) {
          Text(this.successMsg).fontSize(13).fontColor('#10B981')
        }

        Button('修改密码')
          .width('100%').height(48).fontSize(16).fontColor('#FFFFFF')
          .backgroundColor('#6366F1').borderRadius(8)
          .onClick(() => { void this.handleChangePassword(); })
      }
      .padding(16)
      .width('100%')

      Blank()
    }
    .width('100%').height('100%').backgroundColor('#F3F6FC')
  }
}
