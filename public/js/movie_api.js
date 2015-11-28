var submitAjaxRequest = function() {
  $('#find_movie').on('click',function(event) {
    event.preventDefault();
    var data = $('.jumbotron').find(".selected");
    var data_ids = []
    $('.modal-body').empty();
    $('.modal-body').html('Doing some really cool calculations')
    var imgUrl = "https://image.tmdb.org/t/p/w185/"
    for (var i=0; i <= (data.length -1); i++) {
      data_ids.push(data[i].id);
    }

    var response = $.ajax({
      type: 'get',
      url: '/movies',
      data: {
        term1: data_ids[0],
        term2: data_ids[1],
        term3: data_ids[2]
      }
    });

    response.done(function(data){
      var parse_data = JSON.parse(data);
      console.log(parse_data)
      console.log(parse_data.results[0])
      if (parse_data.total_results === 0) {
        $('.modal-body').html('<p>Nothing Found - try again</p>');
      } else {
        var random = Math.floor(Math.random() * (parse_data.results.length - 0));
        var movieResult = parse_data.results[random];

        $('.modal-body').html("<h1 id='title'>"+movieResult.original_title+"</h1>" + "<img src=" + imgUrl + movieResult.poster_path +">" + "<p>" + movieResult.overview + "</p>");
      };
    });
  })
}


