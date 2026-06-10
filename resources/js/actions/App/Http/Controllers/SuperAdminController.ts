import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../../../wayfinder'
/**
* @see \App\Http\Controllers\SuperAdminController::storeBranch
 * @see app/Http/Controllers/SuperAdminController.php:16
 * @route '/super-admin/branches'
 */
export const storeBranch = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: storeBranch.url(options),
    method: 'post',
})

storeBranch.definition = {
    methods: ["post"],
    url: '/super-admin/branches',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\SuperAdminController::storeBranch
 * @see app/Http/Controllers/SuperAdminController.php:16
 * @route '/super-admin/branches'
 */
storeBranch.url = (options?: RouteQueryOptions) => {
    return storeBranch.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\SuperAdminController::storeBranch
 * @see app/Http/Controllers/SuperAdminController.php:16
 * @route '/super-admin/branches'
 */
storeBranch.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: storeBranch.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\SuperAdminController::storeBranch
 * @see app/Http/Controllers/SuperAdminController.php:16
 * @route '/super-admin/branches'
 */
    const storeBranchForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: storeBranch.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\SuperAdminController::storeBranch
 * @see app/Http/Controllers/SuperAdminController.php:16
 * @route '/super-admin/branches'
 */
        storeBranchForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: storeBranch.url(options),
            method: 'post',
        })
    
    storeBranch.form = storeBranchForm
/**
* @see \App\Http\Controllers\SuperAdminController::updateBranch
 * @see app/Http/Controllers/SuperAdminController.php:27
 * @route '/super-admin/branches/{branch}'
 */
export const updateBranch = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: updateBranch.url(args, options),
    method: 'put',
})

updateBranch.definition = {
    methods: ["put"],
    url: '/super-admin/branches/{branch}',
} satisfies RouteDefinition<["put"]>

/**
* @see \App\Http\Controllers\SuperAdminController::updateBranch
 * @see app/Http/Controllers/SuperAdminController.php:27
 * @route '/super-admin/branches/{branch}'
 */
updateBranch.url = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { branch: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { branch: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    branch: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        branch: typeof args.branch === 'object'
                ? args.branch.id
                : args.branch,
                }

    return updateBranch.definition.url
            .replace('{branch}', parsedArgs.branch.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\SuperAdminController::updateBranch
 * @see app/Http/Controllers/SuperAdminController.php:27
 * @route '/super-admin/branches/{branch}'
 */
updateBranch.put = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: updateBranch.url(args, options),
    method: 'put',
})

    /**
* @see \App\Http\Controllers\SuperAdminController::updateBranch
 * @see app/Http/Controllers/SuperAdminController.php:27
 * @route '/super-admin/branches/{branch}'
 */
    const updateBranchForm = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: updateBranch.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\SuperAdminController::updateBranch
 * @see app/Http/Controllers/SuperAdminController.php:27
 * @route '/super-admin/branches/{branch}'
 */
        updateBranchForm.put = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: updateBranch.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'PUT',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    updateBranch.form = updateBranchForm
/**
* @see \App\Http\Controllers\SuperAdminController::destroyBranch
 * @see app/Http/Controllers/SuperAdminController.php:38
 * @route '/super-admin/branches/{branch}'
 */
export const destroyBranch = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroyBranch.url(args, options),
    method: 'delete',
})

destroyBranch.definition = {
    methods: ["delete"],
    url: '/super-admin/branches/{branch}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\SuperAdminController::destroyBranch
 * @see app/Http/Controllers/SuperAdminController.php:38
 * @route '/super-admin/branches/{branch}'
 */
destroyBranch.url = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { branch: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { branch: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    branch: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        branch: typeof args.branch === 'object'
                ? args.branch.id
                : args.branch,
                }

    return destroyBranch.definition.url
            .replace('{branch}', parsedArgs.branch.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\SuperAdminController::destroyBranch
 * @see app/Http/Controllers/SuperAdminController.php:38
 * @route '/super-admin/branches/{branch}'
 */
destroyBranch.delete = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroyBranch.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\SuperAdminController::destroyBranch
 * @see app/Http/Controllers/SuperAdminController.php:38
 * @route '/super-admin/branches/{branch}'
 */
    const destroyBranchForm = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroyBranch.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\SuperAdminController::destroyBranch
 * @see app/Http/Controllers/SuperAdminController.php:38
 * @route '/super-admin/branches/{branch}'
 */
        destroyBranchForm.delete = (args: { branch: number | { id: number } } | [branch: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: destroyBranch.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'DELETE',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    destroyBranch.form = destroyBranchForm
/**
* @see \App\Http\Controllers\SuperAdminController::storeUser
 * @see app/Http/Controllers/SuperAdminController.php:47
 * @route '/super-admin/users'
 */
export const storeUser = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: storeUser.url(options),
    method: 'post',
})

storeUser.definition = {
    methods: ["post"],
    url: '/super-admin/users',
} satisfies RouteDefinition<["post"]>

/**
* @see \App\Http\Controllers\SuperAdminController::storeUser
 * @see app/Http/Controllers/SuperAdminController.php:47
 * @route '/super-admin/users'
 */
storeUser.url = (options?: RouteQueryOptions) => {
    return storeUser.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\SuperAdminController::storeUser
 * @see app/Http/Controllers/SuperAdminController.php:47
 * @route '/super-admin/users'
 */
storeUser.post = (options?: RouteQueryOptions): RouteDefinition<'post'> => ({
    url: storeUser.url(options),
    method: 'post',
})

    /**
* @see \App\Http\Controllers\SuperAdminController::storeUser
 * @see app/Http/Controllers/SuperAdminController.php:47
 * @route '/super-admin/users'
 */
    const storeUserForm = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: storeUser.url(options),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\SuperAdminController::storeUser
 * @see app/Http/Controllers/SuperAdminController.php:47
 * @route '/super-admin/users'
 */
        storeUserForm.post = (options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: storeUser.url(options),
            method: 'post',
        })
    
    storeUser.form = storeUserForm
/**
* @see \App\Http\Controllers\SuperAdminController::updateUser
 * @see app/Http/Controllers/SuperAdminController.php:70
 * @route '/super-admin/users/{user}'
 */
export const updateUser = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: updateUser.url(args, options),
    method: 'put',
})

updateUser.definition = {
    methods: ["put"],
    url: '/super-admin/users/{user}',
} satisfies RouteDefinition<["put"]>

/**
* @see \App\Http\Controllers\SuperAdminController::updateUser
 * @see app/Http/Controllers/SuperAdminController.php:70
 * @route '/super-admin/users/{user}'
 */
updateUser.url = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { user: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { user: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    user: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        user: typeof args.user === 'object'
                ? args.user.id
                : args.user,
                }

    return updateUser.definition.url
            .replace('{user}', parsedArgs.user.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\SuperAdminController::updateUser
 * @see app/Http/Controllers/SuperAdminController.php:70
 * @route '/super-admin/users/{user}'
 */
updateUser.put = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'put'> => ({
    url: updateUser.url(args, options),
    method: 'put',
})

    /**
* @see \App\Http\Controllers\SuperAdminController::updateUser
 * @see app/Http/Controllers/SuperAdminController.php:70
 * @route '/super-admin/users/{user}'
 */
    const updateUserForm = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: updateUser.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'PUT',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\SuperAdminController::updateUser
 * @see app/Http/Controllers/SuperAdminController.php:70
 * @route '/super-admin/users/{user}'
 */
        updateUserForm.put = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: updateUser.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'PUT',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    updateUser.form = updateUserForm
/**
* @see \App\Http\Controllers\SuperAdminController::destroyUser
 * @see app/Http/Controllers/SuperAdminController.php:104
 * @route '/super-admin/users/{user}'
 */
export const destroyUser = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroyUser.url(args, options),
    method: 'delete',
})

destroyUser.definition = {
    methods: ["delete"],
    url: '/super-admin/users/{user}',
} satisfies RouteDefinition<["delete"]>

/**
* @see \App\Http\Controllers\SuperAdminController::destroyUser
 * @see app/Http/Controllers/SuperAdminController.php:104
 * @route '/super-admin/users/{user}'
 */
destroyUser.url = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { user: args }
    }

            if (typeof args === 'object' && !Array.isArray(args) && 'id' in args) {
            args = { user: args.id }
        }
    
    if (Array.isArray(args)) {
        args = {
                    user: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        user: typeof args.user === 'object'
                ? args.user.id
                : args.user,
                }

    return destroyUser.definition.url
            .replace('{user}', parsedArgs.user.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
* @see \App\Http\Controllers\SuperAdminController::destroyUser
 * @see app/Http/Controllers/SuperAdminController.php:104
 * @route '/super-admin/users/{user}'
 */
destroyUser.delete = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteDefinition<'delete'> => ({
    url: destroyUser.url(args, options),
    method: 'delete',
})

    /**
* @see \App\Http\Controllers\SuperAdminController::destroyUser
 * @see app/Http/Controllers/SuperAdminController.php:104
 * @route '/super-admin/users/{user}'
 */
    const destroyUserForm = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
        action: destroyUser.url(args, {
                    [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                        _method: 'DELETE',
                        ...(options?.query ?? options?.mergeQuery ?? {}),
                    }
                }),
        method: 'post',
    })

            /**
* @see \App\Http\Controllers\SuperAdminController::destroyUser
 * @see app/Http/Controllers/SuperAdminController.php:104
 * @route '/super-admin/users/{user}'
 */
        destroyUserForm.delete = (args: { user: number | { id: number } } | [user: number | { id: number } ] | number | { id: number }, options?: RouteQueryOptions): RouteFormDefinition<'post'> => ({
            action: destroyUser.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'DELETE',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'post',
        })
    
    destroyUser.form = destroyUserForm
const SuperAdminController = { storeBranch, updateBranch, destroyBranch, storeUser, updateUser, destroyUser }

export default SuperAdminController