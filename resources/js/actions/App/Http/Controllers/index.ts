import Auth from './Auth'
import VehicleStatusController from './VehicleStatusController'
import BookingController from './BookingController'
import SuperAdminController from './SuperAdminController'
import Settings from './Settings'
import Teams from './Teams'
const Controllers = {
    Auth: Object.assign(Auth, Auth),
VehicleStatusController: Object.assign(VehicleStatusController, VehicleStatusController),
BookingController: Object.assign(BookingController, BookingController),
SuperAdminController: Object.assign(SuperAdminController, SuperAdminController),
Settings: Object.assign(Settings, Settings),
Teams: Object.assign(Teams, Teams),
}

export default Controllers