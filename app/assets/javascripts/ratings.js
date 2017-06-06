$(document).ready(function(){
  // put this in a function
  function renderRaty(){
    $('.star-rating').raty({
      path: '/assets/',
      readOnly: true,
      score: function() {
        return $(this).attr('data-score');
      }
    });
  }

  renderRaty()

$('#star-rating').raty({
    path: '/assets',
    scoreName: 'review[rating]'
});

// $('#star').raty({
//   readOnly: true,
//   score: <%= @property.average_rating %>,
//   path: '/assets'
// });


$("#new_review").submit(function() {
  $.ajax({
    type: $(this).attr('method'),
    url: $(this).attr('action'),
    dataType: "json",
    data: $(this).serialize() ,
    success: function(response) {
      // render this review on the page
      $("#new_review").remove()

      var reviewTemplate = $('#review-template').html();
      var reviewHtml = Mustache.render(reviewTemplate, response)
      $(".reviews-test").append(reviewHtml);

      renderRaty()
    },
    error: function(response){
      console.log(response)
    }
  })
  return false
})
})
