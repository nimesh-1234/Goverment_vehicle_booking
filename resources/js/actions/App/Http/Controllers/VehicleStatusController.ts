import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition } from './../../../../wayfinder'
/**
* @see \App\Http\Controllers\VehicleStatusController::__invoke
 * @see app/Http/Controllers/VehicleStatusController.php:15
 * @route '/vehicle-status'
 */
const VehicleStatusController = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: VehicleStatusController.url(options),
    method: 'get',
})

VehicleStatusController.definition = {
    methods: ["get","head"],
    url: '/vehicle-status',
} satisfies RouteDefinition<["get","head"]>

/**
* @see \App\Http\Controllers\VehicleStatusController::__invoke
 * @see app/Http/Controllers/VehicleStatusController.php:15
 * @route '/vehicle-status'
 */
VehicleStatusController.url = (options?: RouteQueryOptions) => {
    return VehicleStatusController.definition.url + queryParams(options)
}

/**
* @see \App\Http\Controllers\VehicleStatusController::__invoke
 * @see app/Http/Controllers/VehicleStatusController.php:15
 * @route '/vehicle-status'
 */
VehicleStatusController.get = (options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: VehicleStatusController.url(options),
    method: 'get',
})
/**
* @see \App\Http\Controllers\VehicleStatusController::__invoke
 * @see app/Http/Controllers/VehicleStatusController.php:15
 * @route '/vehicle-status'
 */
VehicleStatusController.head = (options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: VehicleStatusController.url(options),
    method: 'head',
})

    /**
* @see \App\Http\Controllers\VehicleStatusController::__invoke
 * @see app/Http/Controllers/VehicleStatusController.php:15
 * @route '/vehicle-status'
 */
    const VehicleStatusControllerForm = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: VehicleStatusController.url(options),
        method: 'get',
    })

            /**
* @see \App\Http\Controllers\VehicleStatusController::__invoke
 * @see app/Http/Controllers/VehicleStatusController.php:15
 * @route '/vehicle-status'
 */
        VehicleStatusControllerForm.get = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: VehicleStatusController.url(options),
            method: 'get',
        })
            /**
* @see \App\Http\Controllers\VehicleStatusController::__invoke
 * @see app/Http/Controllers/VehicleStatusController.php:15
 * @route '/vehicle-status'
 */
        VehicleStatusControllerForm.head = (options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: VehicleStatusController.url({
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    VehicleStatusController.form = VehicleStatusControllerForm
export default VehicleStatusController