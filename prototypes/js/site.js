(function() {
  $(function() {
    $('a[href="#fakelink"]').click(function(e) {
      return e.preventDefault();
    });
    
    $('a.droplink').click(function(e) {
      var $drop, $link;
      $link = $(e.currentTarget);
      $drop = $link.siblings('.dropdown');
      if ($link.is('.active') || $drop.is('.active')) {
        $link.removeClass('active');
        $drop.removeClass('active');
      } else {
        $link.addClass('active');
        $drop.addClass('active');
      }
      return false;
    });
    
    document.body.className += ' animate';
  });
}).call(this);
