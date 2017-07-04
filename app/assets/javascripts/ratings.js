$(document).ready(function(){
  function renderRaty(){
    $('.star-rating').raty({
      path: '/assets/',
      readOnly: true,
      score: function() {
        return $(this).attr('data-score');
      }
    });
  }
  renderRaty();
    $('#star-rating').raty({
        path: '/assets',
        scoreName: 'review[rating]'
});

$("#new_review").submit(function() {
  $.ajax({
    type: $(this).attr('method'),
    url: $(this).attr('action'),
    dataType: "json",
    data: $(this).serialize() ,
      success: function(response) {
        document.getElementById('review_comment').value = '';
        var list = document.querySelector('#star-rating').children
        for (var i = 0; i < 5; i++) {
          list[i].src = "/assets/star-off.png"
        }
        var reviewTemplate = $('#review-template').html();
        var reviewHtml = Mustache.render(reviewTemplate, response);
        $(".all-reviews").append(reviewHtml);

        renderRaty();
      },
      error: function(response){
        console.log(response);
      }
    });
    return false;
  });
});
