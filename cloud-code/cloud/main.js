// Use Parse.Cloud.define to define as many cloud functions as you want.
// For example:
Parse.Cloud.define("hello", function (request, response) {
    response.success("Hello world!");
});

Parse.Cloud.beforeSave('Organization', function (request, response) {
    var organization = request.object;
    var query = new Parse.Query('Organization');

    query.equalTo('name', organization.name).find({
        success: function (org) {
            response.error({message: 'Duplicate name', name: org.name});
        },

        error: function (error) {
            console.log(error);
            organization.save();
            response.success();
        }
    });
});
