import branches from './branches'
import users from './users'
import bookings from './bookings'
const superAdmin = {
    branches: Object.assign(branches, branches),
users: Object.assign(users, users),
bookings: Object.assign(bookings, bookings),
}

export default superAdmin