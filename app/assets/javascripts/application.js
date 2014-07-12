// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


(function(root){
  var Friends = root.Friends = (root.Friends || {})
  
  Friends.addFriend = function (event) {
    $target = $(event.target);
    $friendID = $target.data('id');
    $friendUserName = $target.data('username');
    console.log("Thank you for adding "+$friendUserName+ 
    " (uid="+$friendID+")");
    
    $target.text("Friending...");
    
    $.ajax({
      url: '/users/'+$friendID+"/friendships",
      type: 'POST',
      success: function(response){
        console.log(response);
        // var $ourButton = $(".add-friend[data-id="+$friendID+"]");
        var $ourParent = $target.parent();
        // $ourButton.remove();
        $target.remove();
        $ourParent.append("<button class='remove-friend' data-id=" +
                          $friendID + " data-friendship=" +
                          response.id + ">Remove Friend</button>");
        
        
      },
      error: function(response){
        alert("Obviously they don't like you. Try again later.");
      }
    })
  };
  
  Friends.removeFriend = function (event) {
    $target = $(event.target);
    $friendID = $target.data('id');
    $friendshipID = $target.data('friendship');
    $friendUserName = $target.data('username');
    console.log("Thank you for removing (uid="+$friendID+")");
    
    $target.text("Removing...");
    
    $.ajax({
      url: '/users/'+$friendID+"/friendships/"+$friendshipID,
      type: 'DELETE',
      success: function(response){
        console.log(response);
        // var $ourButton = $(".remove-friend[data-id="+$friendID+"]");
        var $ourParent = $target.parent();
        $target.remove();
        $ourParent.append("<button class='add-friend' data-id=" +
                          $friendID + ">Add Friend</button");
      },
      error: function(response){
        
        alert("Obviously you don't like them.");
      }
    })
  }
  
  Friends.removeFriendForever = function (event) {
    $target = $(event.target);
    $friendID = $target.data('id');
    $friendshipID = $target.data('friendship');
    $friendUserName = $target.data('username');
    console.log("Thank you for removing (uid="+$friendID+")");
    
    $target.text("Removing...");
    
    $.ajax({
      url: '/users/'+$friendID+"/friendships/"+$friendshipID,
      type: 'DELETE',
      success: function(response){
        console.log(response);
        // var $ourButton = $(".remove-friend[data-id="+$friendID+"]");
        var $ourParent = $target.parent();
        $ourParent.remove();
      },
      error: function(response){
        
        alert("Obviously you don't like them.");
      }
    })
  }
})(this)




// (function(root){
//   var Secrets = root.Secrets = (root.Secrets || {})
//
// })(this)