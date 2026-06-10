import AuthenticatedSessionController from './AuthenticatedSessionController'
import PasswordResetLinkController from './PasswordResetLinkController'
import NewPasswordController from './NewPasswordController'
import RegisteredUserController from './RegisteredUserController'
import EmailVerificationNotificationController from './EmailVerificationNotificationController'
import ConfirmablePasswordController from './ConfirmablePasswordController'
import PasswordController from './PasswordController'
const Auth = {
    AuthenticatedSessionController: Object.assign(AuthenticatedSessionController, AuthenticatedSessionController),
PasswordResetLinkController: Object.assign(PasswordResetLinkController, PasswordResetLinkController),
NewPasswordController: Object.assign(NewPasswordController, NewPasswordController),
RegisteredUserController: Object.assign(RegisteredUserController, RegisteredUserController),
EmailVerificationNotificationController: Object.assign(EmailVerificationNotificationController, EmailVerificationNotificationController),
ConfirmablePasswordController: Object.assign(ConfirmablePasswordController, ConfirmablePasswordController),
PasswordController: Object.assign(PasswordController, PasswordController),
}

export default Auth