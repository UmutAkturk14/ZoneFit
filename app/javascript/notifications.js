// app/assets/javascripts/notifications.js
document.addEventListener("DOMContentLoaded", function() {
  // Periodically fetch notification counts
  setInterval(function() {
    fetch('/chatrooms/counts')
      .then(function(response) {
        if (response.ok) {
          return response.json();
        } else {
          throw new Error('Error occurred while fetching notification counts');
        }
      })
      .then(function(data) {
        updateNotificationCounts(data);
      })
      .catch(function(error) {
        console.log(error);
      });
  }, 5000);

  // Update notification count and mark as read on chatroom link click
  document.addEventListener("click", function(event) {
    var link = event.target.closest(".chatroom-link");
    if (link) {
      var chatroomId = link.dataset.chatroomId;
      markChatroomAsRead(chatroomId);
      resetNotificationCount(chatroomId);
    }
  });
});

function updateNotificationCounts(data) {
  Object.keys(data).forEach(function(chatroomId) {
    var count = data[chatroomId];
    var elementId = 'notification-count-' + chatroomId;
    var element = document.getElementById(elementId);

    if (count > 0) {
      element.textContent = count;
    } else {
      element.textContent = '';
    }
  });
}

function markChatroomAsRead(chatroomId) {
  fetch('/chatrooms/' + chatroomId + '/mark_as_read', { method: 'POST' });
}

function resetNotificationCount(chatroomId) {
  var elementId = 'notification-count-' + chatroomId;
  var element = document.getElementById(elementId);
  element.textContent = '';
}
