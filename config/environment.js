/* jshint node: true */

module.exports = function (environment) {
    var ENV = {
        environment: environment,
        baseURL: '/',
        locationType: 'auto',
        EmberENV: {
            FEATURES: {
                // Here you can enable experimental features on an ember canary build
                // e.g. 'with-controller': true
            }
        },

        APP: {
            PARSE_APP_KEY: 'ESxAGpPrRUn1CuDXtZUgXHi5CN0tshaovooZt1MX',
            PARSE_JS_KEY: 'nl0RCvnoCz8VoUrqtmkCmQ16HbkNkFDSDLJ4LTvr'
        }
    };

    if (environment === 'development') {
        // LOG_MODULE_RESOLVER is needed for pre-1.6.0
        ENV.LOG_MODULE_RESOLVER = true;

        ENV.APP.LOG_RESOLVER = true;
        ENV.APP.LOG_ACTIVE_GENERATION = true;
        ENV.APP.LOG_MODULE_RESOLVER = true;
        // ENV.APP.LOG_TRANSITIONS = true;
        // ENV.APP.LOG_TRANSITIONS_INTERNAL = true;
        ENV.APP.LOG_VIEW_LOOKUPS = true;
    }

    if (environment === 'production') {

    }

    return ENV;
};
