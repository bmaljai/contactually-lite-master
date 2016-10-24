app.controller('angCtrl', function($scope, $http){
  $scope.contacts = [];

  $scope.setup = function() {
      $http.get('/contacts.json').then(function(response) {
        $scope.contacts = response.data;
      });
    }


    $scope.deleteContact = function(contact) {
      $http.delete("/contacts/" + contact.id).then(function(response) {
        var index = $scope.contacts.indexOf(contact);
        $scope.contacts.splice(index, 1);
      });
      
    }

    window.$scope = $scope;
});