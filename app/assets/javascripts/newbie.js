var $container = null;
function getUnitWidth() {
  var width;
  if ($(".visible-phone").is(":visible")) {
      width = $container.width() / 2;
  } else if ($(".visible-tablet").is(":visible")) {
      width = $container.width() / 3;
  } else {
      width = $container.width() / 5;
  }
  return width;
}

$.fn.textWidth = function(){
  var html_org = $(this).html();
  var html_calc = '<span>' + html_org + '</span>';
  $(this).html(html_calc);
  var width = $(this).find('span:first').width();
  console.log("Width " + width);
  $(this).html(html_org);
  return width;
};

// display - isotope 
$('.item').click(function() {
  console.log('click item');
})

function onGetRiverStream(river) {
  for (var j = 0; j < river.updatedFeeds.updatedFeed.length; j++) {
    var feed = river.updatedFeeds.updatedFeed[j];
    for (var i = 0; i < feed.item.length; i++) {
      var sizeBucket = Math.floor(feed.item[i].body.length / 70) + 2;
      var $newItems = $("<div class='item span12' data-upd='"+ feed.item[i].pubDate +"'><h3><a target='_blank' href='" + feed.item[i].link + "' class='title'>" +
       feed.item[i].title + "</a></h3><h4 class='updated'>"+feed.item[i].pubDate + "</h4><h4 class='feed'>"+ feed.feedTitle +
       "</h4><div class='description'>"+ feed.item[i].body +"</div></div>");
      $('#container').append( $newItems ).isotope( 'insert', $newItems );
    }    
  }
  $('#container').isotope({ sortBy : 'updated', sortAscending: false });  
}
// newbie
function Newbie() {
  this.items = new Array();
  $(document).bind('feedUpdated',handle_feedUpdated);
}

Newbie.prototype.getSubscriptions = function() {
}

Newbie.prototype.handleFeed = function(xmlUrl,feed) {
  for (var j = 0; j < feed.items.length; j++) {
    console.log(feed.items[i].link);
    this.items.push(feed.items[j]);
  }
  this.items.sort(function(f1,f2) {return f1.updated < f2.updated;});
 };
  
$(document).ready(function() {
  $container = $('#container');
  $('#sort-by a').click(function(){
    // get href attribute, minus the '#'
    var sortName = $(this).attr('href').slice(1);
    $('#container').isotope({ sortBy : sortName, sortAscending: false });
    return false;
  }); 
  $('#filters a').click(function(){
    var selector = $(this).data('filter');
    $('#container').isotope({ filter: selector });
    return false;
  }); 
  $('#layout a').click(function() {
    var selector = $(this).data('layout');
    console.log('layout changed to ' + selector)
    $('#container').isotope({ layoutMode: selector });
    return false;

  })
  $container.isotope({
    layoutMode : 'straightDown',
    getSortData : {
      title : function ( $elem ) {
        console.log ('title sort');
        return $elem.find('.title').text();
      },
      feed : function ( $elem ) {
        return $elem.find('.feed').text();
      },
      updated: function ( $elem) {
        return $elem.find('.updated').text();
      },
      length: function ( $elem) {
        return $elem.find('.description').text();
      },
    },
    sort: 'updated',
    masonry: { columnWidth: getUnitWidth() }
  });

  $('#reload').click(function() {
    $.ajax({ url:"/iowaRiver3.js",
      dataType: "jsonp",
      jsonp: 'onGetRiverStream'
    });
  });
  $('#reload').click();
});
