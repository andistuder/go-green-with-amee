//create your application module.
var app = angular.module('GoGreenApp', []);

//add a controller to it
app.controller('GoGreenCtrl', function($scope, $http) {

    //a scope function to load the data.
    $scope.postData = function () {
        $http.get('http://amee.com').success(function(data) {
                $scope.items = data;
            }).error(function(data){
                $scope.items = "Fail";
            });
    };

});