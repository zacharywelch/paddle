$ ->
  # Disable link clicks to prevent page scrolling
  $('a[href="#fakelink"]').click (e) ->
    e.preventDefault()

  # Navigation dropdowns
  $('a.droplink').click (e) ->
    $link = $(e.currentTarget)
    $drop = $link.siblings('.dropdown')
    
    if $link.is('.active') or $drop.is('.active')
      $link.removeClass('active')
      $drop.removeClass('active')
    else
      $link.addClass('active')
      $drop.addClass('active')
    
    return false    

  $('.match-player :radio').change (e) ->
    $('.match-player :radio').siblings('img').removeClass('pulse')
    $(this).siblings('img').addClass('pulse')

  # Add animate class to body element
  document.body.className += ' animate'