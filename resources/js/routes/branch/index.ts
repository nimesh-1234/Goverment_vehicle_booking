import { queryParams, type RouteQueryOptions, type RouteDefinition, type RouteFormDefinition, applyUrlDefaults } from './../../wayfinder'
/**
 * @see routes/web.php:80
 * @route '/branch/{id}'
 */
export const specific = (args: { id: string | number } | [id: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: specific.url(args, options),
    method: 'get',
})

specific.definition = {
    methods: ["get","head"],
    url: '/branch/{id}',
} satisfies RouteDefinition<["get","head"]>

/**
 * @see routes/web.php:80
 * @route '/branch/{id}'
 */
specific.url = (args: { id: string | number } | [id: string | number ] | string | number, options?: RouteQueryOptions) => {
    if (typeof args === 'string' || typeof args === 'number') {
        args = { id: args }
    }

    
    if (Array.isArray(args)) {
        args = {
                    id: args[0],
                }
    }

    args = applyUrlDefaults(args)

    const parsedArgs = {
                        id: args.id,
                }

    return specific.definition.url
            .replace('{id}', parsedArgs.id.toString())
            .replace(/\/+$/, '') + queryParams(options)
}

/**
 * @see routes/web.php:80
 * @route '/branch/{id}'
 */
specific.get = (args: { id: string | number } | [id: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'get'> => ({
    url: specific.url(args, options),
    method: 'get',
})
/**
 * @see routes/web.php:80
 * @route '/branch/{id}'
 */
specific.head = (args: { id: string | number } | [id: string | number ] | string | number, options?: RouteQueryOptions): RouteDefinition<'head'> => ({
    url: specific.url(args, options),
    method: 'head',
})

    /**
 * @see routes/web.php:80
 * @route '/branch/{id}'
 */
    const specificForm = (args: { id: string | number } | [id: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
        action: specific.url(args, options),
        method: 'get',
    })

            /**
 * @see routes/web.php:80
 * @route '/branch/{id}'
 */
        specificForm.get = (args: { id: string | number } | [id: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: specific.url(args, options),
            method: 'get',
        })
            /**
 * @see routes/web.php:80
 * @route '/branch/{id}'
 */
        specificForm.head = (args: { id: string | number } | [id: string | number ] | string | number, options?: RouteQueryOptions): RouteFormDefinition<'get'> => ({
            action: specific.url(args, {
                        [options?.mergeQuery ? 'mergeQuery' : 'query']: {
                            _method: 'HEAD',
                            ...(options?.query ?? options?.mergeQuery ?? {}),
                        }
                    }),
            method: 'get',
        })
    
    specific.form = specificForm
const branch = {
    specific: Object.assign(specific, specific),
}

export default branch