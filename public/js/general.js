/* global script variables */
var $parallex_effect = true;

jQuery(document).ready(function($){

  jQuery("<select />").appendTo(".responsive-nav");
  jQuery("<option />", {
  "selected": "selected",
  "value" : "",
  "text" : php_data.menu_text
  }).appendTo(".responsive-nav select");
  // Populate dropdown with menu items
  jQuery("#header nav li").each(function() {
    var depth = jQuery(this).parents('ul').length - 1;
    var indent = '';
    if( depth > 0 ) { indent = ' - '; }
    if( depth > 1 ) { indent = ' - - '; }
    if( depth > 2 ) { indent = ' - - -'; }
    if( depth > 3 ) { indent = ' - - - -'; }
    var el = jQuery(this).children('a');
    jQuery("<option />", {
      "value" : el.attr("href"),
      "text" : (indent+el.text())
    }).appendTo("nav select");
  });
  jQuery("nav select").change(function() {
    window.location = jQuery(this).find("option:selected").val();
  });

  // menu fix (child center alignment)
  jQuery("#navigation ul.nav > li").each( function()
  {
    if( jQuery(this).find("ul:first").length > 0 )
    {
      var parent_width = jQuery(this).outerWidth( true );
      var child_width = jQuery(this).find("ul:first").outerWidth( true );
      var new_width = parseInt( (child_width - parent_width ) / 2 );
      jQuery(this).find("ul:first").css( 'margin-left', -( new_width + 25 ) + "px");
    }
  });

  if( jQuery.browser.msie || jQuery.browser.mozilla ){ Screen = jQuery("html"); }
  else { Screen = jQuery("body"); }

  if ( jQuery('body.page-template-template-menu-list-php #sidebar, body.tax-menu-category #sidebar').length == 0 ){}
  else{
    jQuery('body.page-template-template-menu-list-php #sidebar, body.tax-menu-category #sidebar').localScroll();

    var sidebar_offset = jQuery('body.page-template-template-menu-list-php #sidebar, body.tax-menu-category #sidebar').offset().top;
    var sidebar_height = jQuery('body.page-template-template-menu-list-php #sidebar, body.tax-menu-category #sidebar').height();
    var footer_height = jQuery('#footer').height();
    var window_height = jQuery(window).height();
    var document_height = jQuery(document).height();

    jQuery(window).scroll( function() {

      if( (jQuery(document).scrollTop() > sidebar_offset ) && ( ( Screen.scrollTop() + sidebar_height )  < ( document_height - footer_height  ) ) ){
        jQuery('body.page-template-template-menu-list-php #sidebar, body.tax-menu-category #sidebar').css({ position: 'fixed', top: 0 });

      }else if( Screen.scrollTop() && ( (Screen.scrollTop() + sidebar_height ) > ( document_height - footer_height ) ) ){
          jQuery('body.page-template-template-menu-list-php #sidebar, body.tax-menu-category #sidebar').css({position: 'absolute', top: document_height - ( footer_height + sidebar_height )});
      }
      else{
        jQuery('body.page-template-template-menu-list-php #sidebar, body.tax-menu-category #sidebar').css({ position: 'relative', marginTop: 0, top: 0 });
      }

    });

  }

  /* The scripts that depends on scroll event */
  var $is_backtotop_displayed = false;
  var $scroll_position = 0;
  var $flex_caption_opacity = 1;
  var $ratio = 1;

  /* Handles on page load parallex effect */
  perform_parallex_effect();

  jQuery(window).scroll(function () {

    $scroll_position = jQuery(this).scrollTop();

    /* Handles on scroll parallex effect */
    if( $parallex_effect ){
      perform_parallex_effect();
    }

    /* back to top button script */
    if( $scroll_position < 100 && $is_backtotop_displayed ) {

        jQuery('.backtotop').animate({ bottom: '-30px' }, 100);
        $is_backtotop_displayed = false;

    }else if ( $scroll_position > 100 && ! $is_backtotop_displayed ) {

        jQuery('.backtotop').animate({ bottom: '17px' }, 100);
        $is_backtotop_displayed = true;
    }
  });

  // scroll body to 0px on click
  jQuery('.backtotop').click(function () {
    jQuery('html, body').animate({
        scrollTop: 0
    }, 800);
    return false;
  });


  // fancybox
  jQuery(".fancybox").fancybox();

  // menu grid masonry
  jQuery('body.page-template-template-menu-php .menu-card, body.tax-menu-category .has-subcategories .menu-grid').masonry();

});

/**
 *  Check whether the given element is visible in viewport area
 */
function isElementInViewport(element) {
  if( element ) {
    var rect = element.getBoundingClientRect();

    return ( !!rect
      && rect.bottom >= 0
      && rect.right >= 0
      && rect.top <= jQuery(window).height()
      && rect.left <= jQuery(window).width()
    );
  }
}

/**
 *  Perform parallex effect
 */
function perform_parallex_effect() {

  window_width = jQuery( window ).width();

  var $parallex_effect_item = '';

  if ( jQuery('.infobox ul > li').length != 0 )
    $parallex_effect_item = '.infobox ul > li';
  if ( jQuery('#pre-footer-widgets .widget-section').length != 0 ){
    if ( $parallex_effect_item != '' ) $parallex_effect_item += ',';
    $parallex_effect_item += '#pre-footer-widgets .widget-section';
  }
  if ( jQuery('.gallery-container ul > li').length != 0 )
    $parallex_effect_item = '.gallery-container ul > li';

  if ( $parallex_effect_item != '' ){
    var element_index = 0;
    jQuery($parallex_effect_item).each( function() {

      if ( ( jQuery('html.ie8').length != 0 || window_width <= 600 ) || ( !jQuery(this).hasClass('nice-effect') && ( isElementInViewport( jQuery(this)[0] ))) ){
        jQuery(this).addClass('nice-effect');
        var retain_this = this;
        setTimeout( function(){
          jQuery(retain_this).stop().animate({
            'opacity': 1
          }, 1000, function() {
            if( jQuery('html.ie8').length != 0 ){
              jQuery(retain_this).css('filter','');
            }
          });
        }, ( 300 * (element_index + 1) ) );
        element_index++;
      }
    });

    if( jQuery('html.ie8').length != 0 ){
      $parallex_effect = false;
    }
  }
}