jQuery(document).ready(function($) {
	
	/* Dropdown menu */
		
	$('#mainmenu nav ul').supersubs({ 
        minWidth: 12,
        maxWidth: 27,
        extraWidth: 1
    }).superfish({ 
		delay: 200,
		autoArrows: true,		
		animation: {opacity:'show', height:'show'},
		speed: 'fast'
	});
	
	/* Dropdown menu for mobile */
	
	var menuopen = false;
	
	$('#togglemenu').click(function() {
		if (menuopen) {
			$('#mainmenu nav').css('display', 'none');
			$('#togglemenu a').removeClass('open');
		}
		else {
			$('#mainmenu nav').css('display', 'block');
			$('#togglemenu a').addClass('open');
		}
		menuopen = !menuopen;
	});
	
	/* FlexSlider Slider */
	
	$('.home-slider .flexslider').flexslider({
		controlsContainer: '.flex-nav'
	});	
	
	/* Roundabout Slider */
	
	var $slides = $('.home-slider .roundabout ul.slides');	
	$slides.roundabout({
		responsive: true,
		btnPrev: '.slider-nav.left',
		btnNext: '.slider-nav.right'		
	});
		
	/* Carousel Slider */
	
	var $slides = $('.home-slider .carousel ul.slides');	
	$slides.imagesLoaded(function() {
		$slides.css({'height': 'auto', 'opacity': '100'});
		$slides.carouFredSel({			
			height: 'variable',	
			items: {
				height: 'auto',
				visible: 3				
			},
			scroll: {
				items: 1,			
				fx: 'scroll',
				duration: 500,
				pauseOnHover: true,
				wipe: true, 
			},			
			prev: {	
				button: '.slider-nav.left',
				key: 'left'
			},
			next: { 
				button: '.slider-nav.right',
				key: 'right'
			}
		});
	});	
	
	/* FlexSlider Widgets */
	
	$('.widget_testimonials .flexslider, .widget_snippets .flexslider').flexslider({
		controlNav: false,
		prevText: '<span>Previous</span>',
		nextText: '<span>Next</span>'
	});
	
	/* FlexSlider Image Slider */	
	
	$('.slideshow.flexslider').flexslider({
		controlNav: false
	});	
	
	/* Snippets Isotope */
	
	var $snippets = $('.snippets');
	$snippets.imagesLoaded(function() {
		$snippets.isotope({
			itemSelector: '.snippet',
			layoutMode: 'fitRows'
		});
	});	
	
	$('.filter a').click(function(){
		var selector = $(this).attr('data-filter');
		$snippets.isotope({ filter: selector });
		if (!$(this).hasClass('selected')) {
			$(this).parents('.filter').find('.selected').removeClass('selected');
			$(this).addClass('selected');
		}
		return false;
	});
	
	/* Tooltips */
	
	$('.tiptip').tipTip();
	
	/* Tabs */
	
	$('.tabs').tabs({
		fx: [{opacity: 'toggle', duration: 'fast'}, {opacity: 'toggle', duration: 'normal'}]
	});
	
	/* Accordion */
	
	$('.accordion').accordion({
		autoHeight: false,
		active: false,
		collapsible: true,
		icons: false
	});
	
	/* FitVids */
	
	$("#wrapper").fitVids();
	
	/* FancyBox */
	
	if (jQuery().fancybox) {
		
		$('a[href$="jpg"], a[href$="png"], a[href$="gif"]').fancybox({
			'padding': 0,
			'transitionIn': 'fade',
			'transitionOut': 'fade',
			'titlePosition': 'over',
			'overlayOpacity': '.8',
	        'overlayColor': '#000000'
		});
		
		$('a.youtube').click(function() {
	        $.fancybox({
	            'padding': 0,
	            'autoScale': false,
	            'transitionIn': 'fade',
				'transitionOut': 'fade',
	            'title': this.title,
	            'overlayOpacity': '.8',
	            'overlayColor': '#000000',
	            'width': 640,
				'height': 388,
	            'href': this.href.replace(new RegExp("watch\\?v=", "i"), 'v/') + '&autoplay=1&hd=1&showinfo=0&fs=1',
	            'type': 'swf',
	            'swf': {'wmode': 'transparent', 'allowfullscreen': 'true'}
	        });
	        return false;
	    });
	    
	    $('a.vimeo').click(function() {
			$.fancybox({
				'padding': 0,
				'autoScale': false,
				'transitionIn': 'fade',
				'transitionOut': 'fade',
				'title': this.title,
				'overlayOpacity': '.8',
	            'overlayColor': '#000000',	            
				'width': 640,
				'height': 360,
				'href': this.href.replace(new RegExp("([0-9])","i"),'moogaloop.swf?clip_id=$1'),
				'type': 'swf',
	            'swf': {'wmode': 'transparent', 'allowfullscreen': 'true'}
			}); 
			return false;	
		});
		
	}
	
});