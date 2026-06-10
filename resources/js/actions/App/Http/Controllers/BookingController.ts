import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../wayfinder'
/**
* @see \App\Http\Controllers\BookingController::store
 * @see app/Http/Controllers/BookingController.php:15
 * @route '/bookings'
 */
export const store = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

store.definition = {
    methods: ["post"],
    url: '/bookings',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BookingController::store
 * @see app/Http/Controllers/BookingController.php:15
 * @route '/bookings'
 */
store.url = (options?: RouteQueryOptions) => {
    return store.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::store
 * @see app/Http/Controllers/BookingController.php:15
 * @route '/bookings'
 */
store.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: store.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BookingController::store
 * @see app/Http/Controllers/BookingController.php:15
 * @route '/bookings'
 */
    const storeForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: store.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::store
 * @see app/Http/Controllers/BookingController.php:15
 * @route '/bookings'
 */
        storeForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: store.url(options),
            method: 'post',
        })
    
    store.form = storeForm
/**
* @see \App\Http\Controllers\BookingController::approve
 * @see app/Http/Controllers/BookingController.php:47
 * @route '/bookings/{booking}/approve'
 */
export const approve = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: approve.url(args, options),
    method: 'post',
})

approve.definition = {
    methods: ["post"],
    url: '/bookings/{booking}/approve',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BookingController::approve
 * @see app/Http/Controllers/BookingController.php:47
 * @route '/bookings/{booking}/approve'
 */
approve.url = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return approve.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::approve
 * @see app/Http/Controllers/BookingController.php:47
 * @route '/bookings/{booking}/approve'
 */
approve.post = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: approve.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BookingController::approve
 * @see app/Http/Controllers/BookingController.php:47
 * @route '/bookings/{booking}/approve'
 */
    const approveForm = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: approve.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::approve
 * @see app/Http/Controllers/BookingController.php:47
 * @route '/bookings/{booking}/approve'
 */
        approveForm.post = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: approve.url(args, options),
            method: 'post',
        })
    
    approve.form = approveForm
/**
* @see \App\Http\Controllers\BookingController::reject
 * @see app/Http/Controllers/BookingController.php:68
 * @route '/bookings/{booking}/reject'
 */
export const reject = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: reject.url(args, options),
    method: 'post',
})

reject.definition = {
    methods: ["post"],
    url: '/bookings/{booking}/reject',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BookingController::reject
 * @see app/Http/Controllers/BookingController.php:68
 * @route '/bookings/{booking}/reject'
 */
reject.url = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return reject.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::reject
 * @see app/Http/Controllers/BookingController.php:68
 * @route '/bookings/{booking}/reject'
 */
reject.post = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: reject.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BookingController::reject
 * @see app/Http/Controllers/BookingController.php:68
 * @route '/bookings/{booking}/reject'
 */
    const rejectForm = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: reject.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::reject
 * @see app/Http/Controllers/BookingController.php:68
 * @route '/bookings/{booking}/reject'
 */
        rejectForm.post = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: reject.url(args, options),
            method: 'post',
        })
    
    reject.form = rejectForm
/**
* @see \App\Http\Controllers\BookingController::markAsReturned
 * @see app/Http/Controllers/BookingController.php:78
 * @route '/bookings/{booking}/mark-returned'
 */
export const markAsReturned = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: markAsReturned.url(args, options),
    method: 'post',
})

markAsReturned.definition = {
    methods: ["post"],
    url: '/bookings/{booking}/mark-returned',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\BookingController::markAsReturned
 * @see app/Http/Controllers/BookingController.php:78
 * @route '/bookings/{booking}/mark-returned'
 */
markAsReturned.url = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return markAsReturned.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::markAsReturned
 * @see app/Http/Controllers/BookingController.php:78
 * @route '/bookings/{booking}/mark-returned'
 */
markAsReturned.post = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: markAsReturned.url(args, options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\BookingController::markAsReturned
 * @see app/Http/Controllers/BookingController.php:78
 * @route '/bookings/{booking}/mark-returned'
 */
    const markAsReturnedForm = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: markAsReturned.url(args, options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::markAsReturned
 * @see app/Http/Controllers/BookingController.php:78
 * @route '/bookings/{booking}/mark-returned'
 */
        markAsReturnedForm.post = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: markAsReturned.url(args, options),
            method: 'post',
        })
    
    markAsReturned.form = markAsReturnedForm
/**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/bookings/{booking}'
 */
const update6c85be6b7173673130df8a61609a49cb = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update6c85be6b7173673130df8a61609a49cb.url(args, options),
    method: 'put',
})

update6c85be6b7173673130df8a61609a49cb.definition = {
    methods: ["put"],
    url: '/bookings/{booking}',
} satisfies RouteDefinition<["put"]>

/**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/bookings/{booking}'
 */
update6c85be6b7173673130df8a61609a49cb.url = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return update6c85be6b7173673130df8a61609a49cb.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/bookings/{booking}'
 */
update6c85be6b7173673130df8a61609a49cb.put = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: update6c85be6b7173673130df8a61609a49cb.url(args, options),
    method: 'put',
})

    /**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/bookings/{booking}'
 */
    const update6c85be6b7173673130df8a61609a49cbForm = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: update6c85be6b7173673130df8a61609a49cb.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/bookings/{booking}'
 */
        update6c85be6b7173673130df8a61609a49cbForm.put = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: update6c85be6b7173673130df8a61609a49cb.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'PUT',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    update6c85be6b7173673130df8a61609a49cb.form = update6c85be6b7173673130df8a61609a49cbForm
    /**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/super-admin/bookings/{booking}'
 */
const updatea3c420474abea6f0caf6c6569a082e23 = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: updatea3c420474abea6f0caf6c6569a082e23.url(args, options),
    method: 'put',
})

updatea3c420474abea6f0caf6c6569a082e23.definition = {
    methods: ["put"],
    url: '/super-admin/bookings/{booking}',
} satisfies RouteDefinition<["put"]>

/**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/super-admin/bookings/{booking}'
 */
updatea3c420474abea6f0caf6c6569a082e23.url = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return updatea3c420474abea6f0caf6c6569a082e23.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/super-admin/bookings/{booking}'
 */
updatea3c420474abea6f0caf6c6569a082e23.put = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: updatea3c420474abea6f0caf6c6569a082e23.url(args, options),
    method: 'put',
})

    /**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/super-admin/bookings/{booking}'
 */
    const updatea3c420474abea6f0caf6c6569a082e23Form = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: updatea3c420474abea6f0caf6c6569a082e23.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::update
 * @see app/Http/Controllers/BookingController.php:88
 * @route '/super-admin/bookings/{booking}'
 */
        updatea3c420474abea6f0caf6c6569a082e23Form.put = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: updatea3c420474abea6f0caf6c6569a082e23.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'PUT',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    updatea3c420474abea6f0caf6c6569a082e23.form = updatea3c420474abea6f0caf6c6569a082e23Form

/**
* Multiple routes resolve to \App\Http\Controllers\BookingController::update, so this export is a
* dictionary keyed by URI rather than a callable. Call a specific route with `update['<uri>'](...)`,
* or import the route by name from your generated `routes/` directory.
*/
export const update = {
    '/bookings/{booking}': update6c85be6b7173673130df8a61609a49cb,
    '/super-admin/bookings/{booking}': updatea3c420474abea6f0caf6c6569a082e23,
}

/**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/bookings/{booking}'
 */
const destroy6c85be6b7173673130df8a61609a49cb = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy6c85be6b7173673130df8a61609a49cb.url(args, options),
    method: 'delete',
})

destroy6c85be6b7173673130df8a61609a49cb.definition = {
    methods: ["delete"],
    url: '/bookings/{booking}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/bookings/{booking}'
 */
destroy6c85be6b7173673130df8a61609a49cb.url = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return destroy6c85be6b7173673130df8a61609a49cb.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/bookings/{booking}'
 */
destroy6c85be6b7173673130df8a61609a49cb.delete = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroy6c85be6b7173673130df8a61609a49cb.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/bookings/{booking}'
 */
    const destroy6c85be6b7173673130df8a61609a49cbForm = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroy6c85be6b7173673130df8a61609a49cb.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/bookings/{booking}'
 */
        destroy6c85be6b7173673130df8a61609a49cbForm.delete = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: destroy6c85be6b7173673130df8a61609a49cb.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'DELETE',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    destroy6c85be6b7173673130df8a61609a49cb.form = destroy6c85be6b7173673130df8a61609a49cbForm
    /**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/super-admin/bookings/{booking}'
 */
const destroya3c420474abea6f0caf6c6569a082e23 = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroya3c420474abea6f0caf6c6569a082e23.url(args, options),
    method: 'delete',
})

destroya3c420474abea6f0caf6c6569a082e23.definition = {
    methods: ["delete"],
    url: '/super-admin/bookings/{booking}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/super-admin/bookings/{booking}'
 */
destroya3c420474abea6f0caf6c6569a082e23.url = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { booking: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { booking: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    booking: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        booking: typeof args.booking === 'object'
                ? args.booking.id
                : args.booking,
                }

    return destroya3c420474abea6f0caf6c6569a082e23.definition.url
            .replace('{booking}', parsedArgs.booking.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/super-admin/bookings/{booking}'
 */
destroya3c420474abea6f0caf6c6569a082e23.delete = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroya3c420474abea6f0caf6c6569a082e23.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/super-admin/bookings/{booking}'
 */
    const destroya3c420474abea6f0caf6c6569a082e23Form = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroya3c420474abea6f0caf6c6569a082e23.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\BookingController::destroy
 * @see app/Http/Controllers/BookingController.php:112
 * @route '/super-admin/bookings/{booking}'
 */
        destroya3c420474abea6f0caf6c6569a082e23Form.delete = (args: { booking: number | { id: number } } | [booking: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: destroya3c420474abea6f0caf6c6569a082e23.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'DELETE',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    destroya3c420474abea6f0caf6c6569a082e23.form = destroya3c420474abea6f0caf6c6569a082e23Form

/**
* Multiple routes resolve to \App\Http\Controllers\BookingController::destroy, so this export is a
* dictionary keyed by URI rather than a callable. Call a specific route with `destroy['<uri>'](...)`,
* or import the route by name from your generated `routes/` directory.
*/
export const destroy = {
    '/bookings/{booking}': destroy6c85be6b7173673130df8a61609a49cb,
    '/super-admin/bookings/{booking}': destroya3c420474abea6f0caf6c6569a082e23,
}

const BookingController = { store, approve, reject, markAsReturned, update, destroy }

export default BookingController