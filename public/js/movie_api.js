var submitAjaxRequest = function() {
  $('#find_movie').on('click',function(event) {
    event.preventDefault();
    var data = $('.jumbotron').find(".selected");
    var data_ids = []
    for (var i=0; i <= (data.length -1); i++) {
      data_ids.push(data[i].id);
    }

    var response = $.ajax({
      type: 'get',
      url: '/movies',
      data: {
        mood: data_ids[0],
        company: data_ids[1],
        genre: data_ids[2]
      }
    });

    response.done(function(data){
      var parse_data = JSON.parse(data);
      console.log(parse_data)
      if (parse_data.total_results === 0) {
        console.log("Nothing found")
      } else {
        var random = Math.floor(Math.random() * (parse_data.results.length - 0));
        $('body').append("<h1>"+parse_data.results[random].original_title+"</h1>");
      };
    });
  })
}


