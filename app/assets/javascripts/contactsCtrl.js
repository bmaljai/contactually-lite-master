(function () {
  "use strict";

  angular.module("contactsApp").controller("contactsCtrl", ['$scope', '$http', function($scope, $http) {

      $scope.contacts = [];
      $scope.contactFilter = {}

  $scope.setup = function() {
      $http.get('/contacts.json').then(function(response) {
        $scope.contacts = response.data;
      });
    }


    $scope.deleteContact = function(contact) {
      $http.delete("/contacts/" + contact.id).then(function(response){
        var index = $scope.contacts.indexOf(contact);
        $scope.contacts.splice(index, 1);
        console.log(index);
    });
    };

    $scope.toggleByAttribute = function(attribute) {
      if (attribute == $scope.orderAttribute) {
        $scope.descending = !$scope.descending;
      } else {
        $scope.orderAttribute = attribute;
      }
    }

    $scope.viewAllcontacts = function(){
      $scope.contactFilter = {}
    }

    $scope.filterEmailToggle = function(attribute) {
      if (attribute == $scope.contactFilter.email_address){
        $scope.contactFilter.email_address = "" ;
      } else{
        $scope.contactFilter.email_address = attribute;
      }
    }

    $scope.filterPhoneToggle = function(attribute) {
      if (attribute == $scope.contactFilter.phone_number){
        $scope.contactFilter.phone_number = "" ;
      } else{
        $scope.contactFilter.phone_number = attribute;
      }
    }
    

  }]);
})();